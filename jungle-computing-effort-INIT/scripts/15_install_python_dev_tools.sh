#!/bin/bash
set -e

echo "Installing Python development and linting tools (black, flake8, isort)..."

if ! command -v pip3 &> /dev/null; then
    echo "pip3 could not be found. Please ensure Python 3 and Pip are installed."
    exit 1
fi

# Using sudo to install these tools globally.
# A virtual environment approach is recommended for project-specific dependencies.
sudo pip3 install --upgrade black flake8 isort

echo "Python development tools installed successfully."