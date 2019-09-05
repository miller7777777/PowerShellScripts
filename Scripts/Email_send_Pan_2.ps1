function Send-GZReport {
    param (
    $Subject = 'Report',
    $MailContent,
    $Recipients,
    [switch]$SmtpFalseSend = $false
    )
    $From = "walter9952@cock.li" 
    $smtpuser = "walter9952@cock.li"
    $pass = "A123456a" 
     
    $smtpServer = "mail.cock.li" 
     
     
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
    
    $SentOK
    }


    $Subject = "Report"
    $MailContent = "˜??-?? ??????˜??"
    $EmailList = "miller777@mail.ru"
    # Send-GZReport("miller777@mail.ru", "miller777@mail.ru", "miller777@mail.ru", "miller777@mail.ru")
    # Send-GZReport -Subject $UAlias.Alias -MailContent $MailContent -Recipients $EmailList
    Send-GZReport -Subject $Subject -MailContent $MailContent -Recipients $EmailList