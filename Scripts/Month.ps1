$dateFile = "C:\Temp\����.txt"

# $date = @()
$date = Get-Content $dateFile
Write-Host $date
$dateUnits = $date.Split("/")
Write-Host $dateUnits[1]
switch ($dateUnits[1]) {
    "01" {$month = "������ " + $dateUnits[2] }
    "02" {$month = "������� " + $dateUnits[2] }
    "03" {$month = "���� " + $dateUnits[2] }
    "04" {$month = "������ " + $dateUnits[2] }
    "05" {$month = "��� " + $dateUnits[2] }
    "06" {$month = "���� " + $dateUnits[2] }
    "07" {$month = "���� " + $dateUnits[2] }
    "08" {$month = "������ " + $dateUnits[2] }
    "09" {$month = "�������� " + $dateUnits[2] }
    "10" {$month = "������� " + $dateUnits[2] }
    "11" {$month = "������ " + $dateUnits[2] }
    "10" {$month = "������� " + $dateUnits[2] }
    DEFAULT {$month = "???"}
}

Write-Host $month