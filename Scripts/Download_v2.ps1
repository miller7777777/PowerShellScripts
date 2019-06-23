Import-Module BitsTransfer
$download_url = "http://ca.1c.ru/cdp/1cca1_2017k.cer"
$download_url2 = "http://1cbo.1c.ru/cdp/1cca1_2017k.crl"
$download_url3 = "http://download.geo.drweb.com/pub/drweb/cureit/cureit.exe"
$local_path = "c:\TEMP\Cert"
Start-BitsTransfer -Source $download_url -Destination $local_path
Start-BitsTransfer -Source $download_url2 -Destination $local_path
Start-BitsTransfer -Source $download_url3 -Destination $local_path