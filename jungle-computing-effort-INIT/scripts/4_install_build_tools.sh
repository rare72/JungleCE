#!/bin/bash
set -e

echo "Installing build tools..."

if [ -z "$OS_FAMILY" ]; then
    echo "OS_FAMILY environment variable is not set. Aborting."
    exit 1
fi

case "$OS_FAMILY" in
    "Debian")
        sudo apt-get install -y build-essential
        ;;
    "RHEL")
        sudo dnf groupinstall -y "Development Tools"
        ;;
    *)
        echo "Unsupported OS family: $OS_FAMILY"
        exit 1
        ;;
esac

echo "Build tools installed successfully."