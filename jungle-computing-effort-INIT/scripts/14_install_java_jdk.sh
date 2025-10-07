#!/bin/bash
set -e

echo "Installing OpenJDK 11..."

if [ -z "$OS_FAMILY" ]; then
    echo "OS_FAMILY environment variable is not set. Aborting."
    exit 1
fi

case "$OS_FAMILY" in
    "Debian")
        sudo apt-get update
        sudo apt-get install -y openjdk-11-jdk
        ;;
    "RHEL")
        sudo dnf install -y java-11-openjdk-devel
        ;;
    *)
        echo "Unsupported OS family: $OS_FAMILY"
        exit 1
        ;;
esac

echo "OpenJDK 11 installed successfully."
java -version