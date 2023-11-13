#Required Modules
Install-Module MSOnline
Import-Module MSOnline

#Connect M365 account
Connect-MsolService
Get-MsolCompanyInformation

Connect-ExchangeOnline
Get-Mailbox -Identity admin@astutefinancial.com.au | Format-List > admin.txt
Get-MailboxPermission -Identity admin@astutefinancial.com.au | Format-List
Get-InboxRule -Identity Leah.Weekes@astutefinancial.com.au 