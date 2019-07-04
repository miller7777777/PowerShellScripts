<#
    CertificateInjector;
    Version: 1.1;

    Скрипт предназначен для:
    - извлечения ссылок на корневой сертификат удостоверяющего центра и списка отзывов из файла сертификата клиента;
    - загрузки корневого сертификата удостоверяющего центра и списка отзывов;
    - установки корневого сертификата удостоверяющего центра и списка отзывов;
#>

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
    # 
    Write-Host $Certificate "`nСертификат добавлен"
    $store.Close()
    }

# Функция вывода сообщений

    function ShowMessage {
        param (
            [string]$Message, $IconType
        )
        
    if (!$IconType) {
        $IconType = "Warning"
    }
    Add-Type -AssemblyName System.Windows.Forms
    $global:balmsg = New-Object System.Windows.Forms.NotifyIcon
    $path = (Get-Process -id $pid).Path
    $balmsg.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon($path)
    $balmsg.BalloonTipIcon = [System.Windows.Forms.ToolTipIcon]::$IconType
    $balmsg.BalloonTipText = $Message
    $balmsg.BalloonTipTitle = "Внимание $Env:USERNAME"
    $balmsg.Visible = $true
    $balmsg.ShowBalloonTip(10000)
    }

# Проверка наличия прав администратора и запрос их при необходимости;

Write-Host "Проверка наличия прав администратора..."
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
[Security.Principal.WindowsBuiltInRole] "Administrator")) {
# Write-Warning "Недостаточно прав для выполнения этого скрипта. Откройте консоль PowerShell с правами администратора и запустите скрипт еще раз"
Start-Process Powershell -ArgumentList $PSCommandPath -Verb RunAs
Break
}
else {
Write-Host "Права администратора есть – продолжить скрипт..." -ForegroundColor Green
}


# Графическое окно выбора папки; Установка папки с сертификатами;

$object = New-Object -comObject Shell.Application 
$folder = $object.BrowseForFolder(0, 'Выберите папку: ', 0,0)
if ($folder -ne $null) {"выбранная папка $($folder.Self.Path)"
$certDirectory = $folder.Self.Path
}
$certDirectory

# Извлечениe ссылок на корневой сертификат удостоверяющего центра и списка отзывов из файла сертификата клиента;

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

if (!$Links -or $Links.Length -eq 0) {
    $Message = "Ошибка извлечения ссылок"
    $IconType = "Error"

    ShowMessage $Message $IconType

    Write-Host $Message
    Pause
    Break
}

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
Write-Host `n "Установка списков отзывов" `n

$fileList = Get-ChildItem $local_path | ? {$_.extension -match '\.crl'}

if (!$fileList -or $fileList.Length -eq 0) {
    $Message = "Отсутствуют списки отзывов"
    $IconType = "Error"

    ShowMessage $Message $IconType

    Write-Host $Message
    # Pause
    # Break
}

cd $local_path
# For each cert in the folder
foreach ($file in $fileList) {

#Invoke-Item -Path $file
certutil -addstore CA $file
Write-Host `n
}

# Открытие корневых сертификатов удостоверяющих центров (для ручной установки);

# $fileList = Get-ChildItem $local_path | ? {$_.extension -match '\.crt|\.cer'}
# cd $local_path
# # For each cert in the folder
# foreach ($file in $fileList) {
# #$file
# Invoke-Item -Path $file
# }

# Установка корневых сертификатов удостоверяющих центров
Write-Host `n "Установка корневых сертификатов удостоверяющих центров" `n

$fileList = Get-ChildItem $local_path | ? {$_.extension -match '\.crt|\.cer'}


if (!$fileList -or $fileList.Length -eq 0) {
    $Message = "Отсутствуют корневые сертификаты"
    $IconType = "Error"

    ShowMessage $Message $IconType

    Write-Host $Message
    # Pause
    # Break
}

cd $local_path
# For each cert in the folder
foreach ($file in $fileList) {
# $file
# Invoke-Item -Path $file
Import-CertificateX509 $file
Write-Host `n
}

# Вывод сообщения о завершении работы

$Message = "Скрипт завершил работу"
$IconType = "Info"

ShowMessage $Message $IconType

Write-Host $Message
Pause