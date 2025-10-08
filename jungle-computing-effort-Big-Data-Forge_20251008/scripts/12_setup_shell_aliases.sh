#!/bin/bash
set -e

echo "Starting Task 12: Setup Shell Aliases"

# Determine the user and home directory
if [ -n "$SUDO_USER" ]; then
    TARGET_USER="$SUDO_USER"
else
    TARGET_USER=$(whoami)
fi
USER_HOME=$(getent passwd "$TARGET_USER" | cut -d: -f6)
ZSHRC_PATH="$USER_HOME/.zshrc"

# Check if Oh My Zsh has created the .zshrc file
if [ ! -f "$ZSHRC_PATH" ]; then
    echo "Warning: $ZSHRC_PATH not found. Skipping alias setup."
    echo "This may be because Oh My Zsh has not been installed yet."
    exit 0
fi

# Define the aliases to be added
ALIAS_BLOCK="
# Custom Aliases by The Anvil
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
"

# Idempotency check: only add aliases if our marker isn't present
if ! grep -q "# Custom Aliases by The Anvil" "$ZSHRC_PATH"; then
    echo "Adding custom aliases to $ZSHRC_PATH..."
    echo "$ALIAS_BLOCK" | sudo -u "$TARGET_USER" tee -a "$ZSHRC_PATH" > /dev/null
    echo "Aliases added successfully."
else
    echo "Custom aliases already exist in $ZSHRC_PATH. Skipping."
fi

echo "Task 12 completed successfully."