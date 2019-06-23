# Скрипт извлекает из файла сертификата пользователя
# ссылку на корневой сертификат удостоверяющего центра и список отзывов
#
# Этот код написан pan_2, за что ему огромное спасибо.
$certDirectory = "c:\TEMP\Cert"
$certList = Get-ChildItem $certDirectory | ? {$_.extension -match '\.crt|\.cer'}
# For each cert in the folder
foreach ($cert in $certList) {
$CertObject = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2
$CertObject.Import($cert.fullname)
$certAIA = $CertObject.Extensions | ? {$_.oid.value -eq '1.3.6.1.5.5.7.1.1'}
$certCRL = $CertObject.Extensions | ? {$_.oid.value -eq '2.5.29.31'}
$regex = 'URL=(http[s]*\:\/\/.+(crt|cer|crl))'

if ($certAIA) {
$string = $certAIA.Format(1)
$ssMatches = @( $string | Select-String -Pattern $regex -AllMatches )
$AIA = @($ssMatches.Matches.value -replace 'URL=')
}
else {
#no AIA OID foundcls
}

if ($certCRL) {
$string = $certCRL.Format(1)
$ssMatches = @( $string | Select-String -Pattern $regex -AllMatches )
$CRL = @($ssMatches.Matches.value -replace 'URL=')
}
else {
#no CRL OID found
}

$AIA
$CRL
}