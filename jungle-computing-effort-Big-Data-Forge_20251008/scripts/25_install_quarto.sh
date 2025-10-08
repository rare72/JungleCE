#!/bin/bash
set -e

echo "Starting Task 25: Install Quarto"

QUARTO_VERSION="1.4.553" # Using a recent stable version
QUARTO_URL_BASE="https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}"

if [ -z "$OS_FAMILY" ]; then
    echo "OS_FAMILY environment variable is not set. Aborting."
    exit 1
fi

# Ensure wget is installed
case "$OS_FAMILY" in
    "Debian")
        (type -p wget >/dev/null || (sudo apt-get update && sudo apt-get install -y wget))
        ;;
    "RHEL")
        (type -p wget >/dev/null || (sudo dnf install -y wget))
        ;;
esac

echo "Downloading Quarto v${QUARTO_VERSION}..."

case "$OS_FAMILY" in
    "Debian")
        QUARTO_PKG="quarto-${QUARTO_VERSION}-linux-amd64.deb"
        wget "${QUARTO_URL_BASE}/${QUARTO_PKG}" -O /tmp/quarto.deb
        echo "Installing Quarto..."
        # Use apt to handle dependencies
        sudo apt-get install -y /tmp/quarto.deb
        rm /tmp/quarto.deb
        ;;
    "RHEL")
        QUARTO_PKG="quarto-${QUARTO_VERSION}-linux-amd64.rpm"
        wget "${QUARTO_URL_BASE}/${QUARTO_PKG}" -O /tmp/quarto.rpm
        echo "Installing Quarto..."
        sudo dnf install -y /tmp/quarto.rpm
        rm /tmp/quarto.rpm
        ;;
    *)
        echo "Unsupported OS family: $OS_FAMILY"
        exit 1
        ;;
esac

echo "Quarto installed successfully."
quarto --version
echo "Task 25 completed successfully."