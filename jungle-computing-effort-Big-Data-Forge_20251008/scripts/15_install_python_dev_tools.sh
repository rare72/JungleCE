#!/bin/bash
set -e

echo "Starting Task 15: Install Python Dev Tools"

# This script depends on pip3. Task 18 should ideally be run first.
if ! command -v pip3 &> /dev/null; then
    echo "Error: pip3 command not found. Please install Python 3 and Pip first."
    exit 1
fi

echo "Installing Python development and linting tools (black, flake8, isort)..."
sudo pip3 install black flake8 isort

echo "Python dev tools installed successfully."
echo "Task 15 completed successfully."