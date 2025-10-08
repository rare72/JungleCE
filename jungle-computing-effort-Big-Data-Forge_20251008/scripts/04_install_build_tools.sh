#!/bin/bash
set -e

echo "Starting Task 4: Install Build Tools"

if [ -z "$OS_FAMILY" ]; then
    echo "OS_FAMILY environment variable is not set. Aborting."
    exit 1
fi

case "$OS_FAMILY" in
    "Debian")
        echo "Detected Debian-based system. Installing build-essential..."
        sudo apt-get update
        sudo apt-get install -y build-essential
        ;;
    "RHEL")
        echo "Detected RHEL-based system. Installing Development Tools..."
        sudo dnf groupinstall -y "Development Tools"
        ;;
    *)
        echo "Unsupported OS family: $OS_FAMILY"
        exit 1
        ;;
esac

echo "Task 4 completed successfully."