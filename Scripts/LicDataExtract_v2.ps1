Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
$object = New-Object -comObject Shell.Application 
$folder = $object.BrowseForFolder(0, 'Выберите папку:', 0,0)
if ($folder -ne $null) {
$folderPath = $folder.Self.Path
"выбранная папка $($folderPath)"
}

set-executionpolicy remotesigned
ring license list --path $folderPath | Out-File $folderPath\PinCode-RegNumber.txt
$a = Get-Content $folderPath\PinCode-RegNumber.txt
ring license info --name $a --path $folderPath | Out-File $folderPath\LicData.txt -Encoding oem