#!/bin/bash
set -e

echo "Creating .zprofile and setting default EDITOR..."

ZPROFILE_FILE="$HOME/.zprofile"
EDITOR_EXPORT='export EDITOR="code --wait"'

if [ ! -f "$ZPROFILE_FILE" ]; then
    echo "Creating $ZPROFILE_FILE..."
    touch "$ZPROFILE_FILE"
fi

if grep -q "export EDITOR" "$ZPROFILE_FILE"; then
    echo "EDITOR variable is already set in $ZPROFILE_FILE. Skipping."
else
    echo "Adding EDITOR variable to $ZPROFILE_FILE..."
    echo "" >> "$ZPROFILE_FILE"
    echo "# Set Visual Studio Code as the default editor" >> "$ZPROFILE_FILE"
    echo "$EDITOR_EXPORT" >> "$ZPROFILE_FILE"
fi

echo "Shell profile configuration completed."