$clients = @()
$clients = Get-Content "C:\Temp\�������.txt" -Encoding "UTF8"
$clients[1]
$clients.Length