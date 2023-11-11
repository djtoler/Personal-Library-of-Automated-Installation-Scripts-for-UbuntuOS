#!/bin/bash

# Find the process ID of the frontend app
PID=$(lsof -i :3000 -t)

# If its found, write it to a file, and kill it
if [[ -n $PID ]]
then
    echo $PID > pid.txt
    kill -9 $PID
    echo "killed react app"
fi
