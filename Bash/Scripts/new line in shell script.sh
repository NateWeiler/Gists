#!/bin/sh

echo -e "new line in shell script\n"

echo -e "new line using echo\n"

echo -e "Similar result, using cat\n"

echo -e "hello\nworld\n"

echo -e "new line using cat\n"

cat <<EOF

echo -e "\nnew line using printf\n"

printf "hello\nworld"

echo -e "\nprintf has more consistent behavior than echo. The behavior of echo varies greatly between different versions."
