#!/bin/bash

echo "Prompt a user for confirmation in bash script read shell builtin"

read -p "Continue (y/n)?" CONT
if [ "$CONT" = "y" ]; then
  echo "yaaa";
else
  echo "booo";
fi
