#Get System Performance
# Get memory usage
$memory = Get-WmiObject Win32_OperatingSystem | Select-Object TotalVisibleMemorySize, FreePhysicalMemory
$memoryTotal = $memory.TotalVisibleMemorySize
$memoryFree = $memory.FreePhysicalMemory
$memoryUsed = $memoryTotal - $memoryFree

# Get CPU usage
$cpu = Get-WmiObject Win32_PerfFormattedData_PerfOS_Processor | Where-Object { $_.Name -eq "_Total" }
$cpuUsage = $cpu.PercentProcessorTime

# Get disk usage
$disk = Get-WmiObject Win32_LogicalDisk | Where-Object { $_.DriveType -eq 3 } | Select-Object DeviceID, Size, FreeSpace
$diskInfo = @()
foreach ($drive in $disk) {
    $driveID = $drive.DeviceID
    $driveSize = $drive.Size
    $driveFreeSpace = $drive.FreeSpace
    $driveUsedSpace = $driveSize - $driveFreeSpace
    $diskInfo += [PSCustomObject]@{
        Drive = $driveID
        TotalSize = $driveSize
        UsedSpace = $driveUsedSpace
        FreeSpace = $driveFreeSpace
    }
}

# Display the information
Write-Host "System Memory Usage:"
Write-Host "Total Memory: $($memoryTotal / 1MB) MB"
Write-Host "Used Memory: $($memoryUsed / 1MB) MB"
Write-Host "Free Memory: $($memoryFree / 1MB) MB"
Write-Host ""

Write-Host "CPU Usage:"
Write-Host "Total CPU Usage: $cpuUsage%"
Write-Host ""

Write-Host "Disk Usage:"
$diskInfo | ForEach-Object {
    Write-Host "Drive $($_.Drive)"
    Write-Host "Total Size: $($_.TotalSize / 1GB) GB"
    Write-Host "Used Space: $($_.UsedSpace / 1GB) GB"
    Write-Host "Free Space: $($_.FreeSpace / 1GB) GB"
    Write-Host ""
}
