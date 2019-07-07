$disk = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'" |
Select-Object Size,FreeSpace

$disk.Size
$disk.FreeSpace
$a = $disk.Size/1GB
$a
$b = $disk.FreeSpace/1GB
$b
$b = [math]::Round($b, 2)
$b