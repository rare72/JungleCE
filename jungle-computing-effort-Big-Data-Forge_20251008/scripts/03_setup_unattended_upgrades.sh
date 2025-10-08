#!/bin/bash
set -e

echo "Starting Task 3: Setup Unattended Upgrades"

if [ -z "$OS_FAMILY" ]; then
    echo "OS_FAMILY environment variable is not set. Aborting."
    exit 1
fi

if [ "$OS_FAMILY" = "Debian" ]; then
    echo "Detected Debian-based system. Installing and configuring unattended-upgrades..."
    sudo apt-get update
    sudo apt-get install -y unattended-upgrades
    sudo dpkg-reconfigure -plow unattended-upgrades
    echo "Unattended upgrades configured."
else
    echo "Skipping for non-Debian system ($OS_FAMILY)."
fi

echo "Task 3 completed successfully."