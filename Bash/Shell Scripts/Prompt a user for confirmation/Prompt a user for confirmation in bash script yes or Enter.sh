#!/bin/bash

echo -e "\nPrompt a user for confirmation in bash script 'y' 'yes' or 'Enter'\n"

read -r -p "Are you sure? [Y/n]" response
response=${response,,} # tolower
if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
   your-action-here
fi
