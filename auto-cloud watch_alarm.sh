#!/bin/bash

aws cloudwatch put-metric-alarm \
  --alarm-name "HighCPUUsage" \
  --alarm-description "Alarm when CPU exceeds 70%" \
  --metric-name CPUUtilization \
  --namespace AWS/EC2 \
  --statistic Average \
  --period 300 \
  --threshold 70 \
  --comparison-operator GreaterThanThreshold \
  --dimensions Name=InstanceId,Value=i-1234567890abcdef0 \
  --evaluation-periods 2 \
  --datapoints-to-alarm 2 \
  --actions-enabled \
  --alarm-actions arn:aws:sns:us-west-1:123456789012:NotifyMe \
  --unit Percent
