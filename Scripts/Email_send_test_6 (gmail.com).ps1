# ������ ��� �������� ����� ����� gmail.com
# ������ 2
# 2019-09-05

#�������� ������ ���������:
$From = "robot777.tech.4dk@gmail.com"
$To = "miller777@mail.ru"
$SMTPServer = "smtp.gmail.com"
$SMTPPort = "587"
$Username = "robot777.tech.4dk"
$Password = "nRXpP6ZrMy5G"
$subject = "hello"
$body = "bodytext"

#���� � ����� 
$file = "D:\Downloads\Books\_��������������\_��������\������� �����\Arsan_Prichudy-lyubvi.j_SkhQ.327984.fb2.zip"

#������� ��� ���������� ������
$att = New-object Net.Mail.Attachment($file)

#��������� ��������� � ������� html:
$message = New-Object System.Net.Mail.MailMessage $From, $To
$message.Subject = $subject
$message.IsBodyHTML = $true
$message.Body = $body

#��������� ����
$message.Attachments.Add($att) 

#����������:
$smtp = New-Object System.Net.Mail.SmtpClient($SMTPServer, $SMTPPort)
$smtp.EnableSSL = $true
$smtp.Credentials = New-Object System.Net.NetworkCredential($Username, $Password)
$smtp.Send($message)
$att.Dispose()