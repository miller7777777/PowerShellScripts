# Скрипт для отправки почты через gmail.com
# Версия 2
# 2019-09-05

#Входящие данные сообщения:
$From = "robot777.tech.4dk@gmail.com"
$To = "miller777@mail.ru"
$SMTPServer = "smtp.gmail.com"
$SMTPPort = "587"
$Username = "robot777.tech.4dk"
$Password = "nRXpP6ZrMy5G"
$subject = "hello"
$body = "bodytext"

#Путь к файлу 
$file = "D:\Downloads\Books\_Художественные\_Сборники\Причуды любви\Arsan_Prichudy-lyubvi.j_SkhQ.327984.fb2.zip"

#Создаем два экземпляра класса
$att = New-object Net.Mail.Attachment($file)

#формируем сообщение в формате html:
$message = New-Object System.Net.Mail.MailMessage $From, $To
$message.Subject = $subject
$message.IsBodyHTML = $true
$message.Body = $body

#Добавляем файл
$message.Attachments.Add($att) 

#Отправляем:
$smtp = New-Object System.Net.Mail.SmtpClient($SMTPServer, $SMTPPort)
$smtp.EnableSSL = $true
$smtp.Credentials = New-Object System.Net.NetworkCredential($Username, $Password)
$smtp.Send($message)
$att.Dispose()