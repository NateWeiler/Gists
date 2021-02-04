#!/bin/bash

echo "Prompt a user for confirmation in bash script"

read -p "Continue (y/n)?" choice
case "$choice" in
  y|Y ) echo "yes";;
  n|N ) echo "no";;
  * ) echo "invalid";;
esac
