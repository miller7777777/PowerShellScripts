<#
�������� ������� ��� �������� �������� ����� �� ����������� �����
#>

$clientsFile = "C:\Temp\�������.txt"
$dateFile = "C:\Temp\����.txt"
# $EmailList = "miller7772+yawhfi8pzurry6zkfdeq@boards.trello.com"
$EmailList = "miller7772+yawhfi8pzurry6zkfdeq@boards.trello.com, miller777@mail.ru"
$work = "���"
$color = "yellow"


function Send-GZReport {
    param (
    $Subject = 'Report',
    $MailContent,
    $Recipients,
    [switch]$SmtpFalseSend = $false
    )
    $From�=�"robot777.tech.4dk@gmail.com"�
    $smtpuser = "robot777.tech.4dk@gmail.com"
    $pass�=�"nRXpP6ZrMy5G"�
    �
    $smtpServer�=�"smtp.gmail.com"�
    �
    �
    $msg�=�new-object�Net.Mail.MailMessage�
    $smtp�=�new-object�Net.Mail.SmtpClient($smtpServer)�
    $smtp.EnableSsl�=�$true
    $smtp.Port = 587
    $SMTP.Credentials�=�New-Object�System.Net.NetworkCredential($smtpuser,�$pass);�
    
    $msg.From�=�$From
    
    foreach ($To in (@($Recipients -split ','))) {
    'Adding recipient ' + $To |Write-Verbose
    $msg.To.Add($To)
    }
    
    $msg.IsBodyHTML�=�$true��
    $msg.Subject�=�$Subject
    $msg.Body�= $MailContent
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
    "01" {$month = "������ " + $dateUnits[2] }
    "02" {$month = "������� " + $dateUnits[2] }
    "03" {$month = "���� " + $dateUnits[2] }
    "04" {$month = "������ " + $dateUnits[2] }
    "05" {$month = "��� " + $dateUnits[2] }
    "06" {$month = "���� " + $dateUnits[2] }
    "07" {$month = "���� " + $dateUnits[2] }
    "08" {$month = "������ " + $dateUnits[2] }
    "09" {$month = "�������� " + $dateUnits[2] }
    "10" {$month = "������� " + $dateUnits[2] }
    "11" {$month = "������ " + $dateUnits[2] }
    "10" {$month = "������� " + $dateUnits[2] }
    DEFAULT {$month = "???"}
}

Write-Host "����� ��������: " $clients.Length

foreach($client in $clients){
    $Subject = $client + " (" + $work + ") " + $month + " #" + $date + " #" + $color 
    $MailContent = ""
    # $EmailList = "miller777@mail.ru"
    Send-GZReport -Subject $Subject -MailContent $MailContent -Recipients $EmailList
# Start-Sleep 5

}


    # $Subject = "Report"
    # $MailContent = "���-�� ���������"
    # $EmailList = "miller777@mail.ru"
    # Send-GZReport("miller777@mail.ru", "miller777@mail.ru", "miller777@mail.ru", "miller777@mail.ru")
    # Send-GZReport -Subject $UAlias.Alias -MailContent $MailContent -Recipients $EmailList
    # Send-GZReport -Subject $Subject -MailContent $MailContent -Recipients $EmailList