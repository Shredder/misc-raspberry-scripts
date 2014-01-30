#!/bin/bash

SCRIPT_DIR=$(dirname $(readlink -f $0))
. "$SCRIPT_DIR/misc.sh"
GIT_CONFIG="$HOME/.gitconfig"

if [[ -e "$GIT_CONFIG" ]]; then
  if yes-or-no "Error: git config already exists. Remove and recreate?"; then
    rm "$GIT_CONFIG"
  else
    echo Exiting.
    exit 1
  fi
fi

read -p "Firstname Lastname? " USER_NAME
read -p "Email? " EMAIL

declare -A config
config=([user.name]="${USER_NAME:-Joerg Ziefle}"
        [user.email]="${EMAIL:-joerg.ziefle@gmail.com}"
        [color.ui]=auto
        [color.branch]=auto
        [color.diff]=auto
        [color.grep]=auto
        [color.interactive]=auto
        [color.showbranch]=auto
        [color.status]=auto
        [core.pager]=less
        [core.editor]=vim
        [merge.tool]=vimdiff
        [alias.br]=branch
        [alias.ci]=commit
        [alias.cl]=clone
        [alias.co]=checkout
        [alias.di]=diff
        [alias.fe]=fetch
        [alias.gr]=grep
        [alias.in]=init
        [alias.lg]=log
        [alias.me]=merge
        [alias.pl]=pull
        [alias.pu]=push
        [alias.st]=status
        [alias.up]=rebase)

for el in ${!config[@]}; do
  git config --global "$el" "${config[$el]}"
done

