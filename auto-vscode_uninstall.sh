
#!/bin/bash

# Stop the code-server service
sudo systemctl stop code-server

# Disable the code-server service
sudo systemctl disable code-server

# Remove the service file if it exists
sudo rm /etc/systemd/system/code-server.service

# Reload systemd and reset any failed services
sudo systemctl daemon-reload
sudo systemctl reset-failed

# Uninstall code-server
# The command depends on how code-server was installed.
# Here it assumes that code-server was installed via apt. Adjust if necessary.
sudo apt-get remove code-server -y

# Remove configuration files and directories
rm -rf ~/.config/code-server
rm -rf ~/.local/share/code-server

# Echo a completion message
echo "code-server has been uninstalled."
