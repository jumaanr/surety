#Useful cmdlets to get LAPS configuration

Import-Module AdmPwd
Get-ADComputer -Filter * -Properties MS-Mcs-AdmPwd | Where-Object MS-Mcs-AdmPwd -ne $null | FT Name, MS-Mcs-AdmPwd
Find-AdmPwdExtendedRights -ComputerDN "CN=ComputerName,OU=Computers,DC=Domain,DC=com"
# Find-AdmPwdExtendedrights -identity <OU name> | Format-Table
milton.qandaresearch.com.au/QandA/Computers

Get-AdmPwdPassword -ComputerName 'QANDA-REC-2003'
