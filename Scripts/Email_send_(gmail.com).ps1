# ������ ��� �������� ����� ����� gmail.com
# ������ 1
# 2019-09-05


$serverSmtp = "smtp.gmail.com" 
$port = 587
$From = "robot777.tech.4dk@gmail.com" 
$To = "miller777@mail.ru" 
$subject = "������ � ���������"
$user = "robot777.tech.4dk"
$pass = "nRXpP6ZrMy5G"


#���� � ����� 
# $file = "d:\Downloads\Software\Android\Listen Audio Player\Listen_Audiobook_Player_4.5.14_Patched_by_KoumKouat.apk"
$file = "D:\Downloads\Books\_��������������\_��������\������� �����\Arsan_Prichudy-lyubvi.j_SkhQ.327984.fb2.zip"



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
# ������� ��������� ������ ��� ����������� �� �������
$smtp.Credentials = New-Object System.Net.NetworkCredential($user, $pass);


#���������� ������, ����������� ������
$smtp.Send($mes) 
$att.Dispose()