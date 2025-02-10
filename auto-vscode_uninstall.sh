#!/bin/bash

echo "Stopping and disabling code-server service..."
sudo systemctl stop code-server
sudo systemctl disable code-server

echo "Removing systemd service file..."
sudo rm -f /etc/systemd/system/code-server.service

echo "Reloading systemd daemon..."
sudo systemctl daemon-reload
sudo systemctl reset-failed

echo "Removing code-server binary..."
sudo rm -rf /usr/lib/code-server
sudo rm -f /usr/bin/code-server

echo "Removing configuration and user data..."
rm -rf ~/.config/code-server
rm -rf ~/.local/share/code-server
rm -rf ~/.cache/code-server

echo "Removing code-server logs..."
sudo rm -rf /var/log/code-server

echo "Uninstallation complete."
