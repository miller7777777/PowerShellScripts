$clients = @()
$clients = Get-Content "C:\Temp\Клиенты.txt" -Encoding "UTF8"
$clients[1]
$clients.Length