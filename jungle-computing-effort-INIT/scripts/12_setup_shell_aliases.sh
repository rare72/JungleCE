#!/bin/bash
set -e

echo "Setting up shell aliases in .zshrc..."

ZSHRC_FILE="$HOME/.zshrc"
ALIASES_BLOCK_HEADER="# Custom Aliases managed by Jungle Computing Effort"

if [ ! -f "$ZSHRC_FILE" ]; then
    echo "Creating $ZSHRC_FILE..."
    touch "$ZSHRC_FILE"
fi

if grep -q "$ALIASES_BLOCK_HEADER" "$ZSHRC_FILE"; then
    echo "Aliases appear to be already set up. Skipping."
else
    echo "Adding aliases to $ZSHRC_FILE..."
    # Append a newline just in case the file doesn't end with one
    echo "" >> "$ZSHRC_FILE"
    echo "$ALIASES_BLOCK_HEADER" >> "$ZSHRC_FILE"
    echo "alias ll='ls -alF'" >> "$ZSHRC_FILE"
    echo "alias la='ls -A'" >> "$ZSHRC_FILE"
    echo "alias l='ls -CF'" >> "$ZSHRC_FILE"
    echo "alias ..='cd ..'" >> "$ZSHRC_FILE"
    echo "alias ...='cd ../..'" >> "$ZSHRC_FILE"
    echo "alias grep='grep --color=auto'" >> "$ZSHRC_FILE"
fi

echo "Shell aliases setup completed."