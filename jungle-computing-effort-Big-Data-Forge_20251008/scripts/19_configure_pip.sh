#!/bin/bash
set -e

echo "Starting Task 19: Configure Pip"

# Determine the user and home directory
if [ -n "$SUDO_USER" ]; then
    TARGET_USER="$SUDO_USER"
else
    TARGET_USER=$(whoami)
fi
USER_HOME=$(getent passwd "$TARGET_USER" | cut -d: -f6)
PIP_CONFIG_DIR="$USER_HOME/.config/pip"
PIP_CONFIG_FILE="$PIP_CONFIG_DIR/pip.conf"

echo "Creating pip configuration for user $TARGET_USER..."

# Create the directory as the target user
sudo -u "$TARGET_USER" mkdir -p "$PIP_CONFIG_DIR"

# Create the pip.conf file if it doesn't exist
if [ ! -f "$PIP_CONFIG_FILE" ]; then
    echo "Creating $PIP_CONFIG_FILE..."
    sudo -u "$TARGET_USER" tee "$PIP_CONFIG_FILE" > /dev/null <<EOF
[global]
timeout = 60
EOF
    echo "pip.conf created successfully."
else
    echo "$PIP_CONFIG_FILE already exists. Skipping creation."
fi

echo "Task 19 completed successfully."