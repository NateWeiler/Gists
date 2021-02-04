#!/bin/bash

echo "Find all the Sticky Bit set files whose permission are 551"

find / -perm 1551
