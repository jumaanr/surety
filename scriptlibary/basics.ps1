#How to initial a PSSession as another user
$credential = Get-Credential -Credential "Domain\userName"
Start-Process powershell -Credential $credential

#Winget Package usage to install packages

winget install --id Microsoft.Powershell --source winget
winget install --id Git.Git -e --source winget
winget --help
$PSVersionTable
Set-ExecutionPolicy RemoteSigned

#Enter-PSSession -ComputerName <RemoteComputerName> -Credential <AdministratorCredentials>

#Get currently logged in users
Get-WmiObject Win32_ComputerSystem | Select-Object -ExpandProperty UserName

#Remote script to get the users
$ComputerName = "RemoteComputerName"
$Credential = Get-Credential  # Enter the username and password for remote authentication

$LoggedUsers = Invoke-Command -ComputerName $ComputerName -Credential $Credential -ScriptBlock {
    Get-WmiObject Win32_ComputerSystem | Select-Object -ExpandProperty UserName
}

$LoggedUsers

#How to get if a computer is domain joined
(Get-WmiObject -Class Win32_ComputerSystem).PartOfDomain
(Get-WmiObject -Class Win32_ComputerSystem).WorkGroup
$domainName = $env:USERDOMAIN
$domainName

#Check if RDP is enabled
(Get-WmiObject -Class "Win32_TerminalServiceSetting" -Namespace root\cimv2\terminalservices).AllowTSConnections

#Change hostname via PowerShell
Get-ComputerInfo -Property 'QA-WEB1'
Rename-Computer -NewName "NewHostname" -Restart

# Activating Windows
dism /online /get-currentedition
dism /online /get-targeteditions
dism /online /set-edition:serverstandard /productkey:<KEY-KEY-KEY-KEY-KEY> /accepteula
dism /online /set-edition:serverstandard /productkey:DWJNB-WJ2DK-KX3YF-C6DJH-RGGK2 /accepteula
#check the activation status