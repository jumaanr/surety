#Get list of Serivces and Logon users

Get-WmiObject win32_service | sort startname,startmode,state,displayname | select StartMode,State,StartName,DisplayName | ft -auto -wrap



