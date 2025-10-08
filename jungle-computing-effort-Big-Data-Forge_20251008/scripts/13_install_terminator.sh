#!/bin/bash
set -e

echo "Starting Task 13: Install Terminator"

if [ -z "$OS_FAMILY" ]; then
    echo "OS_FAMILY environment variable is not set. Aborting."
    exit 1
fi

case "$OS_FAMILY" in
    "Debian")
        echo "Detected Debian-based system. Installing Terminator..."
        sudo apt-get update
        sudo apt-get install -y terminator
        ;;
    "RHEL")
        echo "Detected RHEL-based system. Installing Terminator..."
        # Terminator is in the EPEL repository for RHEL-based systems
        sudo dnf install -y epel-release
        sudo dnf install -y terminator
        ;;
    *)
        echo "Unsupported OS family: $OS_FAMILY"
        exit 1
        ;;
esac

echo "Terminator installed successfully."
echo "Task 13 completed successfully."