#!/bin/bash

GH_TOKEN="$1"
REPO_NAME="$2"

curl -H "Authorization: token $GH_TOKEN" \
     -d "{\"name\": \"$REPO_NAME\",\"private\":false,\"auto_init\":true,\"}" \
     https://api.github.com/user/repos

if git remote | grep -q 'origin'; then
    git remote remove origin
fi

git remote add origin https://github.com/djtoler/$REPO_NAME
