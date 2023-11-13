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

#Enable Firewall Rules
# Allow HTTP (Port 80) Inbound
New-NetFirewallRule -DisplayName "Allow HTTP Inbound" -Direction Inbound -Protocol TCP -LocalPort 80 -Action Allow

# Allow HTTPS (Port 443) Inbound
New-NetFirewallRule -DisplayName "Allow HTTPS Inbound" -Direction Inbound -Protocol TCP -LocalPort 443 -Action Allow

# Allow ICMP Echo Request (Ping) Inbound
New-NetFirewallRule -DisplayName "Allow ICMP Echo Request Inbound" -Protocol ICMPv4 -IcmpType 8 -Action Allow

# Allow WinRM (Port 5985) Inbound
New-NetFirewallRule -DisplayName "Allow WinRM (HTTP) Inbound" -Direction Inbound -Protocol TCP -LocalPort 5985 -Action Allow

# Allow WinRM (Port 5986) Inbound (For HTTPS)
New-NetFirewallRule -DisplayName "Allow WinRM (HTTPS) Inbound" -Direction Inbound -Protocol TCP -LocalPort 5986 -Action Allow
