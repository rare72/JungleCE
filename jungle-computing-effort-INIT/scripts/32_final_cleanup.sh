#!/bin/bash
set -e

echo "Performing final system cleanup..."

if [ -z "$OS_FAMILY" ]; then
    echo "OS_FAMILY environment variable is not set. Aborting."
    exit 1
fi

case "$OS_FAMILY" in
    "Debian")
        sudo apt-get autoremove -y
        sudo apt-get clean
        ;;
    "RHEL")
        sudo dnf autoremove -y
        sudo dnf clean all
        ;;
    *)
        echo "Unsupported OS family: $OS_FAMILY"
        exit 1
        ;;
esac

echo "Final system cleanup completed successfully."