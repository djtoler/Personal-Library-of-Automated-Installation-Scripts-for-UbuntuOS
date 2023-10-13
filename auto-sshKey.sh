#!/bin/bash

#Run this file using "./auto-sshKey.ssh <Choose-A-Key-Name>"

KEY_NAME=$1

ssh-keygen -t rsa -b 2048 -f ~/.ssh/$KEY_NAME -N ""

chmod 400 ~/.ssh/$KEY_NAME

cat ~/.ssh/$KEY_NAME.pub

