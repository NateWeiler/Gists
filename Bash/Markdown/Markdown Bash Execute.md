# How to Execute Bash in Markdown

## Add this to your .bashrc or .zshrc

### Execute `bash` code block from a markdown 

### file &rarr; ```bash [...] ```

call with `mbe file.md`

---

```bash
# Markdown Bash Execute
function mbe() {
  if [ -f "$1" ]; then
    cat $1 | # print the file
    sed -n '/```bash/,/```/p' | # get the bash code blocks
    sed 's/```bash//g' | #  remove the ```bash
    sed 's/```//g' | # remove the trailing ```
    sed '/^$/d' | # remove empty lines
    /usr/bin/env sh ; # execute the command
  else
echo "${1} is not valid" ;
  fi
}
```

---

# This one will print out text in between (+respecting indentation)

### ```bash [...] ```

call with mbe ./scripts/setup/README.md

```
## Markdown Bash Execute
function mbe() {
  if [ -f "$1" ]; then
    code=false
    while IFS= read -r line; do
        if [[ $line =~ "\`\`\`bash" ]]; then
            buff=""
            code=true
        elif [[ $line =~ "\`\`\`" ]]; then
            echo "$space$ $buff$space>"
            code=false
			eval $(echo ${buff} | sed -e 's/^[[:space:]]*//') 2>&1 | sed -e "s/^/$space  /" || exit 1
        elif $code; then
            space=$(echo "$line" | sed -e 's/^\([[:space:]]*\).*/\1/')
            trimmed=$(echo "$line" | sed 's/"/\"/' | sed -e 's/^[[:space:]]*//')
			buff="$buff$trimmed
"
		else
			echo "$line"
        fi
    done < "$1"
  else
    echo "${1} is not valid" ;
  fi
}
```

---
