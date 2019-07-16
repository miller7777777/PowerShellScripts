# Путь к папке-источнику
$sourceFolder = "c:\Soft\Rufus"
# Путь к папке назначения
$backupFolder = ""

$sourceFile = $sourceFolder + "\*.zip"

Test-Path $sourceFile

do {
    Start-Sleep 10
} until (Test-Path $sourceFile)
Write-Host "Есть!"
$b = Get-ChildItem $sourceFolder

$b