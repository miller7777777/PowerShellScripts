# $wshell = New-Object -ComObject Wscript.Shell
# $Output = $wshell.Popup("������ ������������ ������ ��������")

Add-Type -AssemblyName System.Windows.Forms
$global:balmsg = New-Object System.Windows.Forms.NotifyIcon
$path = (Get-Process -id $pid).Path
$balmsg.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path)
$balmsg.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::Info
$balmsg.BalloonTipText = '��� ����� ������������ ��������� ��� ������������ Windows 10'
$balmsg.BalloonTipTitle = "�������� $Env:USERNAME"
$balmsg.Visible = $true
$balmsg.ShowBalloonTip(10000)