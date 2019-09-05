<#
Ïğîòîòèï ñêğèïòà äëÿ ïàêåòíîé ğàññûëêè çàäà÷ íà ıëåêòğîííóş ïî÷òó
#>

$clientsFile = "C:\Temp\Êëèåíòû.txt"
$dateFile = "C:\Temp\Äàòà.txt"
# $EmailList = "miller7772+yawhfi8pzurry6zkfdeq@boards.trello.com"
$EmailList = "miller7772+yawhfi8pzurry6zkfdeq@boards.trello.com, miller777@mail.ru"
$work = "ÈÒÑ"
$color = "yellow"


function Send-GZReport {
    param (
    $Subject = 'Report',
    $MailContent,
    $Recipients,
    [switch]$SmtpFalseSend = $false
    )
    $From = "robot777.tech.4dk@gmail.com" 
    $smtpuser = "robot777.tech.4dk@gmail.com"
    $pass = "nRXpP6ZrMy5G" 
     
    $smtpServer = "smtp.gmail.com" 
     
     
    $msg = new-object Net.Mail.MailMessage 
    $smtp = new-object Net.Mail.SmtpClient($smtpServer) 
    $smtp.EnableSsl = $true
    $smtp.Port = 587
    $SMTP.Credentials = New-Object System.Net.NetworkCredential($smtpuser, $pass); 
    
    $msg.From = $From
    
    foreach ($To in (@($Recipients -split ','))) {
    'Adding recipient ' + $To |Write-Verbose
    $msg.To.Add($To)
    }
    
    $msg.IsBodyHTML = $true  
    $msg.Subject = $Subject
    $msg.Body = $MailContent
    try {
    'Subject: ' + $Subject | Write-Verbose 
    #'Body: ' + $MailContent | Write-Verbose 
    if ($SmtpFalseSend) {
    $SentOK = $true
    $MailContent | Set-Content (Join-Path 'G:\Shares\Bases\gz' ($Subject + '.html') ) -Force
    }
    else {
    $smtp.Send($msg)
    $SentOK = $true
    }
    
    }
    catch {
    $SentOK = $false
    }
    
    $Subject + " " + $SentOK
    }


$clients = @()
$clients = Get-Content $clientsFile -Encoding "UTF8"

$date = Get-Content $dateFile
$dateUnits = $date.Split("/")
switch ($dateUnits[1]) {
    "01" {$month = "ÿíâàğü " + $dateUnits[2] }
    "02" {$month = "ôåâğàëü " + $dateUnits[2] }
    "03" {$month = "ìàğò " + $dateUnits[2] }
    "04" {$month = "àïğåëü " + $dateUnits[2] }
    "05" {$month = "ìàé " + $dateUnits[2] }
    "06" {$month = "èşíü " + $dateUnits[2] }
    "07" {$month = "èşëü " + $dateUnits[2] }
    "08" {$month = "àâãóñò " + $dateUnits[2] }
    "09" {$month = "ñåíòÿáğü " + $dateUnits[2] }
    "10" {$month = "îêòÿáğü " + $dateUnits[2] }
    "11" {$month = "íîÿáğü " + $dateUnits[2] }
    "10" {$month = "äåêàáğü " + $dateUnits[2] }
    DEFAULT {$month = "???"}
}

Write-Host "Âñåãî êëèåíòîâ: " $clients.Length

foreach($client in $clients){
    $Subject = $client + " (" + $work + ") " + $month + " #" + $date + " #" + $color 
    $MailContent = ""
    # $EmailList = "miller777@mail.ru"
    Send-GZReport -Subject $Subject -MailContent $MailContent -Recipients $EmailList
# Start-Sleep 5

}


    # $Subject = "Report"
    # $MailContent = "×òî-òî ïğîâåğÿåì"
    # $EmailList = "miller777@mail.ru"
    # Send-GZReport("miller777@mail.ru", "miller777@mail.ru", "miller777@mail.ru", "miller777@mail.ru")
    # Send-GZReport -Subject $UAlias.Alias -MailContent $MailContent -Recipients $EmailList
    # Send-GZReport -Subject $Subject -MailContent $MailContent -Recipients $EmailList