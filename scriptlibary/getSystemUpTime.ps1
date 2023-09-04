$lastBootTime = (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
$currentTime = Get-Date
$uptime = $currentTime - $lastBootTime

Write-Host "System Uptime:"
Write-Host "Last Boot Time: $lastBootTime"
Write-Host "Uptime: $($uptime.Days) days, $($uptime.Hours) hours, $($uptime.Minutes) minutes, $($uptime.Seconds) seconds"
