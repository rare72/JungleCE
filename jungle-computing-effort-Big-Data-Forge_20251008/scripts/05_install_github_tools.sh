#!/bin/bash
set -e

echo "Starting Task 5: Install GitHub Tools"

if [ -z "$OS_FAMILY" ]; then
    echo "OS_FAMILY environment variable is not set. Aborting."
    exit 1
fi

# Install GitHub CLI
echo "Installing GitHub CLI (gh)..."
case "$OS_FAMILY" in
    "Debian")
        (type -p gpg >/dev/null || (sudo apt-get update && sudo apt-get install -y gpg)) && \
        curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/githubcli-archive-keyring.gpg && \
        sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg && \
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null && \
        sudo apt-get update && \
        sudo apt-get install -y gh
        ;;
    "RHEL")
        sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
        sudo dnf install -y gh
        ;;
    *)
        echo "Unsupported OS family: $OS_FAMILY"
        exit 1
        ;;
esac
echo "GitHub CLI installed successfully."

# Install GitHub Desktop
echo "Installing GitHub Desktop..."
GH_DESKTOP_VERSION="3.3.4-linux1"
GH_DESKTOP_URL_BASE="https://github.com/shiftkey/desktop/releases/download/release-${GH_DESKTOP_VERSION}"

case "$OS_FAMILY" in
    "Debian")
        (type -p wget >/dev/null || (sudo apt-get update && sudo apt-get install -y wget)) && \
        GH_DESKTOP_PKG="GitHubDesktop-linux-${GH_DESKTOP_VERSION}.deb"
        wget "${GH_DESKTOP_URL_BASE}/${GH_DESKTOP_PKG}" -O /tmp/github-desktop.deb
        sudo apt-get install -y /tmp/github-desktop.deb
        rm /tmp/github-desktop.deb
        ;;
    "RHEL")
        (type -p wget >/dev/null || (sudo dnf install -y wget)) && \
        GH_DESKTOP_PKG="GitHubDesktop-linux-${GH_DESKTOP_VERSION}.rpm"
        wget "${GH_DESKTOP_URL_BASE}/${GH_DESKTOP_PKG}" -O /tmp/github-desktop.rpm
        sudo dnf install -y /tmp/github-desktop.rpm
        rm /tmp/github-desktop.rpm
        ;;
esac
echo "GitHub Desktop installed successfully."

echo "Task 5 completed successfully."