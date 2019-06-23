$PathOfDir = "C:\Temp\"
$Date = Get-Date
$NameOfDir = $Date.Year.ToString() + "-" + $Date.Month.ToString() + "-" + $Date.Day.ToString()
#Write-Host($NameOfDir)
$PathOfDir += $NameOfDir
Write-Host($PathOfDir)
md($PathOfDir)