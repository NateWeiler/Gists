#!/bin/bash

echo "Prompt a user for confirmation in zsh script 'y' 'yes' or 'Enter'"

read "response?Are you sure ? [Y/n] "
response=${response:l} #tolower
if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
    your-action-here
fi
