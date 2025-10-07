#!/bin/bash
set -e

echo "Installing Terminator..."

if [ -z "$OS_FAMILY" ]; then
    echo "OS_FAMILY environment variable is not set. Aborting."
    exit 1
fi

case "$OS_FAMILY" in
    "Debian")
        sudo apt-get update
        sudo apt-get install -y terminator
        ;;
    "RHEL")
        sudo dnf install -y terminator
        ;;
    *)
        echo "Unsupported OS family: $OS_FAMILY"
        exit 1
        ;;
esac

echo "Terminator installed successfully."