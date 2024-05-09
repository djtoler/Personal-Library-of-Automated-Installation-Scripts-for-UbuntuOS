#!/bin/bash

docker login
docker pull djtoler/demoapp100:latest
docker run -d -p 80:80 djtoler/demoapp100:latest
