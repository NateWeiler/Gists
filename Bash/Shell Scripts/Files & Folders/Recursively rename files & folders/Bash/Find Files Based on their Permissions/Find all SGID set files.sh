#!/bin/bash

echo "Find all SGID set files"

find / -perm /g=s
