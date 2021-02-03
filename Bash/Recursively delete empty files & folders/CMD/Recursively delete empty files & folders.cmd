echo "Recursively delete empty files & folders"

find "$HOME" -type d -exec rm -rf {} + 2>/dev/null

find . -depth -type d -print0 | xargs -0 rm -rf 2>/dev/null

find . -depth -type d -exec rm -rf {} + 2>/dev/null

find . -depth -type d -empty -exec rm -rf {} \;

find . -depth -type d -exec rm -rf {} +
