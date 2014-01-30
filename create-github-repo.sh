#!/bin/bash

if [[ "$#" < 2 ]]; then
  read -p "Github User> " USER
  read -p "Repo name> " REPO
else
  USER=$1
  REPO=$2
fi

curl -u $USER https://api.github.com/user/repos -d "{'name': '$REPO'}"
