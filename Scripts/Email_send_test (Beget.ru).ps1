# ������ ��� �������� �����, ������������ ���������� Beget.ru
# 2019-09-05
# �� ���� �� ��������

$smtp = New-Object System.Net.Mail.SmtpClient
$to = New-Object System.Net.Mail.MailAddress("miller777@mail.ru")
$from = New-Object System.Net.Mail.MailAddress("robot@4sides.spb.ru")
$attachment="C:\Temp\�������.txt"
$msg = New-Object System.Net.Mail.MailMessage($from, $to)
$msg.subject = "test email FROM POWERSHEEL"
$msg.body = "test PS body"
$msg.Attachments.Add($attachment)
$smtp.host = "smtp.beget.com"
$SMTP.Port = 25   ###not requried
$smtp.send($msg) 