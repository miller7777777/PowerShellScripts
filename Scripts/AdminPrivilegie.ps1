Write-Host "�������� ������� ���� ��������������..."
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
[Security.Principal.WindowsBuiltInRole] "Administrator")) {
# Write-Warning "������������ ���� ��� ���������� ����� �������. �������� ������� PowerShell � ������� �������������� � ��������� ������ ��� ���"
Start-Process Powershell -ArgumentList $PSCommandPath -Verb RunAs
Break
}
else {
Write-Host "����� �������������� ���� � ���������� ������..." -ForegroundColor Green
}
