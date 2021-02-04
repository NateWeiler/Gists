#!/bin/bash

echo What is the 'GitHub User '
read $GitHubUser
curl -s "https://api.github.com/orgs/$GitHubUser/repos?per_page=1000&type=all" | jq -r '.[].html_url' | xargs -L1 git clone
