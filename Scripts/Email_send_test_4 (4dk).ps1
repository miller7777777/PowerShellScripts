$serverSmtp = "smtp1.spb.4dk.ru" 
$port = 587
$From = "robot777@spb.4dk.ru" 
$To = "miller777@mail.ru" 
$subject = "������ � ���������"
$user = "robot777"
$pass = "R0boT_3*7"


#���� � ����� 
$file = "d:\Downloads\Software\Android\Listen Audio Player\Listen_Audiobook_Player_4.5.14_Patched_by_KoumKouat.apk"


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
# $smtp.UseDefaultCredentials
# ������� ��������� ������ ��� ����������� �� ������� �������
$smtp.Credentials = New-Object System.Net.NetworkCredential($user, $pass);


#���������� ������, ����������� ������
$smtp.Send($mes) 
$att.Dispose()