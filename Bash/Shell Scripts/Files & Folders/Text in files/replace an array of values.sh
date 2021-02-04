#!/bin/bash

input="config_template.txt"
output="rds.db_conf.php"

# Build php config file for my app
echo '<?php' > "$output"
cat "$input" >> "$output"
# Define a new bash array. Format is:
# [search_string]=replace_value

declare -A rds_secrets
rds_secrets=(
  [__USER__]=myysql_db_user_foo
  [__NAME__]=mysql_db_name_bar
  [__PASSWORD__]=my_complex_password_goes_here
  [__HOST__]=xyz.us-east-1.rds.amazonaws.com
)

#
# Do find and replace on $output while reading
# AWS RDS connection info from rds_secrets() bash array

for s in "${!rds_secrets[@]}"
do
	find="$s"
	replace=${rds_secrets[$s]}
	sed -i "s/${find}/${replace}/g" "$output"
done

# Close PHP config file brackets
echo '?>' >> "$output"
