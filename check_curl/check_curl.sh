#!/bin/bash

# set -xeu
set -x

# PATH=$PATH:$HOME/bin:/usr/local/bin
# export PATH


URL="${1}"


if [ $(curl -I ${URL} | head -n 1 | awk -F\  '{print $2}') = '200' ] ; then
  echo "status OK"
  exit 0
else
  echo "status warning"
  exit 1
fi

