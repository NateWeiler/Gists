#!/system/bin/bash

read -p "Are you alright? (y/n) " RESP
if [ "$RESP" = "y" ]; then
  echo -e "\nGlad to hear it"
else
  echo -e "\nYou need more bash programming"
fi
