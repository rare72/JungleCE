#!/bin/bash
set -e

echo "Installing PostgreSQL server..."

if [ -z "$OS_FAMILY" ]; then
    echo "OS_FAMILY environment variable is not set. Aborting."
    exit 1
fi

case "$OS_FAMILY" in
    "Debian")
        sudo apt-get update
        sudo apt-get install -y postgresql
        sudo systemctl enable postgresql
        sudo systemctl start postgresql
        ;;
    "RHEL")
        sudo dnf install -y postgresql-server
        # Initialize the database if it hasn't been already
        if [ ! -f /var/lib/pgsql/data/PG_VERSION ]; then
            echo "Initializing PostgreSQL database..."
            sudo /usr/bin/postgresql-setup --initdb
        fi
        sudo systemctl enable postgresql
        sudo systemctl start postgresql
        ;;
    *)
        echo "Unsupported OS family: $OS_FAMILY"
        exit 1
        ;;
esac

echo "PostgreSQL server installed and enabled successfully."
sudo systemctl status postgresql --no-pager