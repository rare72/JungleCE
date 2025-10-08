#!/bin/bash
set -e

echo "Starting Task 6: Configure Firewall"

if [ -z "$OS_FAMILY" ]; then
    echo "OS_FAMILY environment variable is not set. Aborting."
    exit 1
fi

case "$OS_FAMILY" in
    "Debian")
        echo "Detected Debian-based system. Configuring ufw..."
        sudo apt-get update
        sudo apt-get install -y ufw
        sudo ufw allow ssh
        sudo ufw default deny incoming
        sudo ufw --force enable
        sudo ufw status verbose
        ;;
    "RHEL")
        echo "Detected RHEL-based system. Configuring firewalld..."
        sudo dnf install -y firewalld
        sudo systemctl start firewalld
        sudo systemctl enable firewalld
        sudo firewall-cmd --permanent --add-service=ssh
        sudo firewall-cmd --permanent --set-default-zone=public
        sudo firewall-cmd --reload
        sudo firewall-cmd --list-all
        ;;
    *)
        echo "Unsupported OS family: $OS_FAMILY"
        exit 1
        ;;
esac

echo "Task 6 completed successfully."