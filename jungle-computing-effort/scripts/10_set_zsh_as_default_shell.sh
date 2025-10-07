#!/bin/bash
set -e

echo "Setting Zsh as the default shell for the current user..."

if ! command -v zsh &> /dev/null; then
    echo "Zsh is not installed. Please run the Zsh installation script first."
    exit 1
fi

ZSH_PATH=$(which zsh)

if [ "$SHELL" == "$ZSH_PATH" ]; then
    echo "Zsh is already the default shell. Skipping."
else
    # The chsh command might require user's password, which is an interactive process.
    # The master script runs with sudo, so we should use `chsh` with the correct user.
    # $USER is not always reliable with sudo. Let's use `logname`.
    CURRENT_USER=$(logname)
    sudo chsh -s "$ZSH_PATH" "$CURRENT_USER"
    echo "Default shell for user '$CURRENT_USER' has been set to Zsh."
    echo "You will need to log out and log back in for this change to take full effect."
fi

echo "Default shell configuration completed."