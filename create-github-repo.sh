#!/bin/bash

DEFAULT_USER=Shredder

if [[ "$#" < 2 ]]; then
  read -p "Github User> " USER
  read -p "Repo name> " REPO
else
  USER=$1
  REPO=$2
fi

curl -u "${USER:-$DEFAULT_USER}" https://api.github.com/user/repos -d "{\"name\": \"$REPO\"}"
