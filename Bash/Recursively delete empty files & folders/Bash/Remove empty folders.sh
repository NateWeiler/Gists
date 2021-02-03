#!/system/bin/sh

echo "get directory list"

find . -type d -print > dirs$$
# reverse the listing
tail -r dirs$$ > revdirs$$

while read dirname
do
    rmdir $dirname 2>/dev/null
done < revdirs$$

echo "clean up"

rm -rf dirs$$

rm -rf revdirs$$
