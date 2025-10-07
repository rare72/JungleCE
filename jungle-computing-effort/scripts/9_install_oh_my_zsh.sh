#!/bin/bash
set -e

echo "Installing Oh My Zsh..."

if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh is already installed. Skipping."
else
    # The installer script runs `zsh` at the end, which exits the script.
    # We use `sh -c '...'` and expect it to work.
    # The `CHSH=no` and `RUNZSH=no` prevent it from changing the shell or running zsh.
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
    echo "Oh My Zsh installed successfully."
fi