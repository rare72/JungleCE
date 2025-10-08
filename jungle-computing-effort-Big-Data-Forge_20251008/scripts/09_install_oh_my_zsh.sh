#!/bin/bash
set -e

echo "Starting Task 9: Install Oh My Zsh"

# Determine the user to install for
if [ -n "$SUDO_USER" ]; then
    INSTALL_USER="$SUDO_USER"
else
    # Fallback if not run with sudo, though the master script should handle this
    INSTALL_USER=$(whoami)
fi
USER_HOME=$(getent passwd "$INSTALL_USER" | cut -d: -f6)

if [ -d "$USER_HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh is already installed for user $INSTALL_USER. Skipping."
    exit 0
fi

echo "Installing Oh My Zsh for user: $INSTALL_USER"

# Install prerequisites
if [ -z "$OS_FAMILY" ]; then
    echo "OS_FAMILY environment variable is not set. Aborting."
    exit 1
fi

case "$OS_FAMILY" in
    "Debian")
        sudo apt-get update
        sudo apt-get install -y curl git
        ;;
    "RHEL")
        sudo dnf install -y curl git
        ;;
    *)
        echo "Unsupported OS family: $OS_FAMILY"
        exit 1
        ;;
esac

# Download and install Oh My Zsh non-interactively
# The installer is run as the target user
sudo -u "$INSTALL_USER" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh) --unattended"

echo "Oh My Zsh installed successfully for $INSTALL_USER."
echo "Task 9 completed successfully."