#!/bin/bash

echo "Find all SUID set files"

find / -perm /u=s
