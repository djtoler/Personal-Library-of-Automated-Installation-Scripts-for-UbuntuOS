#!/bin/bash

sudo apt update
sudo apt install unzip

# Download AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install 
mkdir -p ~/.aws

# Download test file
curl -O https://dp5-auto1.s3.amazonaws.com/cat.txt

# Download config file from s3 bucket & replace 
curl https://dp5-auto1.s3.amazonaws.com/config.txt -o config
cp config ~/.aws/config

sudo apt update
