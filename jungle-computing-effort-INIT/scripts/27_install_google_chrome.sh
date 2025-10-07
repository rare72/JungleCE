#!/bin/bash
set -e

echo "Installing Google Chrome..."

if [ -z "$OS_FAMILY" ]; then
    echo "OS_FAMILY environment variable is not set. Aborting."
    exit 1
fi

case "$OS_FAMILY" in
    "Debian")
        echo "Downloading Google Chrome .deb package..."
        wget -O /tmp/google-chrome.deb "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"

        echo "Installing Google Chrome..."
        # Use apt install -f to handle any missing dependencies
        sudo apt-get install -y /tmp/google-chrome.deb

        echo "Cleaning up..."
        rm /tmp/google-chrome.deb
        ;;
    "RHEL")
        echo "Adding Google Chrome repository..."
        sudo tee /etc/yum.repos.d/google-chrome.repo <<EOF
[google-chrome]
name=google-chrome
baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
EOF

        echo "Installing Google Chrome..."
        sudo dnf install -y google-chrome-stable
        ;;
    *)
        echo "Unsupported OS family: $OS_FAMILY"
        exit 1
        ;;
esac

echo "Google Chrome installed successfully."