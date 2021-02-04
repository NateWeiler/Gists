#!/bin/bash

echo "Find Files"

find . -type f -name "*.md" -print > 'Some File.txt'

find . -depth -type f -name "*.md" -print > 'Some File.txt'

find . -maxdepth 10 -type f -name "*.md" -print > 'Some File.txt'

echo "add to a file by adding a >>"
