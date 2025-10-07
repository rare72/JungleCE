#!/bin/bash
set -e

echo "Installing Python 3 and Pip..."

if [ -z "$OS_FAMILY" ]; then
    echo "OS_FAMILY environment variable is not set. Aborting."
    exit 1
fi

case "$OS_FAMILY" in
    "Debian")
        sudo apt-get update
        sudo apt-get install -y python3 python3-pip
        ;;
    "RHEL")
        sudo dnf install -y python3 python3-pip
        ;;
    *)
        echo "Unsupported OS family: $OS_FAMILY"
        exit 1
        ;;
esac

echo "Python 3 and Pip installed successfully."
python3 --version
pip3 --version