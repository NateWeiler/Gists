#!/bin/bash

echo "Find all the SGID bit files whose permissions set to 644"

find / -perm 2644
