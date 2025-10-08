#!/bin/bash
set -e

echo "Starting Task 11: Create Shell Profile"

# Determine the user and home directory
if [ -n "$SUDO_USER" ]; then
    TARGET_USER="$SUDO_USER"
else
    TARGET_USER=$(whoami)
fi
USER_HOME=$(getent passwd "$TARGET_USER" | cut -d: -f6)
ZPROFILE_PATH="$USER_HOME/.zprofile"

echo "Ensuring .zprofile exists for user $TARGET_USER..."
sudo -u "$TARGET_USER" touch "$ZPROFILE_PATH"

# Set a default editor if not already set
if ! grep -q "export EDITOR=" "$ZPROFILE_PATH"; then
    echo "Setting default EDITOR to vim in $ZPROFILE_PATH..."
    echo '' | sudo -u "$TARGET_USER" tee -a "$ZPROFILE_PATH" > /dev/null
    echo '# Set default editor' | sudo -u "$TARGET_USER" tee -a "$ZPROFILE_PATH" > /dev/null
    echo 'export EDITOR=vim' | sudo -u "$TARGET_USER" tee -a "$ZPROFILE_PATH" > /dev/null
else
    echo "Default EDITOR is already set in $ZPROFILE_PATH. Skipping."
fi

echo ".zprofile configured successfully."
echo "Task 11 completed successfully."