$x = Get-PSDrive C | Select-Object Used,Free

# Get-PSDrive C | Select-Object Free
$x.Free/1GB