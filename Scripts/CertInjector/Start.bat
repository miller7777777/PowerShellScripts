powershell -Command Set-ExecutionPolicy RemoteSigned

powershell -Command Set-ExecutionPolicy -Scope CurrentUser RemoteSigned

powershell CertificateInjector.ps1

powershell -Command Set-ExecutionPolicy Restricted

pause 0