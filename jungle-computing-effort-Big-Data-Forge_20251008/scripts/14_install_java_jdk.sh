#!/bin/bash
set -e

echo "Starting Task 14: Install Java (OpenJDK 11)"

if [ -z "$OS_FAMILY" ]; then
    echo "OS_FAMILY environment variable is not set. Aborting."
    exit 1
fi

case "$OS_FAMILY" in
    "Debian")
        echo "Detected Debian-based system. Installing OpenJDK 11..."
        sudo apt-get update
        sudo apt-get install -y openjdk-11-jdk
        ;;
    "RHEL")
        echo "Detected RHEL-based system. Installing OpenJDK 11..."
        sudo dnf install -y java-11-openjdk-devel
        ;;
    *)
        echo "Unsupported OS family: $OS_FAMILY"
        exit 1
        ;;
esac

echo "Java installed successfully."
java -version
echo "Task 14 completed successfully."