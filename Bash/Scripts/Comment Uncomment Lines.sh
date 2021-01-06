#!/bin/bash

echo "Comment Uncomment Lines"

echo "your target file"

CONFIG=./config.txt

echo "comment target"

comment() {
  sed -i '' "s/^$1/#$1/" $CONFIG
}

echo "comment target"

uncomment() {
  echo $1
  sed -i '' "s/^#$1/$1/" $CONFIG
}

echo "Use it so:"

uncomment enable_uart
comment arm_freq
