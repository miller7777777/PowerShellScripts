$download_url = "http://ca.1c.ru/cdp/1cca1_2017k.cer"
$local_path = "c:\TEMP\Cert"
$WebClient = New-Object System.Net.WebClient
$WebClient.DownloadFile($download_url, $local_path)