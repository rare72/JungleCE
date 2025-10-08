#!/bin/bash
set -e

echo "Starting Task 20: Install Core Python Packages"

# This script depends on pip3. Task 18 should ideally be run first.
if ! command -v pip3 &> /dev/null; then
    echo "Error: pip3 command not found. Please install Python 3 and Pip first."
    exit 1
fi

PACKAGES="pandas pyspark logify duckdb"

echo "Installing core Python packages: $PACKAGES..."
sudo pip3 install $PACKAGES

echo "Core Python packages installed successfully."
echo "Task 20 completed successfully."