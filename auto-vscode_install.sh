#!/bin/bash

sudo apt update
sudo apt upgrade -y

# Install VSCode Server
curl -fsSL https://code-server.dev/install.sh | sh

# Define the service configuration
SERVICE_FILE="/etc/systemd/system/code-server.service"

# Write the configuration to the service file
echo "[Unit]
Description=code-server
After=nginx.service

[Service]
Type=simple
ExecStart=/usr/bin/code-server --bind-addr 0.0.0.0:8080
User=ubuntu
WorkingDirectory=/home/ubuntu/
Restart=always

[Install]
WantedBy=multi-user.target" | sudo tee $SERVICE_FILE

# Change the password or authorization method
sed -i 's/auth: password/auth: none/' /home/ubuntu/.config/code-server/config.yaml

# Reload the systemd manager configuration
sudo systemctl daemon-reload

# Enable the code-server service
sudo systemctl enable code-server.service

# Start the code-server service
sudo systemctl start code-server.service
