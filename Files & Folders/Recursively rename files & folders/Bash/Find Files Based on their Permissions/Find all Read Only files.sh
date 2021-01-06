#!/bin/bash

echo "Find all Read Only files."

find / -perm /u=r
