#!/bin/bash

#Download & install the CloudWatch agent
wget https://amazoncloudwatch-agent.s3.amazonaws.com/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
sudo dpkg -i -E ./amazon-cloudwatch-agent.deb

#Download CloudWatch configuration file
curl -O http://

#Copy your predefined configuration to the appropriate directory
sudo cp cloudwatch-agent-config.json /opt/aws/amazon-cloudwatch-agent/bin/config.json

#Start CloudWatch agent with config file
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json

#Check status to make sure CloudWatch agent is running
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a status


