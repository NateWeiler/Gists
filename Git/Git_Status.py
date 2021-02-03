import os
import string
from subprocess import *

repoDir = '/Users/njweiler192/Application/GitHub'

def command(x):
    return str(Popen(x.split(' '), stdout=PIPE).communicate()[0])

def rm_empty(L): return [l for l in L if (l and l!="")]

def getUntracked():
    os.chdir(repoDir)
    status = command("git status")
    if "# Untracked files:" in status:
        untf = status.split("# Untracked files:")[1][1:].split("\n")
        return rm_empty([x[2:] for x in untf if string.strip(x) != "#" and x.startswith("#\t")])
    else:
        return []

def getNew():
    os.chdir(repoDir)
    status = command("git status").split("\n")
    return [x[14:] for x in status if x.startswith("#\tnew file:   ")]

def getModified():
    os.chdir(repoDir)
    status = command("git status").split("\n")
    return [x[14:] for x in status if x.startswith("#\tmodified:   ")]

print("Untracked:")
print( getUntracked() )
print("New:")
print( getNew() )
print("Modified:")
print( getModified() )
