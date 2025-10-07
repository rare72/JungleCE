#!/bin/bash
set -e

echo "Installing DBeaver Community Edition..."

if [ -z "$OS_FAMILY" ]; then
    echo "OS_FAMILY environment variable is not set. Aborting."
    exit 1
fi

case "$OS_FAMILY" in
    "Debian")
        echo "Downloading DBeaver .deb package..."
        wget -O /tmp/dbeaver.deb "https://dbeaver.io/files/dbeaver-ce-latest-linux.deb"

        echo "Installing DBeaver..."
        sudo apt-get update
        # Use apt install -f to handle any missing dependencies
        sudo apt-get install -y /tmp/dbeaver.deb

        echo "Cleaning up..."
        rm /tmp/dbeaver.deb
        ;;
    "RHEL")
        echo "Downloading DBeaver .rpm package..."
        wget -O /tmp/dbeaver.rpm "https://dbeaver.io/files/dbeaver-ce-latest-linux.rpm"

        echo "Installing DBeaver..."
        sudo dnf install -y /tmp/dbeaver.rpm

        echo "Cleaning up..."
        rm /tmp/dbeaver.rpm
        ;;
    *)
        echo "Unsupported OS family: $OS_FAMILY"
        exit 1
        ;;
esac

echo "DBeaver Community Edition installed successfully."