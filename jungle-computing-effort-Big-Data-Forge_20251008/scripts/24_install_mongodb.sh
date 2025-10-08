#!/bin/bash
set -e

echo "Starting Task 24: Install MongoDB Community Server"

if [ -z "$OS_FAMILY" ]; then
    echo "OS_FAMILY environment variable is not set. Aborting."
    exit 1
fi

case "$OS_FAMILY" in
    "Debian")
        echo "Detected Debian-based system. Installing MongoDB..."
        sudo apt-get update
        sudo apt-get install -y gnupg curl

        # Import the public key used by the package management system
        curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
           sudo gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \           --dearmor

        # Create the list file for your version of Ubuntu/Debian
        # This example is for Ubuntu 22.04 (Jammy)
        # For other versions, this line might need adjustment.
        echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/7.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-7.0.list

        sudo apt-get update
        sudo apt-get install -y mongodb-org
        ;;
    "RHEL")
        echo "Detected RHEL-based system. Installing MongoDB..."
        MONGO_REPO_FILE="/etc/yum.repos.d/mongodb-org-7.0.repo"
        if [ ! -f "$MONGO_REPO_FILE" ]; then
            echo "Creating MongoDB repo file..."
            sudo tee "$MONGO_REPO_FILE" > /dev/null <<EOF
[mongodb-org-7.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/\$releasever/mongodb-org/7.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-7.0.asc
EOF
        else
            echo "MongoDB repo file already exists. Skipping creation."
        fi
        sudo dnf install -y mongodb-org
        ;;
    *)
        echo "Unsupported OS family: $OS_FAMILY"
        exit 1
        ;;
esac

echo "Enabling and starting MongoDB service..."
sudo systemctl daemon-reload
sudo systemctl enable --now mongod

echo "MongoDB installed and enabled successfully."
sudo systemctl status mongod --no-pager
echo "Task 24 completed successfully."