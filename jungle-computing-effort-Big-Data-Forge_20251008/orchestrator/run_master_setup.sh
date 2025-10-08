#!/bin/bash
set -e

# ==============================================================================
# Jungle Computing Effort: The Anvil - Master Setup Script
#
# This script orchestrates the entire setup process. It performs OS detection,
# checks for root privileges, and executes the individual setup scripts
# in the correct order. It also allows for skipping specific tasks via the
# --skip command-line flag.
# ==============================================================================

# --- 1. Privilege Check ---
if [ "$(id -u)" -ne 0 ]; then
    echo "Error: This script must be run as root. Please use 'sudo bash $0'."
    exit 1
fi

# --- 2. OS Detection ---
echo "Detecting operating system family..."
if [ -f /etc/os-release ]; then
    # shellcheck source=/dev/null
    . /etc/os-release
    if [[ "$ID_LIKE" == *"debian"* || "$ID" == "debian" || "$ID" == "ubuntu" ]]; then
        export OS_FAMILY="Debian"
    elif [[ "$ID_LIKE" == *"rhel"* || "$ID_LIKE" == *"fedora"* || "$ID" == "rhel" || "$ID" == "fedora" ]]; then
        export OS_FAMILY="RHEL"
    else
        echo "Unsupported Linux distribution: $ID"
        exit 1
    fi
else
    echo "Error: Cannot determine OS distribution from /etc/os-release."
    exit 1
fi
echo "==> Detected OS Family: $OS_FAMILY"
echo ""

# --- 3. Argument Parsing for --skip ---
SKIP_LIST=()
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        --skip)
        shift # past the key
        while [[ $# -gt 0 ]] && ! [[ "$1" =~ ^-- ]]; do
            SKIP_LIST+=("$1")
            shift # past the value
        done
        ;;
        *)
        echo "Unknown option: $1"
        echo "Usage: $0 [--skip <num1> <num2> ...]"
        exit 1
        ;;
    esac
done

if [ ${#SKIP_LIST[@]} -gt 0 ]; then
    echo "==> The following tasks will be skipped: ${SKIP_LIST[*]}"
    echo ""
fi

# --- 4. Execution Logic ---
SCRIPT_DIR="$(dirname "$0")/../scripts"
if [ ! -d "$SCRIPT_DIR" ]; then
    echo "Error: Scripts directory not found at $SCRIPT_DIR"
    exit 1
fi

# Helper function to check if a value exists in an array
containsElement () {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}

# Loop through tasks 1 to 32
for i in $(seq -f "%02g" 1 32); do
    # Get task number without leading zeros for comparison
    TASK_NUM=$(echo "$i" | sed 's/^0*//')

    # Find the script file that starts with the task number
    # Using a glob pattern to find the file
    SCRIPT_FILES=("$SCRIPT_DIR"/"$i"_*.sh)
    SCRIPT_FILE="${SCRIPT_FILES[0]}" # Get the first match

    if [ ! -f "$SCRIPT_FILE" ]; then
        echo "!!! Warning: Script for task $TASK_NUM not found. Skipping. !!!"
        continue
    fi

    SCRIPT_NAME=$(basename "$SCRIPT_FILE")

    if containsElement "$TASK_NUM" "${SKIP_LIST[@]}"; then
        echo "-------------------------------------------------"
        echo ">> SKIPPING Task $TASK_NUM: $SCRIPT_NAME"
        echo "-------------------------------------------------"
        echo ""
    else
        echo "================================================="
        echo ">> EXECUTING Task $TASK_NUM: $SCRIPT_NAME"
        echo "================================================="

        # Execute the script
        bash "$SCRIPT_FILE"

        echo "================================================="
        echo ">> FINISHED Task $TASK_NUM: $SCRIPT_NAME"
        echo "================================================="
        echo ""
    fi
done

echo "*************************************************"
echo "Master setup script has finished executing tasks 1-32."
echo "Please run script 33 manually if you wish to be prompted for a reboot."
echo "Script 34 is available for managing services."
echo "*************************************************"