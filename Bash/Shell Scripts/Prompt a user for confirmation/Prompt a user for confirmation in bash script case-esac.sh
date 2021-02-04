#!/bin/bash

echo "Prompt a user for confirmation in bash script case/esac"

echo "advantage:"

echo "1. neater"

echo "2. can use 'OR' condition easier"

echo "3. can use character range, eg [yY][eE][sS] to accept word "yes", where any of its characters may be in lowercase or in uppercase."

read -p "Continue (y/n)?" choice
case "$choice" in
  y|Y ) echo "yes";;
  n|N ) echo "no";;
  * ) echo "invalid";;
esac
