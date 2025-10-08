#!/bin/bash
set -e

echo "Starting Task 21: Install PostgreSQL Client"

if [ -z "$OS_FAMILY" ]; then
    echo "OS_FAMILY environment variable is not set. Aborting."
    exit 1
fi

case "$OS_FAMILY" in
    "Debian")
        echo "Detected Debian-based system. Installing postgresql-client..."
        sudo apt-get update
        sudo apt-get install -y postgresql-client
        ;;
    "RHEL")
        echo "Detected RHEL-based system. Installing postgresql..."
        sudo dnf install -y postgresql
        ;;
    *)
        echo "Unsupported OS family: $OS_FAMILY"
        exit 1
        ;;
esac

echo "PostgreSQL client (psql) installed successfully."
psql --version
echo "Task 21 completed successfully."