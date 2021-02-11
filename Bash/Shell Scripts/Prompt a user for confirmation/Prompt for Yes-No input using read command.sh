#!/bin/bash

echo -e "\nPrompt for Yes/No input using read command"

while true; do
    read -p "Do you wish to install this program?" yn
    case $yn in
        [Yy]* ) make install; break;;
        [Nn]* ) exit;;
        * ) echo -e "\nPlease answer yes or no.";;
    esac
done
