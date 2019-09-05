Import-Module BitsTransfer
$Source="\\Consultant\Consultant\CONS_ALL\BASE\SPB\"
$Destination="c:\TEMP\Base\"
if ( -Not (Test-Path $Destination))
{
$null = New-Item -Path $Destination -ItemType Directory
}
$folders = Get-ChildItem -Name -Path $source -Directory -Recurse
$job = Start-BitsTransfer -Source $Source\*.* -Destination $Destination -asynchronous -Priority low
while( ($job.JobState.ToString() -eq 'Transferring') -or ($job.JobState.ToString() -eq 'Connecting') )
{
Sleep 3
}
Complete-BitsTransfer -BitsJob $job
foreach ($i in $folders)
{
$exists = Test-Path $Destination\$i
if ($exists -eq $false) {New-Item $Destination\$i -ItemType Directory}
$job = Start-BitsTransfer -Source $Source\$i\*.* -Destination $Destination\$i -asynchronous -Priority low
while( ($job.JobState.ToString() -eq 'Transferring') -or ($job.JobState.ToString() -eq 'Connecting') )
{
Sleep 3
}
Complete-BitsTransfer -BitsJob $job
}