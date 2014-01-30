#!/bin/bash

yes-or-no () {
  local yn
  while :; do
    read -n1 -p "$1 [y/n] " yn
    echo
    case ${yn,,} in
     y) return 0 ;;
     n) return 1 ;;
     *) ;;
    esac
  done
}

script-dir () {
  SCRIPT_DIR=$(dirname $(readlink -f $0))
}
