#!/bin/bash
set -e

echo "Configuring firewall..."

if [ -z "$OS_FAMILY" ]; then
    echo "OS_FAMILY environment variable is not set. Aborting."
    exit 1
fi

case "$OS_FAMILY" in
    "Debian")
        sudo apt-get install -y ufw
        sudo ufw allow ssh
        sudo ufw default deny incoming
        sudo ufw --force enable
        sudo ufw status verbose
        echo "UFW firewall configured for Debian-based system."
        ;;
    "RHEL")
        sudo systemctl start firewalld
        sudo systemctl enable firewalld
        sudo firewall-cmd --permanent --add-service=ssh
        sudo firewall-cmd --reload
        sudo firewall-cmd --list-all
        echo "Firewalld configured for RHEL-based system."
        ;;
    *)
        echo "Unsupported OS family: $OS_FAMILY"
        exit 1
        ;;
esac

echo "Firewall configuration completed."