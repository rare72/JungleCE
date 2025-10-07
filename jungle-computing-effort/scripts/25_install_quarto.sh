#!/bin/bash
set -e

echo "Installing Quarto..."

if [ -z "$OS_FAMILY" ]; then
    echo "OS_FAMILY environment variable is not set. Aborting."
    exit 1
fi

# Use the GitHub API to find the latest release URL
get_latest_url() {
    local pattern=$1
    curl -s "https://api.github.com/repos/quarto-dev/quarto-cli/releases/latest" | \
    jq -r --arg pattern "$pattern" '.assets[] | select(.name | test($pattern)) | .browser_download_url' | \
    head -n 1
}


case "$OS_FAMILY" in
    "Debian")
        echo "Finding latest Quarto .deb package..."
        QUARTO_URL=$(get_latest_url "quarto-.*-linux-amd64.deb")

        if [ -z "$QUARTO_URL" ]; then
            echo "Could not determine latest Quarto .deb URL. Aborting."
            exit 1
        fi

        echo "Downloading Quarto from $QUARTO_URL..."
        wget "$QUARTO_URL" -O /tmp/quarto.deb

        echo "Installing Quarto..."
        sudo apt-get install -y /tmp/quarto.deb
        rm /tmp/quarto.deb
        ;;
    "RHEL")
        echo "Finding latest Quarto tarball for RHEL..."
        QUARTO_URL=$(get_latest_url "quarto-.*-linux-rhel7-amd64.tar.gz")

        if [ -z "$QUARTO_URL" ]; then
            echo "Could not determine latest Quarto tarball URL. Trying generic Linux tarball."
            QUARTO_URL=$(get_latest_url "quarto-.*-linux-amd64.tar.gz")
        fi

        if [ -z "$QUARTO_URL" ]; then
            echo "Could not determine latest Quarto tarball URL. Aborting."
            exit 1
        fi

        echo "Downloading Quarto from $QUARTO_URL..."
        wget "$QUARTO_URL" -O /tmp/quarto.tar.gz

        echo "Installing Quarto to /usr/local/bin..."
        sudo tar -C /tmp -xzf /tmp/quarto.tar.gz
        QUARTO_DIR=$(find /tmp -maxdepth 1 -type d -name "quarto-*")
        sudo cp -r "$QUARTO_DIR/bin/quarto" /usr/local/bin/
        # Also copy the resources for quarto to work correctly
        sudo mkdir -p /usr/local/share/quarto
        sudo cp -r "$QUARTO_DIR/share/quarto" /usr/local/share/
        rm -rf "$QUARTO_DIR"
        rm /tmp/quarto.tar.gz
        ;;
    *)
        echo "Unsupported OS family: $OS_FAMILY"
        exit 1
        ;;
esac

echo "Quarto installed successfully."
quarto --version