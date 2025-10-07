#!/bin/bash
set -e

echo "Configuring timezone to America/New_York..."

sudo timedatectl set-timezone "America/New_York"

echo "Timezone configured successfully."
echo "Current time: $(date)"