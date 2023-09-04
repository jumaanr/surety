$processId = 2124
$process = Get-WmiObject -Class Win32_Process | Where-Object { $_.ProcessId -eq $processId }

if ($process) {
    $owner = $process.GetOwner()
    Write-Host "Process ID: $($process.ProcessId)"
    Write-Host "Process Name: $($process.Name)"
    Write-Host "Owner: $($owner.Domain)\$($owner.User)"
} else {
    Write-Host "Process with ID $processId not found."
}