# Commands to recursively find files or folders, and rename them.

---

## Find Files

```
$ find . -type f -name "*.md" -print > 'Some File.txt'
```

```
$ find . -depth -type f -name "*.md" -print > 'Some File.txt'
```

```
$ find . -maxdepth 10 -type f -name "*.md" -print > 'Some File.txt'
```

  ### add to a file by adding a ```>>```

## Find empty sized files

```
find . -type f -empty
```
# Find Files Using Name in Current Directory

## Find all the files whose name is some-file.txt in a current working directory.

```
find . -name some-file.txt ./some-file.txt
```

# Find Files Under Home Directory

## Find all the files under /home directory with name some-file.txt.

```
find /home -name some-file.txt /home/some-file.txt
```

## Find Files Using Name and Ignoring Case

### Find all the files whose name is some-file.txtsome-file.txt and contains both capital and small letters in /home directory.

```
find /home -iname some-file.txt ./some-file.txt ./Some-file.txt
```

## Find Directories Using Name

### Find all directories whose name is some-file in / directory.

```
find / -type d -name Some-file /Some-file
```

## Find PHP Files Using Name

### Find all php files whose name is some-file.php in a current working directory.

```
find . -type f -name some-file.php ./some-file.php
```

## Find all PHP Files in Directory

### Find all php files in a directory.

```
find . -type f -name "*.php" ./some-file.php ./login.php ./index.php
```

---

# Part II – Find Files Based on their Permissions

### Find all the files whose permissions are 777.

```
find . -type f -perm 0777 -print
```

```
find / -type f ! -perm 777
```

## Find SGID Files with 644 Permissions

### Find all the SGID bit files whose permissions set to 644.

```
find / -perm 2644
```

## Find Sticky Bit Files with 551 Permissions

### Find all the Sticky Bit set files whose permission are 551.

```
find / -perm 1551
```

## Find SUID Files

### Find all SUID set files.

```
find / -perm /u=s
```

## Find SGID Files

### Find all SGID set files.

```
find / -perm /g=s
```

## Find Read Only Files

### Find all Read Only files.

```
find / -perm /u=r
```

## Find Executable Files

### Find all Executable files.

```
find / -perm /a=x
```

## Find Files with 777 Permissions and Chmod to 644

### Find all 777 permission files and use chmod command to set permissions to 644.

```
find / -type f -perm 0777 -print -exec chmod 644 {} \;
```

## Find Directories with 777 Permissions and Chmod to 755

### Find all 777 permission directories and use chmod command to set permissions to 755.

```
find / -type d -perm 777 -print -exec chmod 755 {} \;
```

## Find and remove single File

### To find a single file called some-file.txt and remove it.

```
find . -type f -name "some-file.txt" -exec rm -f {} \;
```

## Find and remove Multiple File

### To find and remove multiple files such as .mp3 or .txt, then use.

```
find . -type f -name "*.txt" -exec rm -f {} \;
```

OR

```
find . -type f -name "*.mp3" -exec rm -f {} \;
```

## Find all Empty Files

### To find all empty files under a certain path.

```
find /tmp -type f -empty
```

## Find all Empty Directories

### To file all empty directories under a certain path.

```
find /tmp -type d -empty
```

## File all Hidden Files

### To find all hidden files, use the below command.

```
find /tmp -type f -name ".*"
```

---

# Part III – Search Files Based On Owners and Groups

## Find Single File Based on User

### To find all or single file called some-file.txt under / root directory of owner root.

```
find / -user root -name some-file.txt
```

## Find all Files Based on User

### To find all files that belong to user Some-file under /home directory.

```
find /home -user some-file
```

## Find all Files Based on Group

### To find all files that belong to the group Developer under /home directory.

```
find /home -group developer
```

## Find Particular Files of User

### To find all .txt files of user Some-file under /home directory.

```
find /home -user some-file -iname "*.txt"
```

---

# Part IV – Find Files and Directories Based on Date and Time

## Find Last 50 Days Modified Files

### To find all the files which are modified 50 days back.

```
find / -mtime 50
```

## Find Last 50 Days Accessed Files

### To find all the files which are accessed 50 days back.

```
find / -atime 50
```

## Find Last 50-100 Days Modified Files

### To find all the files which are modified more than 50 days back and less than 100 days.

```
find / -mtime +50 –mtime -100
```

## Find Changed Files in Last 1 Hour

### To find all the files which are changed in the last 1 hour.

```
find / -cmin -60
```

## Find Modified Files in Last 1 Hour

### To find all the files which are modified in the last 1 hour.

```
find / -mmin -60
```

## Find Accessed Files in Last 1 Hour

### To find all the files which are accessed in the last 1 hour.

```
find / -amin -60
```

---

# Part V – Find Files and Directories Based on Size

## Find 50MB Files

### To find all 50MB files, use.

```
find / -size 50M
```

## Find Size between 50MB – 100MB

### To find all the files which are greater than 50MB and less than 100MB.

```
find / -size +50M -size -100M
```

## Find and Delete 100MB Files

### To find all 100MB files and delete them using one single command.

```
find / -type f -size +100M -exec rm -f {} \;
```

## Find Specific Files and Delete

### Find all .mp3 files with more than 10MB and delete them using one single command.

```
find / -type f -name *.mp3 -size +10M -exec rm {} \;
```

---

## Rename Files

```
$ find . -type f | while read FNAME; do mv "$FNAME" "${FNAME//Old/New}"; done
```

```
$ find . -depth -type f | while read FNAME; do mv "$FNAME" "${FNAME//Old/New}"; done 
```

```
$ find . -maxdepth 10 -type f | while read FNAME; do mv "$FNAME" "${FNAME//Old/New}"; done
```

---

## Recursively Find & rename Files by name
 
```
$ find . -name '*.md' -exec sh -c 'mv "$0" "${0%.md}.txt"' {} ;
```

```
$ find . -depth -name '*.md' -exec sh -c 'mv "$0" "${0%.md}.txt"' {} ;
```

```
$ find . -maxdepth 10 -name '*.md' -exec sh -c 'mv "$0" "${0%.md}.txt"' {} ;
```

---

## Recursively Find & rename Files by -name & -type f

```
$ find . -type f | while read FNAME; do mv "$FNAME" "${FNAME//.git/DOTgit}"; done
```

```
$ find . -depth -type f | while read FNAME; do mv "$FNAME" "${FNAME//.git/DOTgit}"; done
```

```
$ find . -maxdepth 10 -type f | while read FNAME; do mv "$FNAME" "${FNAME//.git/DOTgit}"; done
```

---

## Find Folders(Directories)

```
$ find . -type d -name ".git" -print > 'Some File.txt'
```

```
$ find . -depth -type d -name ".git" -print > 'Some File.txt'
```

```
$ find . -maxdepth 10 -type d -name ".git" -print > 'Some File.txt'
```

  ### add to a file by adding a ```>>```


## Find empty directories

```
find . -type d -empty
```

---

## Rename Folders(Directories)

```
$ find . -type d | while read FNAME; do echo "$FNAME" "${FNAME//Old/New}"; done
```

```
find . -depth -type d | while read FNAME; do echo "$FNAME" "${FNAME//Old/New}"; done
```

```
find . -maxdepth 10 -type d | while read FNAME; do echo "$FNAME" "${FNAME//Old/New}"; done
```

---

## Recursively Find & rename Folders(Directories) by -name & -type d

```
$ find . -type d | while read FNAME; do mv "$FNAME" "${FNAME//.git/DOTgit}"; done
```

```
$ find . -depth -type d | while read FNAME; do mv "$FNAME" "${FNAME//.git/DOTgit}"; done
```

```
$ find . -maxdepth 10 -type d | while read FNAME; do mv "$FNAME" "${FNAME//.git/DOTgit}"; done
```

---
