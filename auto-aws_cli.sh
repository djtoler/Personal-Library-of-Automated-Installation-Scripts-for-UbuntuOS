#!/bin/bash

sudo apt update
sudo apt install unzip

# Download AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
sudo apt update

# Remove files if they exist
rm -f ~/.aws/credentials 
rm -f ~/.aws/config

# Download config file from s3 bucket & replace 
curl -O https://dp5-auto1.s3.amazonaws.com/config.txt
cp config.txt ~/.aws/config

sudo apt update
