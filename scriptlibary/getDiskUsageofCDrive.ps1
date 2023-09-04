$disk = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'"
$diskSizeGB = [math]::Round($disk.Size / 1GB, 2)
$diskFreeSpaceGB = [math]::Round($disk.FreeSpace / 1GB, 2)
$diskUsedSpaceGB = $diskSizeGB - $diskFreeSpaceGB

Write-Host "C: Drive Size: $diskSizeGB GB"
Write-Host "Used Space: $diskUsedSpaceGB GB"
Write-Host "Free Space: $diskFreeSpaceGB GB"