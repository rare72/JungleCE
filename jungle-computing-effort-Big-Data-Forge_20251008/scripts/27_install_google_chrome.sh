#!/bin/bash
set -e

echo "Starting Task 27: Install Google Chrome"

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

echo "Downloading Google Chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/google-chrome.deb

case "$OS_FAMILY" in
    "Debian")
        echo "Installing Google Chrome for Debian-based system..."
        # Use apt to handle dependencies
        sudo apt-get install -y /tmp/google-chrome.deb
        ;;
    "RHEL")
        echo "Installing Google Chrome for RHEL-based system..."
        # RHEL systems can use the .deb if they have alien, but it's better to use the official repo.
        # For simplicity, we'll add the repo.
        sudo tee /etc/yum.repos.d/google-chrome.repo > /dev/null <<EOF
[google-chrome]
name=google-chrome
baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64
enabled=1
gpgcheck=1
gpgkey=https://dl.google.com/linux/linux_signing_key.pub
EOF
        sudo dnf install -y google-chrome-stable
        # Clean up the downloaded .deb file as it's not used on RHEL
        rm /tmp/google-chrome.deb
        ;;
    *)
        echo "Unsupported OS family: $OS_FAMILY"
        exit 1
        ;;
esac

# Clean up the downloaded .deb file if it was used
[ -f /tmp/google-chrome.deb ] && rm /tmp/google-chrome.deb

echo "Google Chrome installed successfully."
echo "Task 27 completed successfully."