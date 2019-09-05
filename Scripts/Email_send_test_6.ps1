$serverSmtp = "mail.cock.li" 
$port = 587
$From = "walter9952@cock.li" 
$To = "miller777@mail.ru" 
$subject = "Письмо без всего"
$user = "walter9952@cock.li"
$pass = "A123456a"


#Путь к файлу 
$file = "d:\Downloads\Books\_Художественные\Г\Гертов Игорь\Легион Хаоса\xa500.fb2.zip"


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