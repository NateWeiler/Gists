#!bin/bash

# Examples that shows how to use variables as replace and search values
# using both sed and Bash

find='/nfsroot'
replace='/efsroot'
sed -i'.backup' "s+${find}+${replace}+g" input.txt

# or test it on string #
string='AWS config for shared storage location: /nfsroot'
sed "s+${find}+${replace}+g" <<<"$string"

# how about pure bash string manipulation with variables? #
find='/nfsroot'
replace='/efsroot'
string='AWS config for shared storage location: /nfsroot'
echo "Current string: $string"
echo "Updated string: ${string/${find}/${replace}}"
