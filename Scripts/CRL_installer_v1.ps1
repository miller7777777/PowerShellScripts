$fileDirectory = "c:\TEMP\Cert\Out\"
$fileList = Get-ChildItem $fileDirectory | ? {$_.extension -match '\.crl'}
cd $fileDirectory
# For each cert in the folder
foreach ($file in $fileList) {
#$file
#Invoke-Item -Path $file
certutil -addstore CA $file
}