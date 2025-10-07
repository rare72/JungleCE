#!/bin/bash
set -e

echo "Installing GitHub tools (CLI and Desktop)..."

if [ -z "$OS_FAMILY" ]; then
    echo "OS_FAMILY environment variable is not set. Aborting."
    exit 1
fi

case "$OS_FAMILY" in
    "Debian")
        echo "Installing GitHub CLI for Debian-based system..."
        sudo apt-get update
        sudo apt-get install -y curl
        curl -fsSL https://cli.github.com/packages/githubcli-archive-key.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
        sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
        sudo apt-get update
        sudo apt-get install -y gh

        echo "Installing GitHub Desktop for Debian-based system..."
        LATEST_URL=$(curl -s "https://api.github.com/repos/shiftkey/desktop/releases/latest" | jq -r '.assets[] | select(.name | test("linux-amd64.*.deb$")) | .browser_download_url')
        if [ -n "$LATEST_URL" ]; then
            wget "$LATEST_URL" -O /tmp/github-desktop.deb
            sudo apt-get install -y /tmp/github-desktop.deb
            rm /tmp/github-desktop.deb
        else
            echo "Could not find latest GitHub Desktop .deb package. Skipping."
        fi
        ;;
    "RHEL")
        echo "Installing GitHub CLI for RHEL-based system..."
        sudo dnf install -y 'dnf-command(config-manager)'
        sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
        sudo dnf install -y gh
        echo "GitHub Desktop is not officially available for RHEL-based systems. Skipping."
        ;;
    *)
        echo "Unsupported OS family: $OS_FAMILY"
        exit 1
        ;;
esac

echo "GitHub tools installation completed."