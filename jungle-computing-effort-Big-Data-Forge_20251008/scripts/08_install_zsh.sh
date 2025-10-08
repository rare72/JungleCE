#!/bin/bash
set -e

echo "Starting Task 8: Install Zsh"

if [ -z "$OS_FAMILY" ]; then
    echo "OS_FAMILY environment variable is not set. Aborting."
    exit 1
fi

case "$OS_FAMILY" in
    "Debian")
        echo "Detected Debian-based system. Installing zsh..."
        sudo apt-get update
        sudo apt-get install -y zsh
        ;;
    "RHEL")
        echo "Detected RHEL-based system. Installing zsh..."
        sudo dnf install -y zsh
        ;;
    *)
        echo "Unsupported OS family: $OS_FAMILY"
        exit 1
        ;;
esac

echo "Zsh installed successfully: $(zsh --version)"
echo "Task 8 completed successfully."