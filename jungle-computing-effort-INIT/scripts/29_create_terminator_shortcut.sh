#!/bin/bash
set -e

echo "Creating desktop shortcut for Terminator..."

DESKTOP_DIR=$(xdg-user-dir DESKTOP || echo "$HOME/Desktop")

if [ ! -d "$DESKTOP_DIR" ]; then
    echo "Desktop directory not found. Skipping shortcut creation."
    exit 0
fi

TERMINATOR_DESKTOP_FILE="$DESKTOP_DIR/terminator.desktop"
SOURCE_DESKTOP_FILE="/usr/share/applications/terminator.desktop"

if [ ! -f "$SOURCE_DESKTOP_FILE" ]; then
    echo "Could not find terminator.desktop file. Is Terminator installed? Skipping."
    exit 0
fi

echo "Found source desktop file at $SOURCE_DESKTOP_FILE"

# Copy the .desktop file to the user's desktop
cp "$SOURCE_DESKTOP_FILE" "$TERMINATOR_DESKTOP_FILE"

# Make it executable
chmod +x "$TERMINATOR_DESKTOP_FILE"

# On some systems, we need to trust the shortcut
if command -v gio &> /dev/null; then
    gio set "$TERMINATOR_DESKTOP_FILE" "metadata::trusted" true
fi

echo "Desktop shortcut for Terminator created successfully at $TERMINATOR_DESKTOP_FILE."