#!/bin/bash

echo "Find all the files whose permissions are 777."

find . -type f -perm 0777 -print

find / -type f ! -perm 777
