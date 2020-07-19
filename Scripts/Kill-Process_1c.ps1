<#
Завершаем все процессы 1С.
#>

Get-Process | Where-Object {$_.ProcessName -like "1cv8c"} | Stop-Process -Force -processname {$_.ProcessName} -Verbose