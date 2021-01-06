#!/bin/bash

echo "Recursively delete empty directories with globstar"

shopt -s globstar
for dir in **/; do
   files=("$dir"/*)
   [[ ${files[@]} ]] || rmdir -v "$dir"
done
