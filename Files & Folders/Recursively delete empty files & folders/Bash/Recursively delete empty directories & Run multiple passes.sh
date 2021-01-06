#!/bin/bash

echo "Recursively delete empty directories & Run multiple passes"

while [ -n "$(find . -depth -type d -empty -print -exec rm -rf {} +)" ]; do :; done
