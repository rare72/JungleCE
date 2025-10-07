#!/bin/bash
set -e

echo "Setting up unattended upgrades..."

if [ -z "$OS_FAMILY" ]; then
    echo "OS_FAMILY environment variable is not set. Aborting."
    exit 1
fi

case "$OS_FAMILY" in
    "Debian")
        sudo apt-get install -y unattended-upgrades
        sudo dpkg-reconfigure -plow unattended-upgrades
        echo "Unattended upgrades configured for Debian-based system."
        ;;
    "RHEL")
        echo "Unattended upgrades setup is specific to Debian and will be skipped for RHEL-based systems."
        # RHEL/CentOS uses dnf-automatic, which could be an alternative implementation
        ;;
    *)
        echo "Unsupported OS family: $OS_FAMILY"
        exit 1
        ;;
esac

echo "Unattended upgrades setup completed."