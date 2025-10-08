#!/bin/bash
set -e

echo "Starting Task 23: Install csvkit"

# This script depends on pip3. Task 18 should ideally be run first.
if ! command -v pip3 &> /dev/null; then
    echo "Error: pip3 command not found. Please install Python 3 and Pip first."
    exit 1
fi

echo "Installing csvkit via pip3..."
sudo pip3 install csvkit

echo "csvkit installed successfully."
# Verify installation by checking the version of a core csvkit tool
in2csv --version
echo "Task 23 completed successfully."