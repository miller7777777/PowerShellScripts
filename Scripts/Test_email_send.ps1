# Email Sender

$serverSmtp = "smtp.beget.ru" 
$port = 25
$From = "robot@4sides.spb.ru" 
$To = "miller777@mail.ru" 
$subject = "������"
$user = "robot@4sides.spb.ru"
$pass = "*IYevi7A"

$mes = New-Object System.Net.Mail.MailMessage

# //���� � ����� 
# $file = "D:\arhive.zip"


# //������� ��� ���������� ������
# $att = New-object Net.Mail.Attachment($file)
$mes = New-Object System.Net.Mail.MailMessage


# //��������� ������ ��� ��������
$mes.From = $from
$mes.To.Add($to) 
$mes.Subject = $subject 
$mes.IsBodyHTML = $true 
$mes.Body = "<h1>�������� ������</h1>"


# //��������� ����
# $mes.Attachments.Add($att) 


# //������� ��������� ������ ����������� � SMTP ������� 
$smtp = New-Object Net.Mail.SmtpClient($serverSmtp, $port)


# //������ ���������� SSL 
# $smtp.EnableSSL = $true
# ������� ��������� ������ ��� ����������� �� �������
$smtp.Credentials = New-Object System.Net.NetworkCredential($user, $pass);


# //���������� ������, ����������� ������
$smtp.Send($mes) 
# $att.Dispose()