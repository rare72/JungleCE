#!/bin/bash
set -e

# A utility to enable or disable PostgreSQL and MongoDB services.

show_help() {
    echo "Usage: $0 <action> <service>"
    echo ""
    echo "Actions:"
    echo "  enable    Enable and start the service."
    echo "  disable   Disable and stop the service."
    echo ""
    echo "Services:"
    echo "  postgres  Control the PostgreSQL service."
    echo "  mongo     Control the MongoDB service."
    echo ""
    echo "Example: $0 enable postgres"
}

if [ "$#" -ne 2 ]; then
    echo "Error: Invalid number of arguments."
    show_help
    exit 1
fi

ACTION=$1
SERVICE_NAME=$2
SYSTEMD_SERVICE=""

case "$SERVICE_NAME" in
    "postgres")
        SYSTEMD_SERVICE="postgresql"
        ;;
    "mongo")
        SYSTEMD_SERVICE="mongod"
        ;;
    *)
        echo "Error: Invalid service '$SERVICE_NAME'."
        show_help
        exit 1
        ;;
esac

case "$ACTION" in
    "enable")
        echo "Enabling and starting $SYSTEMD_SERVICE..."
        sudo systemctl enable "$SYSTEMD_SERVICE"
        sudo systemctl start "$SYSTEMD_SERVICE"
        echo "$SYSTEMD_SERVICE is now active."
        ;;
    "disable")
        echo "Disabling and stopping $SYSTEMD_SERVICE..."
        sudo systemctl stop "$SYSTEMD_SERVICE"
        sudo systemctl disable "$SYSTEMD_SERVICE"
        echo "$SYSTEMD_SERVICE is now inactive."
        ;;
    *)
        echo "Error: Invalid action '$ACTION'."
        show_help
        exit 1
        ;;
esac

sudo systemctl status "$SYSTEMD_SERVICE" --no-pager