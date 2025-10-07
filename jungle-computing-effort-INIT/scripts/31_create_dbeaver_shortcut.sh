#!/bin/bash
set -e

echo "Creating desktop shortcut for DBeaver..."

DESKTOP_DIR=$(xdg-user-dir DESKTOP || echo "$HOME/Desktop")

if [ ! -d "$DESKTOP_DIR" ]; then
    echo "Desktop directory not found. Skipping shortcut creation."
    exit 0
fi

DBEAVER_DESKTOP_FILE="$DESKTOP_DIR/dbeaver.desktop"

# The .desktop file is typically located in /usr/share/applications/
SOURCE_DESKTOP_FILE="/usr/share/applications/dbeaver.desktop"

if [ ! -f "$SOURCE_DESKTOP_FILE" ]; then
    # Some installations might place it under a different name
    SOURCE_DESKTOP_FILE="/usr/share/applications/dbeaver-ce.desktop"
fi

if [ ! -f "$SOURCE_DESKTOP_FILE" ]; then
    echo "Could not find dbeaver.desktop or dbeaver-ce.desktop. Is DBeaver installed? Skipping."
    exit 0
fi

echo "Found source desktop file at $SOURCE_DESKTOP_FILE"

# Copy the .desktop file to the user's desktop
cp "$SOURCE_DESKTOP_FILE" "$DBEAVER_DESKTOP_FILE"

# Make it executable
chmod +x "$DBEAVER_DESKTOP_FILE"

# On some systems, we need to trust the shortcut
if command -v gio &> /dev/null; then
    gio set "$DBEAVER_DESKTOP_FILE" "metadata::trusted" true
fi

echo "Desktop shortcut for DBeaver created successfully at $DBEAVER_DESKTOP_FILE."