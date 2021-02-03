
#!/bin/bash

echo What is the 'GitHub User '
read $GitHubUser
curl -s https://api.github.com/users/$GitHubUser/repos | grep \"clone_url\" | awk '{print $2}' | sed -e 's/"//g' -e 's/,//g' | xargs -n1 git clone
