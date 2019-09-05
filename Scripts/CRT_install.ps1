$certs = New-Object system.security.cryptography.x509certificates.x509certificate2
cd c:\TEMP\Cert_1\CRT_CRL_Downloads\
$path = "c2d822fcbc0ffdc8ac4062e71fc8b3309fda36bb.crt"
$password = Read-Host "Type password for PFX certificate" -AsSecureString
$flags = "UserKeySet, Exportable"
$certs.Import($path, $password, $flags)
$store = New-Object system.security.cryptography.X509Certificates.X509Store "My", "CurrentUser"
$store.Open([System.Security.Cryptography.X509Certificates.OpenFlags]::ReadWrite)
$store.Add($certs)
$store.Close()