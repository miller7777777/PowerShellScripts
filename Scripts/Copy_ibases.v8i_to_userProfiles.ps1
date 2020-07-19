<#
������ ������������ ��� ����������� ����������� ����� �� ������� ��� 1� ���� ������������� ������������� �������, � ������� ���� 1�.

��������� � ������� ��������������

Version: 1.00
Date: 2020-07-19
Author: Miller777
#>

$subfolders = @(Get-ChildItem -Path "C:\Users")
$file = "e:\ibases.v8i"

foreach($sf in $subfolders){
    # Write-Host $sf

    $pathIBases = "c:\Users\" + $sf + "\AppData\Roaming\1C\1CEStart\"

    $folderIsExist = Test-Path -Path $pathIBases

    # Write-Host $pathIBases, $folderIsExist

    if ($folderIsExist) {

        try {
            $dest = $pathIBases + "ibases.v8i"
             # �������� ���� � �������
             Copy-Item -Path $file -Destination $dest -Force -Verbose
        }
        catch {
            Write-Host "�� ������� ����������� ���� ibases.v8i � $pathIBases" -ForegroundColor Red
        }
       

    }
}