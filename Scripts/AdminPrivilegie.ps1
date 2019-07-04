Write-Host "Проверка наличия прав администратора..."
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
[Security.Principal.WindowsBuiltInRole] "Administrator")) {
# Write-Warning "Недостаточно прав для выполнения этого скрипта. Откройте консоль PowerShell с правами администратора и запустите скрипт еще раз"
Start-Process Powershell -ArgumentList $PSCommandPath -Verb RunAs
Break
}
else {
Write-Host "Права администратора есть – продолжить скрипт..." -ForegroundColor Green
}
