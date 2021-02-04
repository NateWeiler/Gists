#!/bin/bash

echo "Remove all empty directories"

echo "get directory list"

find . -type d -print > dirs$$

echo "clean up"

rm -rf dirs$$
rm -rf revdirs$$
