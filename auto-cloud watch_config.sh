#!/bin/bash

#URL to AWS CloudWatch config file documentation: 
#https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Agent-Configuration-File-Details.html

#Run this file like this: ./auto-cloud watch_config.sh 1 ubuntu /var/logs/syslog syslog

#Variable values for the CloudWatch config file that must be passed to this file as arguments
METRICS_INTERVAL_IN_SECONDS=$1
SYSTEM_USER_TO_RUN_AS=$2
PATH_TO_WRITE_LOGS_TO=$3
LOG_GROUP=$4


#'$#' means number of arguments.
if [ "$#" -ne 4 ]; then
    echo "Must provide all arguments necessary for this script to run"
    exit 1
fi

#Download & install the CloudWatch agent
wget https://amazoncloudwatch-agent.s3.amazonaws.com/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
sudo dpkg -i -E ./amazon-cloudwatch-agent.deb

#Download CloudWatch configuration file
curl https://github.com/djtoler/automated_installation_scripts/blob/main/templates/cloudwatch_template.json -o config.json

#Fill in values for the CloudWatch template
sed -i "s|METRICS_INTERVAL|$METRICS_INTERVAL_IN_SECONDS|g"  config.json
sed -i "s|RUN_AS_USER|$SYSTEM_USER_TO_RUN_AS" config.json
sed -i "s|LOG_PATH|$PATH_TO_WRITE_LOGS_TO|g" config.json
sed -i "s|LOG_GROUP|$LOG_GROUP|g" config.json

#Copy CloudWatch config file to the CoudWatch bin directory
sudo cp cloudwatch-agent-config.json /opt/aws/amazon-cloudwatch-agent/bin/config.json

#Start CloudWatch agent with config file
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -s -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json

#Check status to make sure CloudWatch agent is running
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a status


