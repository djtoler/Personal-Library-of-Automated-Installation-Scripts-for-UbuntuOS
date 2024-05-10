#!/bin/bash

docker login
curl -O https://raw.githubusercontent.com/djtoler/hwthdemo3/main/Dockerfile
docker build -t djtoler/dk8001 
docker push djtoler/dk8001:latest
docker run -d -p 80:80 djtoler/dk8001:latest
