#!/bin/bash
set -e

echo "Starting Task 16: Install CLI Power Tools"

if [ -z "$OS_FAMILY" ]; then
    echo "OS_FAMILY environment variable is not set. Aborting."
    exit 1
fi

TOOLS="jq htop tree ncdu"

case "$OS_FAMILY" in
    "Debian")
        echo "Detected Debian-based system. Installing $TOOLS..."
        sudo apt-get update
        sudo apt-get install -y $TOOLS
        ;;
    "RHEL")
        echo "Detected RHEL-based system. Installing $TOOLS..."
        # ncdu is in EPEL for some RHEL versions
        sudo dnf install -y epel-release
        sudo dnf install -y $TOOLS
        ;;
    *)
        echo "Unsupported OS family: $OS_FAMILY"
        exit 1
        ;;
esac

echo "CLI power tools installed successfully."
echo "Task 16 completed successfully."