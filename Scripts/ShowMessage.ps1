# $wshell = New-Object -ComObject Wscript.Shell
# $Output = $wshell.Popup("Скрипт формирования отчета выполнен")

Add-Type -AssemblyName System.Windows.Forms
$global:balmsg = New-Object System.Windows.Forms.NotifyIcon
$path = (Get-Process -id $pid).Path
$balmsg.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path)
$balmsg.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Info
$balmsg.BalloonTipText = 'Это текст всплывающего сообщения для пользователя Windows 10'
$balmsg.BalloonTipTitle = "Внимание $Env:USERNAME"
$balmsg.Visible = $true
$balmsg.ShowBalloonTip(10000)