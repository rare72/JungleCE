#!/bin/bash

# --- Test Harness for Jungle Computing Effort ---
# This script performs functional tests on a subset of the setup scripts.
# It uses a temporary directory to avoid modifying the actual system.

# --- Configuration ---
TEST_DIR="/tmp/jce_test_harness"
SCRIPTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)/../scripts"
export HOME="$TEST_DIR/fake_home" # Override HOME for user-space tests

# --- Test Utilities ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

assert_success() {
    echo -e "  [${GREEN}PASS${NC}] $1"
}

assert_fail() {
    echo -e "  [${RED}FAIL${NC}] $1"
    # In a real test suite, we might exit here. For this harness, we'll continue.
}

setup() {
    echo -e "${YELLOW}Setting up test environment in $TEST_DIR...${NC}"
    rm -rf "$TEST_DIR"
    mkdir -p "$HOME"
    # Create a mock for systemctl
    mkdir -p "$TEST_DIR/bin"
    export PATH="$TEST_DIR/bin:$PATH"
    cat > "$TEST_DIR/bin/systemctl" <<'EOF'
#!/bin/bash
echo "Mock systemctl called with: $@" >> /tmp/jce_test_harness/systemctl.log
EOF
    chmod +x "$TEST_DIR/bin/systemctl"
    # The management script uses `sudo`, so we mock that too.
    cat > "$TEST_DIR/bin/sudo" <<'EOF'
#!/bin/bash
# Execute the command passed to sudo
"$@"
EOF
    chmod +x "$TEST_DIR/bin/sudo"
    # Clear any previous logs
    rm -f "$TEST_DIR/systemctl.log"
}

teardown() {
    echo -e "${YELLOW}Tearing down test environment...${NC}"
    rm -rf "$TEST_DIR"
    echo "Done."
}

# --- Test Cases ---

# Test 1: Verify that the alias script correctly creates and modifies .zshrc
test_alias_script() {
    echo "Running Test: Alias Script"
    local SCRIPT_PATH="$SCRIPTS_DIR/12_setup_shell_aliases.sh"
    local ZSHRC_FILE="$HOME/.zshrc"

    # First run: Should create the file and add aliases
    bash "$SCRIPT_PATH" > /dev/null
    if [ -f "$ZSHRC_FILE" ] && grep -q "alias ll='ls -alF'" "$ZSHRC_FILE"; then
        assert_success "File .zshrc created and alias found on first run."
    else
        assert_fail "File .zshrc was not created or alias is missing."
    fi

    # Second run: Should detect existing aliases and skip
    local output
    output=$(bash "$SCRIPT_PATH")
    if echo "$output" | grep -q "Skipping"; then
        assert_success "Idempotency check passed (skipped on second run)."
    else
        assert_fail "Idempotency check failed (did not skip on second run)."
    fi
}

# Test 2: Verify that scripts fail gracefully if OS_FAMILY is not set
test_os_family_check() {
    echo "Running Test: OS_FAMILY Environment Variable Check"
    local SCRIPT_PATH="$SCRIPTS_DIR/1_update_system.sh"

    # Run without OS_FAMILY set, expecting an error
    local output
    # Unset variable for the scope of this command
    output=$(unset OS_FAMILY; bash "$SCRIPT_PATH" 2>&1 || true)

    if echo "$output" | grep -q "OS_FAMILY environment variable is not set"; then
        assert_success "Script correctly failed when OS_FAMILY was not set."
    else
        assert_fail "Script did not fail as expected when OS_FAMILY was missing."
    fi
}

# Test 3: Verify the logic of the service management script
test_manage_services_script() {
    echo "Running Test: Service Management Script"
    local SCRIPT_PATH="$SCRIPTS_DIR/34_manage_postgres_mongo_services.sh"
    local LOG_FILE="$TEST_DIR/systemctl.log"

    # Test help message
    local output
    output=$(bash "$SCRIPT_PATH" 2>&1 || true)
    if echo "$output" | grep -q "Usage:"; then
        assert_success "Help message shown for invalid arguments."
    else
        assert_fail "Help message was not shown for invalid arguments."
    fi

    # Test enable postgres
    rm -f "$LOG_FILE"
    bash "$SCRIPT_PATH" enable postgres > /dev/null
    if grep -q "enable postgresql" "$LOG_FILE" && grep -q "start postgresql" "$LOG_FILE"; then
        assert_success "Correctly called systemctl to enable and start postgres."
    else
        assert_fail "Did not call systemctl correctly for 'enable postgres'."
    fi

    # Test disable mongo
    rm -f "$LOG_FILE"
    bash "$SCRIPT_PATH" disable mongo > /dev/null
    if grep -q "stop mongod" "$LOG_FILE" && grep -q "disable mongod" "$LOG_FILE"; then
        assert_success "Correctly called systemctl to disable and stop mongo."
    else
        assert_fail "Did not call systemctl correctly for 'disable mongo'."
    fi
}


# --- Main Runner ---
main() {
    setup
    echo ""

    # Run all tests
    test_alias_script
    test_os_family_check
    test_manage_services_script

    echo ""
    teardown
}

main