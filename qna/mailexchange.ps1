#Connect M365 account
Connect-MsolService
Get-MsolCompanyInformation

Connect-ExchangeOnline


Get-Mailbox -Identity admin@astutefinancial.com.au | Format-List > admin.txt
Get-MailboxPermission -Identity admin@astutefinancial.com.au | Format-List
Get-InboxRule -Identity Leah.Weekes@astutefinancial.com.au 


Get-Mailbox -Identity michael.harding@qandaresearch.com.au
Get-Mailbox -Identity brodie.black@qandaresearch.com.au | Format-List > broadie.txt
Enable-Mailbox -Identity brodie.black@qandaresearch.com.au
Restore-Mailbox -Identity brodie.black@qandaresearch.com.au
Set-Mailbox -Identity michael.harding@qandaresearch.com.au -ArchiveName brodie.black@qandaresearch.com.au