$object = New-Object -comObject Shell.Application 
$folder = $object.BrowseForFolder(0, 'Выберите папку', 0,0)
if ($folder -ne $null) {"выбранная папка $($folder.Self.Path)"}