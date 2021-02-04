#!/bin/bash

if [ -z "$1" ]; then
    echo "waiting for the following arguments: username + max-page-number"
    exit 1
else
    name=$1
fi

if [ -z "$2" ]; then
    max=2
else
    max=$2
fi

cntx="users"
page=1

echo $name
echo $max
echo $cntx
echo $page

until (( $page -lt $max ))
do
    curl "https://gitlab.com/api/v4/$cntx/$name/projects?page=1&per_page=1000" | jq -r '.[].html_url' | xargs -L1 git clone
    $page=$page+1
done

exit 0
