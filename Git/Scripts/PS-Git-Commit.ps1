git branch -r | ForEach-Object {
    # Skip default branch, this script assumes
    # you already checked-out that branch when cloned the repo
    if (-not ($_ -match " -> ")) {
        $localBranch = ($_ -replace "^.*/", "")
        $remoteBranch = $_.Trim()
        git branch --track "$localBranch" "$remoteBranch"
    }
}
git branch -r | grep -v '\->' | while read remote; do git branch --track "${remote#origin/}" "$remote"; done
git fetch origin master && git rebase origin/master
git push origin --force --all && git remote update
git add -A
git commit && git checked-out
git push --set-upstream origin TEMP_BRANCH
git pull TEMP_BRANCH
git status
