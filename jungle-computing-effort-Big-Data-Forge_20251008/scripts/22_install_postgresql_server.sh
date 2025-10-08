#!/bin/bash
set -e

echo "Starting Task 22: Install PostgreSQL Server"

if [ -z "$OS_FAMILY" ]; then
    echo "OS_FAMILY environment variable is not set. Aborting."
    exit 1
fi

case "$OS_FAMILY" in
    "Debian")
        echo "Detected Debian-based system. Installing postgresql server..."
        sudo apt-get update
        sudo apt-get install -y postgresql
        ;;
    "RHEL")
        echo "Detected RHEL-based system. Installing postgresql-server..."
        sudo dnf install -y postgresql-server
        # Initialize the database on RHEL-based systems
        sudo postgresql-setup --initdb
        ;;
    *)
        echo "Unsupported OS family: $OS_FAMILY"
        exit 1
        ;;
esac

echo "Enabling and starting PostgreSQL service..."
sudo systemctl enable --now postgresql

echo "PostgreSQL server installed and enabled successfully."
sudo systemctl status postgresql --no-pager
echo "Task 22 completed successfully."