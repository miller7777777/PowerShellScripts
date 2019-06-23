powershell -Command Set-ExecutionPolicy RemoteSigned

powershell -Command Set-ExecutionPolicy -Scope CurrentUser RemoteSigned

powershell .\LicDataExtract_v2.ps1

powershell -Command Set-ExecutionPolicy Restricted

exit