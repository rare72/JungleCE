#!/bin/bash
set -e

echo "Installing core Python packages (pandas, pyspark, logify, duckdb)..."

if ! command -v pip3 &> /dev/null; then
    echo "pip3 could not be found. Please ensure Python 3 and Pip are installed."
    exit 1
fi

# Using sudo to install these packages globally.
# A virtual environment is the recommended best practice for application dependencies.
sudo pip3 install --upgrade pandas pyspark logify duckdb

echo "Core Python packages installed successfully."