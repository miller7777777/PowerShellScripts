# ���� � �����-���������
$sourceFolder = "c:\Soft\Rufus"
# ���� � ����� ����������
$backupFolder = ""

$sourceFile = $sourceFolder + "\*.zip"

Test-Path $sourceFile

do {
    Start-Sleep 10
} until (Test-Path $sourceFile)
Write-Host "����!"
$b = Get-ChildItem $sourceFolder

$b