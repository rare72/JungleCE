#!/bin/bash
set -e

# ==============================================================================
# Jungle Computing Effort: The Anvil - Test Script
#
# This script performs basic validation on the project structure and the
# master orchestrator script's logic.
# ==============================================================================

# --- Test Variables ---
TEST_SUCCESS_COUNT=0
TEST_FAILURE_COUNT=0
BASE_DIR="$(dirname "$0")/.."
SCRIPTS_DIR="$BASE_DIR/scripts"
ORCHESTRATOR_SCRIPT="$BASE_DIR/orchestrator/run_master_setup.sh"

# --- Helper Functions ---
_print_pass() {
    echo -e "\033[0;32mPASS\033[0m: $1"
    ((TEST_SUCCESS_COUNT++))
}

_print_fail() {
    echo -e "\033[0;31mFAIL\033[0m: $1"
    ((TEST_FAILURE_COUNT++))
}

# --- Test Case 1: Validate Existence of All 34 Scripts ---
echo "--- Running Test Case 1: Validate Script Existence ---"
ALL_SCRIPTS_EXIST=true
for i in $(seq -f "%02g" 1 34); do
    # Find script file matching the pattern
    SCRIPT_FILES=("$SCRIPTS_DIR"/"$i"_*.sh)
    SCRIPT_FILE="${SCRIPT_FILES[0]}"

    if [ ! -f "$SCRIPT_FILE" ]; then
        echo "Missing script for task $i"
        ALL_SCRIPTS_EXIST=false
    fi
done

if [ "$ALL_SCRIPTS_EXIST" = true ]; then
    _print_pass "All 34 scripts were found in the scripts/ directory."
else
    _print_fail "One or more scripts are missing from the scripts/ directory."
fi
echo ""

# --- Test Case 2: Validate Master Script --skip Logic ---
echo "--- Running Test Case 2: Validate --skip Logic ---"
TEMP_MASTER_SCRIPT="/tmp/run_master_setup_test.sh"

# Create a modified master script for testing
# 1. Disable the root check by changing the condition to 'if false'
# 2. Comment out the actual script execution command to prevent side-effects
sed 's/if \[ "$(id -u)" -ne 0 \]/if false/' "$ORCHESTRATOR_SCRIPT" | \
sed 's/bash "$SCRIPT_FILE"/# bash "$SCRIPT_FILE"/' > "$TEMP_MASTER_SCRIPT"
chmod +x "$TEMP_MASTER_SCRIPT"

# Run the modified script with --skip and capture its output.
# We must export OS_FAMILY because the test subshell is non-interactive
# and cannot determine the OS, which would cause the script to exit.
SKIP_TASKS=("5" "27")
TEST_OUTPUT=$(export OS_FAMILY="Debian" && "$TEMP_MASTER_SCRIPT" --skip "${SKIP_TASKS[@]}" 2>&1)

# Check if the skipped tasks were correctly identified in the output
SKIP_LOGIC_PASS=true
for task_num in "${SKIP_TASKS[@]}"; do
    if ! echo "$TEST_OUTPUT" | grep -q ">> SKIPPING Task $task_num"; then
        echo "Master script did not correctly report skipping task $task_num."
        SKIP_LOGIC_PASS=false
    fi
done

# Check that a non-skipped task was reported as executing
if ! echo "$TEST_OUTPUT" | grep -q ">> EXECUTING Task 6"; then
    echo "Master script did not report executing a non-skipped task (Task 6)."
    SKIP_LOGIC_PASS=false
fi

# Clean up the temporary script
rm "$TEMP_MASTER_SCRIPT"

if [ "$SKIP_LOGIC_PASS" = true ]; then
    _print_pass "Master script correctly handles the --skip argument."
else
    _print_fail "Master script failed to handle the --skip argument correctly."
fi
echo ""

# --- Test Summary ---
echo "--- Test Summary ---"
echo "Total Tests: $((TEST_SUCCESS_COUNT + TEST_FAILURE_COUNT))"
echo -e "  \033[0;32mPassed: $TEST_SUCCESS_COUNT\033[0m"
echo -e "  \033[0;31mFailed: $TEST_FAILURE_COUNT\033[0m"
echo ""

if [ "$TEST_FAILURE_COUNT" -ne 0 ]; then
    echo "One or more tests failed."
    exit 1
else
    echo "All tests passed successfully."
    exit 0
fi