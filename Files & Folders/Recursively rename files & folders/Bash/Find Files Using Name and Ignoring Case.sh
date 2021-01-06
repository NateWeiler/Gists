#!/bin/bash

echo "Find Files Using Name and Ignoring Case"

echo "Find all the files whose name is some-file.txtsome-file.txt and contains both capital and small letters in /home directory."

find /home -iname some-file.txt ./some-file.txt ./Some-file.txt
