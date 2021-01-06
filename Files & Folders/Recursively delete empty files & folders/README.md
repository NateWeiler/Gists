# Recursively delete empty directories

---

## List the directories deeply-nested-first

```
$ find . -depth -type d -exec rm -rf {} \; 2>/dev/null
```

---

## Tree is walked from the leaves without the need to specify -depth as it is implied by -delete

```
$ find . -type d -empty -print
```

```
$ find . -type d -empty -delete
```

	-type d restricts to directories
	-empty restricts to empty ones
	-print prints each directory
	-delete removes each directory

---

# CMD

```
$ find "$HOME" -type d -exec rm -rf {} + 2>/dev/null
```

```
$ find . -depth -type d -print0 | xargs -0 rm -rf 2>/dev/null
```

```
$ find . -depth -type d -exec rm -rf {} + 2>/dev/null
```

```
$ find . -depth -type d -empty -exec rm -rf {} \;
```

```
$ find . -depth -type d -exec rm -rf {} +
```

---

# PowerShell


```
dir -Directory | ? { (dir $_).Count -eq 0 } | Remove-Item
```

```
Get-ChildItem -Recurse -Directory | ? {-Not $_.EnumerateFiles('*',1) | Select-Object -First 1} | Remove-Item -Recurse -Force
```

```
$dirs = gci $tdc -directory -recurse | Where { (gci $_.fullName).count -eq 0 } | select -expandproperty FullName
```

```
$dirs | Foreach-Object { Remove-Item $_ }
```

## To ensure that hidden files and folders will be removed

```
$ tdc="C:\a\c\d"
do {
  $dirs = gci $tdc -directory -recurse | Where { (gci $_.fullName -Force).count -eq 0 } | select -expandproperty FullName
  $dirs | Foreach-Object { Remove-Item $_ }
} while ($dirs.count -gt 0)
```

## Delete empty directory in c:\temp folder

```
ls c:\temp -rec |%{ if ($_.PSIsContainer -eq $True) {if ( (ls $_.fullname -rec | measure |select -expand count ) -eq "0"  ){ ri $_.fullname -whatif}  }  }  
```

Make sure, that you delete only folders that may contain subfoldersbut no files within itself and its subfolders.

```
$Empty = Get-ChildItem $Folder -Directory -Recurse | Where-Object {(Get-ChildItem $_.FullName -File -Recurse -Force).Count -eq 0}
Foreach ($Dir in $Empty)
{
    if (test-path $Dir.FullName)
    {Remove-Item -LiteralPath $Dir.FullName -recurse -force}
}
```

##  A script block (anonymous function) that will remove empty folders under a root folder, using tail-recursion to ensure that it only walks the folder tree once. -Force is used to be able to process hidden files/folders as well.

```
$tailRecursion = {
    param(
        $Path
    )
    foreach ($childDirectory in Get-ChildItem -Force -LiteralPath $Path -Directory) {
        & $tailRecursion -Path $childDirectory.FullName
    }
    $currentChildren = Get-ChildItem -Force -LiteralPath $Path
    $isEmpty = $currentChildren -eq $null
    if ($isEmpty) {
        Write-Verbose "Removing empty folder at path '${Path}'." -Verbose
        Remove-Item -Force -LiteralPath $Path
    }
}
```

Here's how you use it. Note that this will remove the top folder (the C:\a folder in this example, which gets created if you generated the test data using the script above) if that folder winds up being empty after deleting all empty folders under it.

```
& $tailRecursion -Path 'C:\a'
```

---

# Bash

```
$ find "$HOME" -type d -exec bash -c 'shopt -s nullglob; shopt -s dotglob; files=("$1"/*); [[ ${files[@]} ]] || rmdir -v "$1"' -- {} \;
```

```
$ shopt -s globstar
for dir in **/; do
   files=("$dir"/*)
   [[ ${files[@]} ]] || rmdir -v "$dir"
done
```

---

## Run multiple passes

```
$ while [ -n "$(find . -depth -type d -empty -print -exec rm -rf {} +)" ]; do :; done
```

---

# Aliases

### aliases for frequently used find commands. When cleaning up disk space, removing duplicates can result in a lot of empty directories. Comments inside .bashrc to not forget them.

# Find 50MB Files

```
alias find50='find / -size 50M'
```

# Find Size between 50MB � 100MB

```
alias find50-100='find / -size +50M -size -100M'

# Find and Delete 100MB Files

```
alias rm100='find / -type f -size +100M -exec rm -rf {} \;'
```

# Find Specific Files and Delete

## Find all .mp3 files with more than 10MB and delete them using one single command.

```
find / -type f -name *.mp3 -size +10M -exec rm {} \;
```

# Rename .git folders

```
alias dot='find . -maxdepth 10 -type d | while read FNAME; do mv "$FNAME" "${FNAME//.git/DOTgit}"; done'
```

```
alias undot='find . -maxdepth 10 -type d | while read FNAME; do mv "$FNAME" "${FNAME//DOTgit/.git}"; done'
```

# Find empty directories

```
alias find-empty='find . -type d -empty'
```

# Find empty sized files

```
alias find-0='find . -type f -empty'
```

# For removing 0 sized files, we can't de-dupe them automatically since they are technically all the same, so they are typically left beind. this removes them if needed.

```
alias find-0-rm='find-0 -exec rm -rf {} +'
```

```
alias find-0-rm1='find -0 -print0 | xargs -0 rm -rf'
```

```
alias find-0-rm2='find -0 -delete'
```

# Delete all empty directories

```
alias find-empty-rm='while [ -n "$(find . -depth -type d -empty -print -exec rm -rf {} +)" ]; do :; done'
```

```
alias find-empty-rm1='find . -depth -type d -exec rm -rf {} \; 2>/dev/null"
```

```
alias find-empty-rm2='find -empty -delete'
```

# Delete empty directories when `-delete` option is not available. output null character (instead of newline) as separator. used together with `xargs -0`, will handle filenames with spaces and special chars.

```
alias find-empty-rm3='find-empty -print0 | xargs -0 rmdir -p'
```

# Alternative version using `-exec` with `+`, similar to xargs. {}: path of current file +: {} is replaced with as many pathnames as possible for each invocation.

```
alias find-empty-delete4='find -empty -exec rmdir -p {} +'
```

# find empty directories

```
alias find-empty='find . -type d -empty'
```

# find empty/zero sized files

```
alias find-zero='find . -type f -empty'
```

# delete all empty directories

```
alias find-empty-delete='find-empty -delete'
```
# delete empty directories when `-delete` option is not available. output null character (instead of newline) as separator. used together with `xargs -0`, will handle filenames with spaces and special chars.

```
alias find-empty-delete2='find-empty -print0 | xargs -0 rmdir -p'
```

# alternative version using `-exec` with `+`, similar to xargs. {}: path of current file +: {} is replaced with as many pathnames as possible for each invocation.

```
alias find-empty-delete3='find-empty -exec rmdir -p {} +'
```

# for removing zero sized files, we can't de-dupe them automatically since they are technically all the same, so they are typically left beind. this removes them if needed.

```
alias find-zero-delete='find-zero -delete'
```

```
alias find-zero-delete2='find-zero -print0 | xargs -0 rm -rf'
```

```
alias find-zero-delete3='find-zero -exec rm -rf {} +'
```

---

## Find Specific Files and Delete

### Find all .mp3 files with more than 10MB and delete them using one single command.

```
find / -type f -name *.mp3 -size +10M -exec rm {} \;
```

---
