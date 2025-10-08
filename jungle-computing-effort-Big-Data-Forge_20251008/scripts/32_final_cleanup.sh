#!/bin/bash
set -e

echo "Starting Task 32: Final System Cleanup"

if [ -z "$OS_FAMILY" ]; then
    echo "OS_FAMILY environment variable is not set. Aborting."
    exit 1
fi

case "$OS_FAMILY" in
    "Debian")
        echo "Detected Debian-based system. Running apt autoremove and clean..."
        sudo apt-get autoremove -y
        sudo apt-get clean
        ;;
    "RHEL")
        echo "Detected RHEL-based system. Running dnf autoremove and clean..."
        sudo dnf autoremove -y
        sudo dnf clean all
        ;;
    *)
        echo "Unsupported OS family: $OS_FAMILY"
        exit 1
        ;;
esac

echo "Final cleanup completed successfully."
echo "Task 32 completed successfully."