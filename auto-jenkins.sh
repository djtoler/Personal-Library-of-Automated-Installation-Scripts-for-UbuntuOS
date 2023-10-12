#!/bin/bash

sudo apt-get update -y

# Install JDK
sudo apt install openjdk-8-jdk -y
sudo apt-get update -y

# Download Jenkins keys
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list
sudo apt-get update -y

# Install & start Jenkins
sudo apt-get install -y fontconfig openjdk-17-jre jenkins
sudo systemctl start jenkins

# Get Jenkins unlock key
echo "Jenkins Unlock Key:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

# Update packages
sudo apt update -y