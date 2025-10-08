#!/bin/bash
set -e

# This script is intended for manual execution to manage services post-setup.

# Help message function
show_help() {
    echo "Usage: $0 {enable|disable} {postgres|mongo}"
    echo ""
    echo "A utility to enable/disable and start/stop PostgreSQL and MongoDB services."
    echo ""
    echo "Commands:"
    echo "  enable    Enable and start the specified service."
    echo "  disable   Disable and stop the specified service."
    echo ""
    echo "Services:"
    echo "  postgres  Manage the PostgreSQL service."
    echo "  mongo     Manage the MongoDB service (mongod)."
    echo ""
    echo "Examples:"
    echo "  sudo $0 enable postgres"
    echo "  sudo $0 disable mongo"
}

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Please use sudo."
    exit 1
fi

# Check for correct number of arguments
if [ "$#" -ne 2 ]; then
    show_help
    exit 1
fi

ACTION=$1
SERVICE=$2
SYSTEMCTL_ACTION_PRIMARY=""
SYSTEMCTL_ACTION_SECONDARY=""

# Validate action
case "$ACTION" in
    "enable")
        SYSTEMCTL_ACTION_PRIMARY="enable"
        SYSTEMCTL_ACTION_SECONDARY="start"
        ;;
    "disable")
        SYSTEMCTL_ACTION_PRIMARY="disable"
        SYSTEMCTL_ACTION_SECONDARY="stop"
        ;;
    *)
        echo "Error: Invalid action '$ACTION'. Must be 'enable' or 'disable'."
        show_help
        exit 1
        ;;
esac

# Validate and set service name
case "$SERVICE" in
    "postgres")
        SERVICE_NAME="postgresql"
        ;;
    "mongo")
        SERVICE_NAME="mongod"
        ;;
    *)
        echo "Error: Invalid service '$SERVICE'. Must be 'postgres' or 'mongo'."
        show_help
        exit 1
        ;;
esac

# Perform the action
echo "Performing action '$ACTION' on service '$SERVICE_NAME'..."
sudo systemctl "$SYSTEMCTL_ACTION_PRIMARY" "$SERVICE_NAME"
sudo systemctl "$SYSTEMCTL_ACTION_SECONDARY" "$SERVICE_NAME"
echo "Action completed. Current status of $SERVICE_NAME:"
sudo systemctl status "$SERVICE_NAME" --no-pager