#!/bin/bash

#Install NodeJS specific version
#curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
#sudo apt-get install -y nodejs
#sudo apt-get install npm -y

#Install Node Version Manager(NVM)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
source ~/.bashrc
nvm install 10
nvm use 10
