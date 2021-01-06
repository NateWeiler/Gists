#!/bin/bash

echo "Prompt a user for confirmation in bash script Function & Example"

echo "Do something really dangerous..."

echo "The output is always 'yes' or 'no'"

echo "It's 'no' by default"

echo "Everything except 'y' or 'yes' returns 'no', so it's pretty safe for a dangerous bash script"

echo "And it's case insensitive, 'Y', 'Yes', or 'YES' work as 'yes'."

function ask_yes_or_no() {
    read -p "$1 ([y]es or [N]o): "
    case $(echo $REPLY | tr '[A-Z]' '[a-z]') in
        y|yes) echo "yes" ;;
        *)     echo "no" ;;
    esac
}

echo "And an example using it"

if [[ "no" == $(ask_yes_or_no "Are you sure?") || \
      "no" == $(ask_yes_or_no "Are you *really* sure?") ]]
then
    echo "Skipped."
    exit 0
fi
