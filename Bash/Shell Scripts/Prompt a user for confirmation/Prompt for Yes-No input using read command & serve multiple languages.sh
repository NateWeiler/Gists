﻿#!/bin/bash

echo -e "\nPrompt for Yes/No input using read command & serve multiple languages"

set -- $(locale LC_MESSAGES)
yesptrn="$1"; noptrn="$2"; yesword="$3"; noword="$4"

while true; do
    read -p "Install (${yesword} / ${noword})? " yn
    case $yn in
        ${yesptrn##^} ) make install; break;;
        ${noptrn##^} ) exit;;
        * ) echo -e "\nAnswer ${yesword} / ${noword}.";;
    esac
done
