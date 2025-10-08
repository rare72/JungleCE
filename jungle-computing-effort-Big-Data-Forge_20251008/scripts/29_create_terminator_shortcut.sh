#!/bin/bash
set -e

echo "Starting Task 29: Create Terminator Desktop Shortcut"

# Determine the user and their desktop directory
if [ -n "$SUDO_USER" ]; then
    TARGET_USER="$SUDO_USER"
else
    TARGET_USER=$(whoami)
fi
USER_HOME=$(getent passwd "$TARGET_USER" | cut -d: -f6)
DESKTOP_DIR="$USER_HOME/Desktop"

# Ensure the Desktop directory exists
sudo -u "$TARGET_USER" mkdir -p "$DESKTOP_DIR"

# Path for the .desktop file
SHORTCUT_FILE="$DESKTOP_DIR/terminator.desktop"

# Check if the shortcut already exists
if [ -f "$SHORTCUT_FILE" ]; then
    echo "Terminator shortcut already exists for user $TARGET_USER. Skipping."
    exit 0
fi

# Check if the application is installed
if ! command -v terminator &> /dev/null; then
    echo "Warning: terminator command not found. Cannot create shortcut."
    exit 0
fi

echo "Creating shortcut for Terminator on the desktop..."

# Create the .desktop file
sudo -u "$TARGET_USER" tee "$SHORTCUT_FILE" > /dev/null <<EOF
[Desktop Entry]
Version=1.0
Name=Terminator
Comment=Multiple terminals in one window
Exec=/usr/bin/terminator
Icon=terminator
Terminal=false
Type=Application
Categories=Application;System;
EOF

# Make the shortcut executable
sudo -u "$TARGET_USER" chmod +x "$SHORTCUT_FILE"

echo "Terminator shortcut created successfully at $SHORTCUT_FILE"
echo "Task 29 completed successfully."