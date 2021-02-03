set -euo pipefail

#GITHUB_API_TOKEN=$(mimipass get github-api-token)
CODE_DIR=$HOME/Desktop/REPOS

echo What is the 'GitHub_User '
#GitHub_User=$GitHub_User

repos_url="https://api.github.com/users/$GitHub_User/repos"
#auth_header="Authorization: token $GITHUB_API_TOKEN"
POOL_SIZE=10
parallel() {
       local proc procs outputs tempfile morework
       declare -a procs=()
       declare -A outputs=()

       morework=true
       while $morework; do
           if [[ "${#procs[@]}" -lt "$POOL_SIZE" ]]; then
               read proc || { morework=false; continue ;}

               tempfile=$(mktemp)
               eval "$proc" >$tempfile 2>&1 &

               procs["${#procs[@]}"]="$!"
               outputs["$!"]=$tempfile
           fi

           for n in "${!procs[@]}"; do
               pid=${procs[n]}
               kill -0 $pid 2>/dev/null && continue

               cat "${outputs[$pid]}"
               unset procs[$n] outputs[$pid]
           done
       done

       wait
       for out in "${outputs[@]}"; do cat $out; done
   }

fetch-repos() {
    # don't foolf yourself. These nested function
    # definitions are global. Bash is not Scheme.
    function get-next-page {
        # Here we "parse" some text to check if it contains a
        # "next-page" link (see footnotes)
        if [[ "$@" =~ \<(.*)\>\;\ rel\=\"next\" ]]; then
            # If there is a next page, we output it.
            echo "${BASH_REMATCH[1]}"
        fi
    }

    function fetch-repos-rec {
        # Here we will recursively (hence the -rec) fetch the
        # repositories form the api
        [ "$#" = 0 ] && return 0

        url=$1

        # request the headers
        header=$(curl -sSI -H "${auth_header}" $url)
        # extract out of array
        repos=$(curl -sS -H "${auth_header}" $url | jq '.[]')

        # get-next-page will return the next page or empty string
        next_page=$(get-next-page "${header}")

        # if $next_page is not the empty string, keep recursing
        [ -n $next_page ] && \
          echo "${repos}" "$(fetch-repos-rec ${next_page})"
    }

    # join all repositories into an array
    fetch-repos-rec $1 | jq --slurp '.'
}

mkdir -p $CODE_DIR; cd $CODE_DIR

fetch-repos "${repos_url}" \
  | jq '.[] | .ssh_url' \
  | awk '{ print "git clone " $1 }' \
  | parallel
