# Email Sender

$serverSmtp = "smtp.beget.ru" 
$port = 25
$From = "robot@4sides.spb.ru" 
$To = "miller777@mail.ru" 
$subject = "Письмо"
$user = "robot@4sides.spb.ru"
$pass = "*IYevi7A"

$mes = New-Object System.Net.Mail.MailMessage

# //Путь к файлу 
# $file = "D:\arhive.zip"


# //Создаем два экземпляра класса
# $att = New-object Net.Mail.Attachment($file)
$mes = New-Object System.Net.Mail.MailMessage


# //Формируем данные для отправки
$mes.From = $from
$mes.To.Add($to) 
$mes.Subject = $subject 
$mes.IsBodyHTML = $true 
$mes.Body = "<h1>Тестовое письмо</h1>"


# //Добавляем файл
# $mes.Attachments.Add($att) 


# //Создаем экземпляр класса подключения к SMTP серверу 
$smtp = New-Object Net.Mail.SmtpClient($serverSmtp, $port)


# //Сервер использует SSL 
# $smtp.EnableSSL = $true
# Создаем экземпляр класса для авторизации на сервере
$smtp.Credentials = New-Object System.Net.NetworkCredential($user, $pass);


# //Отправляем письмо, освобождаем память
$smtp.Send($mes) 
# $att.Dispose()