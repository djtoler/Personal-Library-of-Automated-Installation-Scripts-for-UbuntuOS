#!/bin/bash

docker login
docker pull djtoler/dk8000:latest
docker run -d -p 80:80 djtoler/dk8000:latest
