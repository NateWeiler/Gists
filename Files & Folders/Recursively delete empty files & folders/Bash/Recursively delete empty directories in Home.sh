#!/bin/bash

echo "Recursively delete empty directories in Home"

find "$HOME" -type d -exec bash -c 'shopt -s nullglob; shopt -s dotglob; files=("$1"/*); [[ ${files[@]} ]] || rmdir -v "$1"' -- {} \;
