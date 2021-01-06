#!/bin/bash

echo "List the directories deeply nested first"

echo "Tree is walked from the leaves without the need to specify -depth as it is implied by -delete"

echo "	-type d restricts to directories'

echo "	-empty restricts to empty ones'

echo "	-print prints each directory'

echo "	-delete removes each directory'

find . -type d -empty -print

find . -type d -empty -delete

find . -depth -type d -exec rm -rf {} \; 2>/dev/null
