#!/bin/bash

# Remove packages
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
    apt-get remove -y $pkg
done

# Install packages
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

# Add Docker repo
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Update packages
sudo apt update 

# Install Docker
sudo apt install -y docker-ce 

# Check that Docker is running
# sudo systemctl status docker

#Add curent user (ubuntu) user to Docker group
sudo usermod -aG docker $USER

# Restart Docker for changes to take effect
sudo systemctl restart docker
