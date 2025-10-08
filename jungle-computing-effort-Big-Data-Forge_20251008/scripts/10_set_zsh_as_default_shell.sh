#!/bin/bash
set -e

echo "Starting Task 10: Set Zsh as Default Shell"

if ! command -v zsh &> /dev/null; then
    echo "Zsh is not installed. Please run the Zsh installation script first."
    exit 1
fi

# Determine the user to change the shell for
if [ -n "$SUDO_USER" ]; then
    TARGET_USER="$SUDO_USER"
else
    TARGET_USER=$(whoami)
fi

echo "Changing default shell to Zsh for user: $TARGET_USER"
sudo chsh -s "$(which zsh)" "$TARGET_USER"

echo "Default shell for $TARGET_USER has been changed to Zsh."
echo "Please log out and log back in for the change to take effect."
echo "Task 10 completed successfully."