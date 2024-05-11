#!/bin/bash

docker login
curl -O https://raw.githubusercontent.com/djtoler/hwthdemo4/main/Dockerfile
docker build -t djtoler/dk9999 . 

docker run -d -p 80:80 djtoler/dk9999:latest
