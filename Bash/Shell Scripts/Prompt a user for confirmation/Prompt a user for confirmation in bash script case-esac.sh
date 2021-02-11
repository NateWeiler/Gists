#!/bin/bash

echo -e "\nPrompt a user for confirmation in bash script case/esac"

echo -e "\nadvantage:"

echo -e "\n1. neater"

echo -e "\n2. can use 'OR' condition easier"

echo -e "\n3. can use character range, eg [yY][eE][sS] to accept word "yes", where any of its characters may be in lowercase or in uppercase."

read -p "Continue (y/n)?" choice
case "$choice" in
  y|Y ) echo -e "\nyes";;
  n|N ) echo -e "\nno";;
  * ) echo -e "\ninvalid";;
esac
