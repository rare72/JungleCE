#!/bin/bash
set -e

echo "Creating desktop shortcut for Visual Studio Code..."

DESKTOP_DIR=$(xdg-user-dir DESKTOP || echo "$HOME/Desktop")

if [ ! -d "$DESKTOP_DIR" ]; then
    echo "Desktop directory not found. Skipping shortcut creation."
    exit 0
fi

VSCODE_DESKTOP_FILE="$DESKTOP_DIR/vscode.desktop"

# VS Code's .desktop file is usually in /usr/share/applications/
SOURCE_DESKTOP_FILE="/usr/share/applications/code.desktop"

if [ ! -f "$SOURCE_DESKTOP_FILE" ]; then
    echo "Could not find code.desktop file. Is VS Code installed? Skipping."
    exit 0
fi

echo "Found source desktop file at $SOURCE_DESKTOP_FILE"

# Copy the .desktop file to the user's desktop
cp "$SOURCE_DESKTOP_FILE" "$VSCODE_DESKTOP_FILE"

# Make it executable
chmod +x "$VSCODE_DESKTOP_FILE"

# On some systems, we need to trust the shortcut
if command -v gio &> /dev/null; then
    gio set "$VSCODE_DESKTOP_FILE" "metadata::trusted" true
fi

echo "Desktop shortcut for Visual Studio Code created successfully at $VSCODE_DESKTOP_FILE."