$CertObject.Extensions | % {$_.oid}$CertObject.Extensions | % {$_.oid}$certDirectory = "c:\Temp\Cer"
$certList = Get-ChildItem $certDirectory | ? {$_.extension -match '\.crt|\.cer'}
# For each cert in the folder
foreach ($cert in $certList) {
$CertObject = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2
$CertObject.Import($cert.fullname)
$AIA = $CertObject.Extensions | ? {$_.oid.value -eq '1.3.6.1.5.5.7.1.1'}
if ($AIA) {
if ($aia.Format(1) -match 'URL=(http.+(crt|cer))'){

$Matches[1]

$CertObject.Extensions | % {$_.oid}
}
}
else {
#no AIA OID found
} 
}