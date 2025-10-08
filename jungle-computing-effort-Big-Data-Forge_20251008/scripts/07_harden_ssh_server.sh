#!/bin/bash
set -e

echo "Starting Task 7: Harden SSH Server"

SSHD_CONFIG_FILE="/etc/ssh/sshd_config"

echo "Disabling root login and password authentication in SSH..."

# Ensure the settings are present and set correctly.
# Remove existing lines and append the correct ones to avoid duplicates.
sudo sed -i '/^PermitRootLogin/d' "$SSHD_CONFIG_FILE"
sudo sed -i '/^PasswordAuthentication/d' "$SSHD_CONFIG_FILE"

echo "PermitRootLogin no" | sudo tee -a "$SSHD_CONFIG_FILE"
echo "PasswordAuthentication no" | sudo tee -a "$SSHD_CONFIG_FILE"

echo "SSH configuration updated:"
grep -E "PermitRootLogin|PasswordAuthentication" "$SSHD_CONFIG_FILE"

if [ -z "$OS_FAMILY" ]; then
    echo "OS_FAMILY environment variable is not set. Aborting."
    exit 1
fi

echo "Restarting SSH service..."
case "$OS_FAMILY" in
    "Debian")
        sudo systemctl restart ssh
        ;;
    "RHEL")
        sudo systemctl restart sshd
        ;;
    *)
        echo "Unsupported OS family: $OS_FAMILY. Cannot restart SSH."
        exit 1
        ;;
esac

echo "SSH service restarted."
echo "Task 7 completed successfully."