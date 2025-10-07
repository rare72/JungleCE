#!/bin/bash
set -e

echo "Configuring Pip for the current user..."

PIP_CONF_DIR="$HOME/.config/pip"
PIP_CONF_FILE="$PIP_CONF_DIR/pip.conf"

# Note: This script is intended to be run as a standard user.
# The master orchestrator handles this context switch automatically.

if [ ! -d "$PIP_CONF_DIR" ]; then
    echo "Creating directory $PIP_CONF_DIR..."
    mkdir -p "$PIP_CONF_DIR"
fi

if [ -f "$PIP_CONF_FILE" ]; then
    echo "Pip configuration file already exists at $PIP_CONF_FILE. Skipping."
else
    echo "Creating Pip configuration file..."
    echo "[global]" > "$PIP_CONF_FILE"
    echo "timeout = 60" >> "$PIP_CONF_FILE"
    echo "Pip configuration created successfully at $PIP_CONF_FILE."
fi

echo "Pip configuration completed."