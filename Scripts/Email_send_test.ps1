# Email send test ver. 1
$smtpServer = "smtp.beget.com"
$smtpFrom = "robot@4sides.spb.ru"
$smtpTo = "miller777@mail.ru"
$messageSubject = "Subject"
$messageBody = "Message body"
# $smtp = New-Object Net.Mail.SmtpClient($smtpServer)
# $smtp.Send($smtpFrom,$smtpTo,$messagesubject,$messagebody)

$secpasswd = ConvertTo-SecureString "*IYevi7A" -AsPlainText -Force
$mycreds = New-Object System.Management.Automation.PSCredential ("robot@4sides.spb.ru", $secpasswd)

# Send-MailMessage -SmtpServer $smtpServer -From $smtpFrom -To $smtpTo -Subject $messageSubject -Body $messageBody -credential $mycreds

$smtp = New-Object Net.Mail.SmtpClient($smtpServer)
$smtp.Send($smtpFrom,$smtpTo,$messagesubject,$messagebody)