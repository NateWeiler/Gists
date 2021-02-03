#!/bin/bash

echo "Prompt a user for confirmation in bash script 'y' 'yes' or 'Enter'"

read -r -p "Are you sure? [Y/n]" response
response=${response,,} # tolower
if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
   your-action-here
fi
