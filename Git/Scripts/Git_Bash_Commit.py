import sh
git = sh.git.bake(_cwd=''/Users/njweiler192/Application/GitHub')
print git.status()
# checkout and track a remote branch
print git.checkout('-b', 'remotebranch')
# add a file
print git.add('-A')
# commit
print git.commit(m='my commit message')
# now we are one commit ahead
print git.status()
