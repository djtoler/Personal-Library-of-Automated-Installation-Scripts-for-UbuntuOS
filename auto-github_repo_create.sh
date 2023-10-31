#!/bin/bash

GH_TOKEN="$1"
REPO_NAME="$2"

curl -H "Authorization: token $GH_TOKEN" \
     -d "{\"name\": \"$REPO_NAME\",\"private\":false,\"auto_init\":true,\"}" \
     https://api.github.com/user/repos
