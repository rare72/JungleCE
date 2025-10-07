#!/bin/bash
set -e

echo "Installing MongoDB Community Server..."

if [ -z "$OS_FAMILY" ]; then
    echo "OS_FAMILY environment variable is not set. Aborting."
    exit 1
fi

case "$OS_FAMILY" in
    "Debian")
        echo "Installing MongoDB for Debian-based system..."
        sudo apt-get install -y gnupg curl
        curl -fsSL https://pgp.mongodb.com/server-6.0.asc | \
           sudo gpg -o /usr/share/keyrings/mongodb-server-6.0.gpg \
           --dearmor

        # This assumes a recent Debian/Ubuntu version that supports /etc/apt/sources.list.d
        echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg ] https://repo.mongodb.org/apt/ubuntu $(lsb_release -cs)/mongodb-org/6.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list

        sudo apt-get update
        sudo apt-get install -y mongodb-org
        ;;
    "RHEL")
        echo "Installing MongoDB for RHEL-based system..."
        sudo tee /etc/yum.repos.d/mongodb-org-6.0.repo <<EOF
[mongodb-org-6.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/\$releasever/mongodb-org/6.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-6.0.asc
EOF
        sudo dnf install -y mongodb-org
        ;;
    *)
        echo "Unsupported OS family: $OS_FAMILY"
        exit 1
        ;;
esac

echo "Enabling and starting MongoDB service..."
sudo systemctl enable mongod
sudo systemctl start mongod

echo "MongoDB Community Server installed successfully."
sudo systemctl status mongod --no-pager