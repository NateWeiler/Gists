#!/bin/sh

read -r -p "Change All .git Folders to DOTgit? [Y/n]" response
response=${response,,} #   <-- tolower
if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
   find . -depth -type d | while read FNAME; do mv "$FNAME" "${FNAME//.git/DOTgit}
fi

read -r -p "Remove All .git Folders? [Y/n]" response
response=${response,,} #   <-- tolower
if [[ $response =~ ^(yes|y| ) ]] || [[ -z $response ]]; then
   find . -depth -type d -name ".git" -exec rm -rf {} \; && find . -depth -type d -name ".github" -exec rm -rf {} \;
fi
