# Transfer a gist to a GitHub repository

##### clone the gist
`git clone https://gist.github.com/ishu3101/6fb35afd237e42ef25f9`

##### rename the directory
`mv 6fb35afd237e42ef25f9 ConvertTo-Markdown`

##### change the working directory to the newly renamed directory
`cd ConvertTo-Markdown`

##### create a new repository on github

##### add the github repository as a remote to your checked out gist repository
`git remote add github https://github.com/ishu3101/ConvertTo-Markdown`

##### push to the new repository on github
`git push github master`

##### rename the remote of gist
`git remote rename origin gist`

##### Each time you make changes (or pull changes from github/gist), you can do
```
git push github master   # To github
git push gist master     # To gist
```

This will also push back your changes to the gist and not only the github repo.