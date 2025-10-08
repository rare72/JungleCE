#!/bin/bash
set -e

echo "Starting Task 26: Install DBeaver Community Edition"

if [ -z "$OS_FAMILY" ]; then
    echo "OS_FAMILY environment variable is not set. Aborting."
    exit 1
fi

case "$OS_FAMILY" in
    "Debian")
        echo "Detected Debian-based system. Installing DBeaver CE..."
        # Ensure prerequisites are installed
        sudo apt-get update
        sudo apt-get install -y curl gpg

        # Add DBeaver GPG key using the recommended modern approach
        curl -fsSL https://dbeaver.io/debs/dbeaver.gpg | sudo gpg --dearmor -o /usr/share/keyrings/dbeaver.gpg

        # Add DBeaver repository
        echo "deb [signed-by=/usr/share/keyrings/dbeaver.gpg] https://dbeaver.io/debs/dbeaver-ce /" | sudo tee /etc/apt/sources.list.d/dbeaver.list

        # Update and install
        sudo apt-get update
        sudo apt-get install -y dbeaver-ce
        ;;
    "RHEL")
        echo "Detected RHEL-based system. Installing DBeaver CE..."
        # Import GPG key
        sudo rpm --import https://dbeaver.io/debs/dbeaver.gpg

        # Add DBeaver repository configuration
        sudo tee /etc/yum.repos.d/dbeaver.repo > /dev/null <<EOF
[dbeaver]
name=DBeaver Community Edition
baseurl=https://dbeaver.io/rpm/dbeaver-ce/
enabled=1
gpgcheck=1
gpgkey=https://dbeaver.io/debs/dbeaver.gpg
EOF
        # Install DBeaver
        sudo dnf install -y dbeaver-ce
        ;;
    *)
        echo "Unsupported OS family: $OS_FAMILY"
        exit 1
        ;;
esac

echo "DBeaver Community Edition installed successfully."
echo "Task 26 completed successfully."