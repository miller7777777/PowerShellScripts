<#
    CertificateInjector;
    Version: 1.1;

    Скрипт предназначен для:
    - извлечения ссылок на корневой сертификат удостоверяющего центра и списка отзывов из файла сертификата клиента;
    - загрузки корневого сертификата удостоверяющего центра и списка отзывов;
    - установки корневого сертификата удостоверяющего центра и списка отзывов;
#>

#    Графическое окно выбора папки; Установка папки с сертификатами;

$object = New-Object -comObject Shell.Application 
$folder = $object.BrowseForFolder(0, 'Выберите папку: ', 0,0)
if ($folder -ne $null) {"выбранная папка $($folder.Self.Path)"
$certDirectory = $folder.Self.Path
}
$certDirectory

# извлечениe ссылок на корневой сертификат удостоверяющего центра и списка отзывов из файла сертификата клиента;

$RootCertArray = @()
$RecalledCertList =@()

# Этот код написан pan_2, за что ему огромное спасибо.

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
$RootCertArray += $AIA
$CRL
$RecalledCertList += $CRL
}
$Links = $RootCertArray + $RecalledCertList

# Проверка типа запуска службы BITS и попытка ее запуска;

set-service remoteregistry -StartupType Automatic
start-service bits -PassThru


# Загрузка корневого сертификата удостоверяющего центра и списка отзывов из сети;

Import-Module BitsTransfer
$local_path = $certDirectory + '\CRT_CRL_Downloads\'
md $local_path
foreach ($link in $Links) {
Start-BitsTransfer -Source $Link -Destination $local_path
}

# Установка списка отзывов;

$fileList = Get-ChildItem $local_path | ? {$_.extension -match '\.crl'}
cd $local_path
# For each cert in the folder
foreach ($file in $fileList) {

#Invoke-Item -Path $file
certutil -addstore CA $file
}

# Открытие корневых сертификатов удостоверяющих центров (для ручной установки);

# $fileList = Get-ChildItem $local_path | ? {$_.extension -match '\.crt|\.cer'}
# cd $local_path
# # For each cert in the folder
# foreach ($file in $fileList) {
# #$file
# Invoke-Item -Path $file
# }

# Функция установки корневых сертификатов
# Author: Pan_2
function Import-CertificateX509 {
    param (
    [string]$Path
    )
    try {
    $CertificatePath = (Get-item $Path).fullname
    }
    catch {
    throw ("Can't get the full path for the supplied name: {0}" -f $Path)
    }
    
    $Certificate = new-object system.security.cryptography.x509certificates.x509certificate2
    $Certificate.Import($CertificatePath)
    
    #Trusted Root Certification Authorities
    $store = Get-Item cert:\LocalMachine\Root
    $store.Open([System.Security.Cryptography.X509Certificates.OpenFlags]"ReadWrite")
    $store.add($Certificate)
    $store.Close()
    }


# Установка корневых сертификатов удостоверяющих центров

$fileList = Get-ChildItem $local_path | ? {$_.extension -match '\.crt|\.cer'}
cd $local_path
# For each cert in the folder
foreach ($file in $fileList) {
# $file
# Invoke-Item -Path $file
Import-CertificateX509 $file
}