from git import Repo
import os

path = '/your/path/here'
if not os.path.exists(path):
    os.makedirs(path)

os.chdir(path)

repo = Repo.init(path).git

index = Repo.init(path).index

for x in xrange (1,10):
    fname = 'filename' + str(x)
    f.open(fname, 'wb+')
    f.write()
    f.close()
    repo.add(fname)

index.commit("initial commit")
