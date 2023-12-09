#!/bin/bash

sudo apt update
sudo apt upgrade -y

################################################################################################
# To create a password for your VS Code installation, run this script with the password you want as an argument like this...
# ./auto-vscode_install.sh mypassword

# Or run this script without an argument & VS Code will install with no authorization required
# ./auto-vscode_install.sh
################################################################################################

PASSWORD=$1

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

# Run this to change authorization method to none OR run the command under it to change the password
sed -i 's/auth:/auth: none/' /home/ubuntu/.config/code-server/config.yaml
#sed -i "s/password:.*/password: $PASSWORD/" /home/ubuntu/.config/code-server/config.yaml

# Reload the systemd manager configuration
sudo systemctl daemon-reload

# Enable the code-server service
sudo systemctl enable code-server.service

# Start the code-server service
sudo systemctl start code-server.service
