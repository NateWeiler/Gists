import time
import subprocess
def gitAdd(fileName, repoDir):
    cmd = 'git add ' + fileName
    pipe = subprocess.Popen(cmd, shell=True, cwd=repoDir,stdout = subprocess.PIPE,stderr = subprocess.PIPE )
    (out, error) = pipe.communicate()
    print out,error
    pipe.wait()
    return 

def gitCommit(commitMessage, repoDir):
    cmd = 'git commit -am "%s"'%commitMessage
    pipe = subprocess.Popen(cmd, shell=True, cwd=repoDir,stdout = subprocess.PIPE,stderr = subprocess.PIPE )
    (out, error) = pipe.communicate()
    print out,error
    pipe.wait()
    return 
def gitPush(repoDir):
    cmd = 'git push '
    pipe = subprocess.Popen(cmd, shell=True, cwd=repoDir,stdout = subprocess.PIPE,stderr = subprocess.PIPE )
    (out, error) = pipe.communicate()
    pipe.wait()
    return 

temp=time.localtime(time.time())
uploaddate= str(temp[0])+'_'+str(temp[1])+'_'+str(temp[2])+'_'+str(temp[3])+'_'+str(temp[4])

repoDir='d:\\c_Billy\\vfat\\Programming\\Projector\\billyccm' # your git repository , windows your need to use double backslash for right directory.
gitAdd('.',repoDir )
gitCommit(uploaddate, repoDir)
gitPush(repoDir)
