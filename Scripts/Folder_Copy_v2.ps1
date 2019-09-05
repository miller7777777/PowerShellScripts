########################################################
# Copy files with GUI.ps1
# Version 1.3
#
# Copies single or couple files with GUI progressbar
# 
# Original idea: Oisín Grehan
# First edition: Hal Rottenberg
# Second edition: Vadims Podans
#
# Vadims Podans (c) 2009
# http://www.sysadmins.lv/
########################################################

# сразу после названия идёт описание к функции. После загрузки функции в консоль
# её справка будет доступна в консоли. Достаточно будет набрать:
# Get-Help Copy-FilesPlus
# вобщем, как в настоящих командлетах
function Copy-FilesPlus {
<#
.Synopsis
    Copies files and folders displaying GUI progress bar.
.Description
    This is a script, that demonstrates how PowerShell can use
    useful .NET types and PowerShell V2 capabilities.
.Parameter Path
    Specifies the filename or FileInfo object representing file to be copied.
    Objects can be passed through a pipeline.
.Parameter Destination
    Specifies the path for resulting copy operation
.Parameter Recurse
    Gets the items in the specified locations and in all child items of the locations.
    Used only when source directory passed through argument list. 
.Parameter Force
    Creates directory structure in destination folder and copies files to
    their source respective folders (Tree copy).
.EXAMPLE
    PS > Copy-FilesPlus -Path C:\tmp -Destination e:\Users
    
    This will copy only files from C:\tmp to E:\Users
.EXAMPLE
    PS > Get-Item C:\tmp\windows7.iso | Copy-FilesPlus -Destination E:\Users
    
    This will copy specified file from C:\tmp folder to e:\Users
.EXAMPLE
    PS > Get-Childitem D:\Shared | Copy-FilesPlus -Destination E:\ 
    
    This will copy all files from Shared folders to E: drive root directory
.EXAMPLE
    PS > Get-Childitem D:\Shared -Recurse | Copy-FilesPlus -Destination E:\ -Force
    
    This will copy all files in Shared folder and subfolders. Shared folder will be a
    tree root point. All directory structure will be copied with files to destination folder.
.EXAMPLE
    PS > Copy-FilesPlus C:\Users\User E:\ -Recurse
    
    This will copy all files from User folder and subfolders to destination directory without
    copying source folders tree
.EXAMPLE
    PS > Copy-FilesPlus C:\Users\User E:\ -Recurse -Force
    
    This will copy all files in User folder and subfolders. User folder will be a
    tree root point. All directory structure will be copied with files to destination folder.
.ReturnValue
    Genrally, script don't return anything, except errors!
.Link
    about_functions
    about_functions_advanced
    about_functions_advanced_methods
    about_functions_advanced_parameters
#Requires -Version 2.0
#>

# ну и теперь фишки от advanced functions в V2. CmdletBinding делает
# подстановку передаваемых аргументов в функцию. Если аргумент не передан
# то PowerShell попросит его ввести, а не вывалится с ошибкой
[CmdletBinding()]
    param (
        # первый аргумент. Он является обязательным и он может принимать значения
        # из конвейера. Причём, внутри блока Process {} для обозначения текущего элемента
        # можно использовать, как переменную $path, так и $_.
        [Parameter(Mandatory = $true,ValueFromPipeline = $true)]
        $Path,
        [Parameter(Mandatory = $true)]
        [string]$Destination,
        [switch]$Recurse,
        [switch]$Force
    )
    begin {
        # пробуем создать папку назначения, куда будут копироваться файлы.
        [void](md $Destination -Force -ea 0)
        # вот тут я сделал переменную для счётчика. Счётчик мне потребуется для того,
        # чтобы при использовании ключа -Force и если файлы передаются по конвейеру
        # можно было брать точку начала дерева структуры, которая будет копироваться.
        $n = 0
        # временная функция, которая выполняет само копирование. Тут нужно учесть то,
        # что путь назначения должен указываться в полном формате с указанием имени
        # конечного файла. Относительные пути тут не поддерживаются. Поэтому дальше
        # в коде я буду сохранять имя оригинального файла. т.е. переименовывание файлов
        # на лету не поддерживается
        function _routinecopy_ ([string]$Destination) {
            process {
                Add-Type -AssemblyName microsoft.visualbasic
                [Microsoft.VisualBasic.FileIO.FileSystem]::CopyFile($_, $Destination, 
                [Microsoft.VisualBasic.FileIO.UIOption]::AllDialogs,
                [Microsoft.VisualBasic.FileIO.UICancelOption]::ThrowException)
            }
        }
    }
    process {
        try {
            # вот здесь я проверяю, откуда пришли файлы - через аргументы или через конвейер
            # если данные пришли из обоих путей, то приоритет за конвейером
            if ($_) {
                # проверяем, что объект существует и что это объект файловой системы
                $File = gi $Path.FullName -ea stop | ?{$_.PsProvider -match "FileSystem$"}
                if ($File) {
                    # если объект в порядке и выполняется только первая итерация конвейера
                    # то мы задаём точку начала дерева. Весь путь от этой точки до имени файла
                    # будет копироваться в папку назначения
                    if ($n -eq 0) {
                        # здесь отрезаем от файла структуру папок, которая будет являться границей дерева
                        $RootPoint = $Path.FullName -replace $([regex]::Escape($Path.Name))
                        # заодно на основе этой структуры делаем регулярное выражение. Этим регулярным
                        # выражением будем у всех последующих файлов отрезать начало и оставлять необходимую
                        # часть дерева
                        $RootRegEx = [regex]::Escape($RootPoint.Substring(0,$RootPoint.Length -1))
                        # важно, что эту операцию нужно проделать единожды, чтобы точка монтирования дерева
                        # больше не менялась в процессе. Поэтому увеличиваем счётчик и тогда в течении текущего
                        # процесса копирования код сюда не вернётся
                        $n++
                    }
                    # проверяем, что нужно ли копировать дерево или нет.
                    if ($Force) {
                        # если копируем дерево, то выбрасываем папки и работаем только с файлами
                        $File = $File | ?{!$_.PsIsContainer}
                        if ($File) {
                            # если есть файлы для копирования, то выбираем весь путь папок до текущего файла
                            # и заранее приготовленным регэкспом отрезаем начало. В переменную $rep мы запишем
                            # дерево папок от точки монтирования дерева до имени файла
                            $rep = $Path.Directory.ToString() -replace $RootRegEx
                            # а теперь к папке назначения пристыковываем дерево папок от точки монтирования до имени файла
                            $DestFolder = Join-Path $Destination $rep
                            # заранее создаём начальный хвостик папок в целевой папке и подавляем вывод на экран
                            [void](md $DestFolder -Force -ea 0)
                            # а теперь к новому конечному пути пристыковываем имя файла
                            $Dest = Join-Path $DestFolder $Path.Name
                            # и теперь подаём текущий файл в функцию копирования. Вот тут мы и увидим прогресс-бар.
                            $Path.FullName | _routinecopy_ $Dest
                        }
                    } else {
                        # если структуру папок копировать не надо, то все файлы, что пришли с конвейера будут копироваться
                        # в папку назначения без создания структуры папок.
                        if (!$_.PsIsContainer) {
                            $Dest = Join-Path $Destination $File.Name
                            $File | _routinecopy_ $Dest
                        }
                    }
                # если объект не существует или это не объект файловой системы (защита от дураков, да-да :)), то ругаемся
                } else {throw "Input object does not represent any applicable FileSystem object"}
            } else {
                # если данные об источнике копирования переданы через аргументы, то проверяем, что заданный путь допустим
                # и объект, который мы получим после Get-Item является объектом файловой системы
                $File = gi $Path -ea stop | ?{$_.PsProvider -match "FileSystem$"}
                if ($File) {
                    # если всё хорошо, то указанный файл или папка становятся точкой монтирования дерева
                    $RootPoint = Resolve-Path $Path
                    # если ключи -Force -Recurse не указаны, то копируется либо указанный файл или все файлы в указанной
                    # папке в папку назначения
                    if (!$Recurse) {
                        dir $RootPoint | ?{!$_.PsIsContainer} | %{$Dest = Join-Path $Destination $_.Name
                            $_.FullName | _routinecopy_ $Dest}
                    # хитрый режим, когда рекурсивно выбираются все файлы в указанной папке и всех подпапках и копируются
                    # в папку назначения без сохранения структуры (т.е. в папке назначения будет большая куча файлов).
                    } elseif ($Recurse -and !$Force) {
                        dir $RootPoint -Recurse | ?{!$_.PsIsContainer} | %{$Dest = Join-Path $Destination $_.Name
                            $_.FullName | _routinecopy_ $Dest}
                    # если указаны оба ключа, то мы повторяем структуру исходных папок относительно точки монтирования дерева
                    # в папке назначения
                    } elseif ($Recurse -and $Force) {
                        dir $RootPoint -Recurse | ?{!$_.PsIsContainer} | %{
                            # тут мы делаем то же самое, что и в случае, когда файлы пришли с конвейера
                            $RootRegEx = [regex]::Escape($RootPoint)
                            $rep = $_.Directory.ToString() -replace $RootRegEx
                            $DestFolder = Join-Path $Destination $rep
                            [void](md $DestFolder -Force -ea 0)
                            $Dest = Join-Path $DestFolder $_.Name
                            $_.FullName | _routinecopy_ $Dest
                        }
                    }
                } else {throw "Input object does not represent any applicable FileSystem object"}
            }
        } catch {$_}
    }
}