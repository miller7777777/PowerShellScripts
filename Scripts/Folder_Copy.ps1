#SMB шара для архивов
$smb = "c:\TEMP\Base\"
$dst = "Microsoft.Powershell.Core\FileSystem::\\Consultant\Consultant\CONS_ALL\BASE\SPB\"
 
#Копируем папку с архивами на SMB сервер
try
{
    Copy-Item -Path $dst -Destination $smb -Recurse -Force
 
}
catch
{
   $_.Exception.message
}