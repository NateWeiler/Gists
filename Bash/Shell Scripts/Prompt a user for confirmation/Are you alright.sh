#!/system/bin/bash

read -p "Are you alright? (y/n) " RESP
if [ "$RESP" = "y" ]; then
  echo "Glad to hear it"
else
  echo "You need more bash programming"
fi
