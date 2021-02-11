#!/bin/bash

echo -e "\nPrompt a user for confirmation in bash script Function & Example"

echo -e "\nDo something really dangerous..."

echo -e "\nThe output is always 'yes' or 'no'"

echo -e "\nIt's 'no' by default"

echo -e "\nEverything except 'y' or 'yes' returns 'no', so it's pretty safe for a dangerous bash script"

echo -e "\nAnd it's case insensitive, 'Y', 'Yes', or 'YES' work as 'yes'."

function ask_yes_or_no() {
    read -p "$1 ([y]es or [N]o): "
    case $(echo $REPLY | tr '[A-Z]' '[a-z]') in
        y|yes) echo -e "\nYes" ;;
        *)     echo -e "\nNo" ;;
    esac
}

echo -e "\nAnd an example using it\n"

if [[ "no" == $(ask_yes_or_no "Are you sure?") || \
      "no" == $(ask_yes_or_no "Are you *really* sure?") ]]
then
    echo -e "\nSkipped."
    exit 0
fi
