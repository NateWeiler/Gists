# PowerShell

dir -Directory | ? { (dir $_).Count -eq 0 } | Remove-Item


Get-ChildItem -Recurse -Directory | ? {-Not $_.EnumerateFiles('*',1) | Select-Object -First 1} | Remove-Item -Recurse -Force


$dirs = gci $tdc -directory -recurse | Where { (gci $_.fullName).count -eq 0 } | select -expandproperty FullName


$dirs | Foreach-Object { Remove-Item $_ }


echo "To ensure that hidden files and folders will be removed"


$ tdc="C:\a\c\d"
do {
  $dirs = gci $tdc -directory -recurse | Where { (gci $_.fullName -Force).count -eq 0 } | select -expandproperty FullName
  $dirs | Foreach-Object { Remove-Item $_ }
} while ($dirs.count -gt 0)


echo "Delete empty directory in c:\temp folder"


ls c:\temp -rec |%{ if ($_.PSIsContainer -eq $True) {if ( (ls $_.fullname -rec | measure |select -expand count ) -eq "0"  ){ ri $_.fullname -whatif}  }  }  


echo "Make sure, that you delete only folders that may contain subfoldersbut no files within itself and its subfolders."


$Empty = Get-ChildItem $Folder -Directory -Recurse | Where-Object {(Get-ChildItem $_.FullName -File -Recurse -Force).Count -eq 0}
Foreach ($Dir in $Empty)
{
    if (test-path $Dir.FullName)
    {Remove-Item -LiteralPath $Dir.FullName -recurse -force}
}


echo " A script block (anonymous function) that will remove empty folders under a root folder, using tail-recursion to ensure that it only walks the folder tree once. -Force is used to be able to process hidden files/folders as well."


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


echo "Here's how you use it. Note that this will remove the top folder (the C:\a folder in this example, which gets created if you generated the test data using the script above) if that folder winds up being empty after deleting all empty folders under it."

& $tailRecursion -Path 'C:\a'
