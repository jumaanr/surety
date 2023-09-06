#TODO [[Managing Local User Accounts]] 
#Get currently logged in user in the format of "DOMAIN\Username"
whoami
#Create a local user account
net user UserName1 Password1 /add
#Make the local user an administrator
net localgroup administrators UserName1 /add
#get Basic info about a local user
net user JohnDoe
#change Local user password
net user Username NewPassword
#Add or remove user to a local group
net user Username /add Group
net user Username /delete Group
#get local group membership of a user
net localgroup administrators
Get-LocalGroupMember -Group "Administrators"
#check the membership of a specific local group for a user using CMD and PS
#? net localgroup Administrators | findstr /c:"<Username>"
#PowerShell
$GroupName = "<GroupName>"
$Username = "<Username>"

$IsMember = Get-LocalGroupMember -Group $GroupName | Where-Object { $_.Name -eq $Username }

if ($IsMember) {
    Write-Host "$Username is a member of $GroupName."
} else {
    Write-Host "$Username is not a member of $GroupName."
}
#
# Disable a local user account PS and cmd
net user Username /active:no
Disable-LocalUser -Name "UserName"
# Delete a local user account PS and cmd
net user Username /delete
Remove-LocalUser -Name "Username>"

#TODO [[Managing AD Users]]

#Retrivew infromation of AD account
Get-ADUser -Identity "DOMAIN\Username" -Properties *


#TODO [[Managing AzureAD Joined Accounts]]
