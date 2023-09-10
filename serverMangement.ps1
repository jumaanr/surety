#Already enabled ping, enabled remote management via SConfig tool

#Enable PS Remoting
Enable-PSRemoting -Force
Set-ExecutionPolicy RemoteSigned
Enter-PSSession -ComputerName 192.168.1.64

#Allow specific ports for remote management
New-NetFirewallRule -Name "WINRM-HTTP-In-TCP" -DisplayName "Windows Remote Management (HTTP-In)" -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 5985
#For HTTPS use port 5986
New-NetFirewallRule -Name "WINRM-HTTPS-In-TCP" -DisplayName "Windows Remote Management (HTTPS-In)" -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 5986

#Start WinRm Service
Start-Service WinRM
Set-Service -Name WinRM -StartupType Automatic
Restart-Service WinRM

#Configure TrustedHosts (hostname with the actual name or IP addres)
Set-Item wsman:\localhost\Client\TrustedHosts -Value "hostname" -Concatenate


#Enabling remote administration on the Server Core system
netsh advfirewall firewall set rule group="Remote Administration" new enable=yes
netsh advfirewall set currentprofile settings remotemanagement enable