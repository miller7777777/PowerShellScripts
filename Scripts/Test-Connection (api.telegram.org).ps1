# Test-Connection "https://api.telegram.org"
if ((Test-Connection -computer https://api.telegram.org -quiet) -eq $True)
{Write-Host ":)"}
Else {Write-Host ":("}