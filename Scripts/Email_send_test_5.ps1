$serverSmtp = "smtp.mail.ru" 
$port = 465
$From = "9213393817@mail.ru" 
$To = "miller777@mail.ru" 
$subject = "������ � ������"
$user = "9213393817@mail.ru"
$pass = "Meganezia4651292"


#���� � ����� 
$file = "d:\Downloads\Books\_��������������\�\������ �����\������ �����\xa500.fb2.zip"


#������� ��� ���������� ������
$att = New-object Net.Mail.Attachment($file)
$mes = New-Object System.Net.Mail.MailMessage


#��������� ������ ��� ��������
$mes.From = $from
$mes.To.Add($to) 
$mes.Subject = $subject 
$mes.IsBodyHTML = $true 
$mes.Body = "<h1>�������� ������</h1>"


#��������� ����
$mes.Attachments.Add($att) 


#������� ��������� ������ ����������� � SMTP ������� 
$smtp = New-Object Net.Mail.SmtpClient($serverSmtp, $port)


#������ ���������� SSL 
$smtp.EnableSSL = $true 
# ������� ��������� ������ ��� ����������� �� ������� �������
$smtp.Credentials = New-Object System.Net.NetworkCredential($user, $pass);


#���������� ������, ����������� ������
$smtp.Send($mes) 
$att.Dispose()