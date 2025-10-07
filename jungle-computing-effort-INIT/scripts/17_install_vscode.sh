#!/bin/bash
set -e

echo "Installing Visual Studio Code..."

if [ -z "$OS_FAMILY" ]; then
    echo "OS_FAMILY environment variable is not set. Aborting."
    exit 1
fi

case "$OS_FAMILY" in
    "Debian")
        echo "Installing VS Code for Debian-based system..."
        sudo apt-get install -y wget gpg
        wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
        sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
        sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
        rm -f packages.microsoft.gpg

        sudo apt-get install -y apt-transport-https
        sudo apt-get update
        sudo apt-get install -y code
        ;;
    "RHEL")
        echo "Installing VS Code for RHEL-based system..."
        sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
        sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

        sudo dnf check-update
        sudo dnf install -y code
        ;;
    *)
        echo "Unsupported OS family: $OS_FAMILY"
        exit 1
        ;;
esac

echo "Visual Studio Code installed successfully."