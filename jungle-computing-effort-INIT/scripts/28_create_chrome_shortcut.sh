#!/bin/bash
set -e

echo "Creating desktop shortcut for Google Chrome..."

DESKTOP_DIR=$(xdg-user-dir DESKTOP || echo "$HOME/Desktop")

if [ ! -d "$DESKTOP_DIR" ]; then
    echo "Desktop directory not found. Skipping shortcut creation."
    exit 0
fi

CHROME_DESKTOP_FILE="$DESKTOP_DIR/google-chrome.desktop"

# Find the original .desktop file
# Common locations for the .desktop file
if [ -f "/usr/share/applications/google-chrome.desktop" ]; then
    SOURCE_DESKTOP_FILE="/usr/share/applications/google-chrome.desktop"
elif [ -f "/opt/google/chrome/google-chrome.desktop" ]; then
    # Location for some installations
    SOURCE_DESKTOP_FILE="/opt/google/chrome/google-chrome.desktop"
else
    echo "Could not find google-chrome.desktop file. Skipping shortcut creation."
    exit 0
fi

echo "Found source desktop file at $SOURCE_DESKTOP_FILE"

# Copy the .desktop file to the user's desktop
cp "$SOURCE_DESKTOP_FILE" "$CHROME_DESKTOP_FILE"

# Make it executable
chmod +x "$CHROME_DESKTOP_FILE"

# On some systems, we need to trust the shortcut
if command -v gio &> /dev/null; then
    gio set "$CHROME_DESKTOP_FILE" "metadata::trusted" true
fi

echo "Desktop shortcut for Google Chrome created successfully at $CHROME_DESKTOP_FILE."