$dateFile = "C:\Temp\ƒата.txt"

# $date = @()
$date = Get-Content $dateFile
Write-Host $date
$dateUnits = $date.Split("/")
Write-Host $dateUnits[1]
switch ($dateUnits[1]) {
    "01" {$month = "€нварь " + $dateUnits[2] }
    "02" {$month = "февраль " + $dateUnits[2] }
    "03" {$month = "март " + $dateUnits[2] }
    "04" {$month = "апрель " + $dateUnits[2] }
    "05" {$month = "май " + $dateUnits[2] }
    "06" {$month = "июнь " + $dateUnits[2] }
    "07" {$month = "июль " + $dateUnits[2] }
    "08" {$month = "август " + $dateUnits[2] }
    "09" {$month = "сент€брь " + $dateUnits[2] }
    "10" {$month = "окт€брь " + $dateUnits[2] }
    "11" {$month = "но€брь " + $dateUnits[2] }
    "10" {$month = "декабрь " + $dateUnits[2] }
    DEFAULT {$month = "???"}
}

Write-Host $month