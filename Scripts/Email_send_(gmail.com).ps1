# Скрипт для отправки почты через gmail.com
# Версия 1
# 2019-09-05


$serverSmtp = "smtp.gmail.com" 
$port = 587
$From = "robot777.tech.4dk@gmail.com" 
$To = "miller777@mail.ru" 
$subject = "Письмо с вложением"
$user = "robot777.tech.4dk"
$pass = "nRXpP6ZrMy5G"


#Путь к файлу 
# $file = "d:\Downloads\Software\Android\Listen Audio Player\Listen_Audiobook_Player_4.5.14_Patched_by_KoumKouat.apk"
$file = "D:\Downloads\Books\_Художественные\_Сборники\Причуды любви\Arsan_Prichudy-lyubvi.j_SkhQ.327984.fb2.zip"



#Создаем два экземпляра класса
$att = New-object Net.Mail.Attachment($file)
$mes = New-Object System.Net.Mail.MailMessage


#Формируем данные для отправки
$mes.From = $from
$mes.To.Add($to) 
$mes.Subject = $subject 
$mes.IsBodyHTML = $true
$mes.Body = "<h1>Тестовое письмо</h1>"


#Добавляем файл
$mes.Attachments.Add($att) 


#Создаем экземпляр класса подключения к SMTP серверу 
$smtp = New-Object Net.Mail.SmtpClient($serverSmtp, $port)


#Сервер использует SSL 
$smtp.EnableSSL = $true
# Создаем экземпляр класса для авторизации на сервере
$smtp.Credentials = New-Object System.Net.NetworkCredential($user, $pass);


#Отправляем письмо, освобождаем память
$smtp.Send($mes) 
$att.Dispose()