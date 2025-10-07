#!/bin/bash
set -e

echo "Installing csvkit..."

if ! command -v pip3 &> /dev/null; then
    echo "pip3 could not be found. Please ensure Python 3 and Pip are installed."
    exit 1
fi

# Using sudo to install this tool globally.
sudo pip3 install --upgrade csvkit

echo "csvkit installed successfully."
in2csv --version