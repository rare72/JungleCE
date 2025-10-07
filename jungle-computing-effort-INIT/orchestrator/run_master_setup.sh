#!/bin/bash
set -e

# --- Configuration ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
SCRIPTS_BASE_DIR="$SCRIPT_DIR/../scripts"
TOTAL_TASKS=32

# --- Helper Functions ---
print_header() {
    echo ""
    echo "====================================================================="
    echo "=> Task $1: $2"
    echo "====================================================================="
}

# --- Pre-flight Checks ---

# 1. Check for sudo privileges and get the original user
if [ "$EUID" -ne 0 ]; then
    echo "Error: This script must be run with sudo privileges."
    echo "Please run as: sudo $0"
    exit 1
fi

# Use SUDO_USER if it's set, otherwise fall back to logname.
# This ensures we get the user who invoked `sudo`.
ORIGINAL_USER="${SUDO_USER:-$(logname)}"
if [ -z "$ORIGINAL_USER" ]; then
    echo "Error: Could not determine the original user."
    exit 1
fi
ORIGINAL_HOME=$(eval echo ~$ORIGINAL_USER)

# 2. Detect OS Family
if [ -f /etc/os-release ]; then
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
    echo "Cannot determine OS distribution. Aborting."
    exit 1
fi

echo "Detected OS Family: $OS_FAMILY"
echo "Running as root, but will execute user-specific tasks as '$ORIGINAL_USER'."

# --- Argument Parsing ---
SKIP_LIST=","
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --skip)
            shift
            while [[ "$#" -gt 0 && ! "$1" =~ ^-- ]]; do
                SKIP_LIST+="$1,"
                shift
            done
            ;;
        *)
            echo "Unknown parameter passed: $1"
            exit 1
            ;;
    esac
done

echo "Tasks to skip: ${SKIP_LIST//,/ }"

# --- Task Definitions ---
declare -A TASKS
TASKS[1]="1_update_system.sh|Update System Packages"
TASKS[2]="2_configure_timezone.sh|Configure Timezone"
TASKS[3]="3_setup_unattended_upgrades.sh|Setup Unattended Upgrades"
TASKS[4]="4_install_build_tools.sh|Install Build Tools"
TASKS[5]="5_install_github_tools.sh|Install GitHub Tools"
TASKS[6]="6_configure_firewall.sh|Configure Firewall"
TASKS[7]="7_harden_ssh_server.sh|Harden SSH Server"
TASKS[8]="8_install_zsh.sh|Install Zsh"
TASKS[9]="9_install_oh_my_zsh.sh|Install Oh My Zsh"
TASKS[10]="10_set_zsh_as_default_shell.sh|Set Zsh as Default Shell"
TASKS[11]="11_create_shell_profile.sh|Create Shell Profile"
TASKS[12]="12_setup_shell_aliases.sh|Setup Shell Aliases"
TASKS[13]="13_install_terminator.sh|Install Terminator"
TASKS[14]="14_install_java_jdk.sh|Install Java (OpenJDK 11)"
TASKS[15]="15_install_python_dev_tools.sh|Install Python Dev Tools"
TASKS[16]="16_install_cli_power_tools.sh|Install CLI Power Tools"
TASKS[17]="17_install_vscode.sh|Install Visual Studio Code"
TASKS[18]="18_install_python3.sh|Install Python 3 and Pip"
TASKS[19]="19_configure_pip.sh|Configure Pip"
TASKS[20]="20_install_pip_packages.sh|Install Core Python Packages"
TASKS[21]="21_install_postgresql_client.sh|Install PostgreSQL Client"
TASKS[22]="22_install_postgresql_server.sh|Install PostgreSQL Server"
TASKS[23]="23_install_csvkit.sh|Install csvkit"
TASKS[24]="24_install_mongodb.sh|Install MongoDB"
TASKS[25]="25_install_quarto.sh|Install Quarto"
TASKS[26]="26_install_dbeaver_ce.sh|Install DBeaver CE"
TASKS[27]="27_install_google_chrome.sh|Install Google Chrome"
TASKS[28]="28_create_chrome_shortcut.sh|Create Chrome Shortcut"
TASKS[29]="29_create_terminator_shortcut.sh|Create Terminator Shortcut"
TASKS[30]="30_create_vscode_shortcut.sh|Create VS Code Shortcut"
TASKS[31]="31_create_dbeaver_shortcut.sh|Create DBeaver Shortcut"
TASKS[32]="32_final_cleanup.sh|Final System Cleanup"

# List of tasks that must be run as the standard user, not as root
USER_TASKS=",9,11,12,19,28,29,30,31,"

# --- Main Execution Loop ---
for i in $(seq 1 $TOTAL_TASKS); do
    if [[ "$SKIP_LIST" == *",$i,"* ]]; then
        DESCRIPTION=$(echo "${TASKS[$i]}" | cut -d'|' -f2)
        echo "--> Skipping Task $i: $DESCRIPTION"
        continue
    fi

    TASK_INFO=${TASKS[$i]}
    SCRIPT_NAME=$(echo "$TASK_INFO" | cut -d'|' -f1)
    DESCRIPTION=$(echo "$TASK_INFO" | cut -d'|' -f2)
    SCRIPT_PATH="$SCRIPTS_BASE_DIR/$SCRIPT_NAME"

    print_header "$i" "$DESCRIPTION"

    if [ ! -f "$SCRIPT_PATH" ]; then
        echo "Warning: Script not found at $SCRIPT_PATH. Skipping."
        continue
    fi

    chmod +x "$SCRIPT_PATH"

    if [[ "$USER_TASKS" == *",$i,"* ]]; then
        echo "Running script as user '$ORIGINAL_USER'..."
        sudo -E -u "$ORIGINAL_USER" "HOME=$ORIGINAL_HOME" "OS_FAMILY=$OS_FAMILY" bash "$SCRIPT_PATH"
    else
        echo "Running script as root..."
        bash "$SCRIPT_PATH"
    fi
done

echo ""
echo "====================================================================="
echo "Orchestration Complete!"
echo "====================================================================="
echo ""
# The final reboot prompt should be run as the user to be visible.
sudo -u "$ORIGINAL_USER" bash "$SCRIPTS_BASE_DIR/33_prompt_for_reboot.sh"