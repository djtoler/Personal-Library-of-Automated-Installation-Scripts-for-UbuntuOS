#!/bin/bash

# Update packages
sudo apt update -y

# Install Python
sudo apt install -y software-properties-common
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt update -y
sudo apt install -y python3.7 python3.7-venv
sudo apt install -y python3.7-dev


# Install Python3 pip
sudo apt install python3-pip -y
