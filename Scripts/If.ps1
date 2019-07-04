function ShowMessage {
    param (
        [string]$Message, $IconType
    )
    
if (!$IconType) {
    $IconType = "Warning"
}
Add-Type -AssemblyName System.Windows.Forms
$global:balmsg = New-Object System.Windows.Forms.NotifyIcon
$path = (Get-Process -id $pid).Path
$balmsg.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path)
$balmsg.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::$IconType
$balmsg.BalloonTipText = $Message
$balmsg.BalloonTipTitle = "Внимание $Env:USERNAME"
$balmsg.Visible = $true
$balmsg.ShowBalloonTip(10000)
}

$Links = @()

if (!$Links -or $Links.Length -eq 0) {
    $Message = "Ошибка извлечения ссылок"
    $IconType = "Error"

    ShowMessage $Message $IconType

    Write-Host $Message
    Pause
    Break
}

Write-Host "HHHHHHHHH"