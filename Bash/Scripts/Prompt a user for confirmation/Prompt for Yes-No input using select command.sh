#!/bin/bash

echo "Prompt for Yes/No input using select command"

echo "Do you wish to install this program?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) make install; break;;
        No ) exit;;
    esac
done
