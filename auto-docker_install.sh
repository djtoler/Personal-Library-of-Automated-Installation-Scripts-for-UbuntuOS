#!/bin/bash


# Remove packages
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
    apt-get remove -y $pkg
done

# Install prerequisites
apt-get install -y apt-transport-https ca-certificates curl software-properties-common lsb-release

# Add Docker GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - 

# Add Docker repo
add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Update packages
apt-get update 

# Install Docker
apt-get install -y docker-ce 

# Add ubuntu user to Docker group (if it exists)
if id "ubuntu" &>/dev/null; then
    usermod -aG docker ubuntu
    echo "Added ubuntu user to Docker group"
fi

reboot
