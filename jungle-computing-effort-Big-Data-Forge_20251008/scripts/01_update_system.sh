#!/bin/bash
set -e

echo "Starting Task 1: System Update"

if [ -z "$OS_FAMILY" ]; then
    echo "OS_FAMILY environment variable is not set. Aborting."
    exit 1
fi

case "$OS_FAMILY" in
    "Debian")
        echo "Detected Debian-based system. Updating with apt..."
        sudo apt-get update
        sudo apt-get upgrade -y
        ;;
    "RHEL")
        echo "Detected RHEL-based system. Updating with dnf..."
        sudo dnf upgrade -y
        ;;
    *)
        echo "Unsupported OS family: $OS_FAMILY"
        exit 1
        ;;
esac

echo "Task 1 completed successfully."