#!/bin/bash
set -e

echo "Starting Task 2: Configure Timezone"

echo "Setting timezone to America/New_York..."
sudo timedatectl set-timezone "America/New_York"

echo "Current time: $(date)"
echo "Task 2 completed successfully."