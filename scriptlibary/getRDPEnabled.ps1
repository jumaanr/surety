#Enable RDP Service

$RDPEnabled = (Get-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections").fDenyTSConnections
if ($RDPEnabled -eq 0) {
    Write-Host "RDP is enabled."
} else {
    Write-Host "RDP is disabled."
}
