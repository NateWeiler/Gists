#!/bin/bash

echo "Aliases"

echo "aliases for frequently used find commands. When cleaning up disk space, removing duplicates can result in a lot of empty directories. Comments inside .bashrc to not forget them."

# find empty directories
alias find-empty='find . -type d -empty'

# find empty/empty sized files
alias find-0='find . -type f -empty'

# delete all empty directories
alias find-empty-delete='find-empty -delete'

# delete empty directories when `-delete` option is not available. output null character (instead of newline) as separator. used together with `xargs -0`, will handle filenames with spaces and special chars.
alias find-empty-delete2='find-empty -print0 | xargs -0 rmdir -p'

# alternative version using `-exec` with `+`, similar to xargs. {}: path of current file +: {} is replaced with as many pathnames as possible for each invocation.
alias find-empty-delete3='find-empty -exec rmdir -p {} +'

# for removing 0 sized files, we can't de-dupe them automatically since they are technically all the same, so they are typically left beind. this removes them if needed.
alias find-0-delete='find-0 -delete'
alias find-0-delete2='find-0 -print0 | xargs -0 rm -rf'
alias find-0-delete3='find-0 -exec rm -rf {} +'
