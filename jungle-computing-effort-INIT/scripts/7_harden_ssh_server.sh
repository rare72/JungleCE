#!/bin/bash
set -e

echo "Hardening SSH server configuration..."

SSHD_CONFIG="/etc/ssh/sshd_config"

# Disallow root login
if grep -q "^PermitRootLogin" "$SSHD_CONFIG"; then
    sudo sed -i 's/^PermitRootLogin.*/PermitRootLogin no/' "$SSHD_CONFIG"
    echo "Set PermitRootLogin to no."
else
    echo "PermitRootLogin no" | sudo tee -a "$SSHD_CONFIG"
    echo "Added PermitRootLogin no."
fi

# Disallow password authentication
if grep -q "^PasswordAuthentication" "$SSHD_CONFIG"; then
    sudo sed -i 's/^PasswordAuthentication.*/PasswordAuthentication no/' "$SSHD_CONFIG"
    echo "Set PasswordAuthentication to no."
else
    echo "PasswordAuthentication no" | sudo tee -a "$SSHD_CONFIG"
    echo "Added PasswordAuthentication no."
fi

# Restart SSH service to apply changes
echo "Restarting SSH service..."
sudo systemctl restart sshd

echo "SSH server hardening completed. Ensure you have key-based auth set up before logging out."