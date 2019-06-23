set-executionpolicy remotesigned
ring license list --path c:\TEMP\License\ | Out-File C:\Temp\License\PinCode-RegNumber.txt
$a = Get-Content c:\TEMP\License\PinCode-RegNumber.txt
ring license info --name $a --path c:\TEMP\License\ | Out-File C:\Temp\License\LicData.txt