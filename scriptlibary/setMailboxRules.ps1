$credential = Get-Credential -Message "Enter your credentials"
$credential | Export-Clixml -Path "C:\lib\repos\surety\SecureCredentials.xml"
$credential = Import-Clixml -Path "C:\lib\repos\surety\SecureCredentials.xml"

# Import the stored credentials
$credential = Import-Clixml -Path "C:\Path\To\SecureCredentials.xml"

#Azure Account Connection
Install-Module -Name Az -AllowClobber -Force
# Connect to Azure using the stored credentials
Connect-AzAccount -Credential $credential

$cred = Connect-AzAccount
$cred | Export-Clixml -Path "C:\lib\repos\surety\AzSecureCredentials.xml"
$cred2 = Import-Clixml -Path "C:\lib\repos\surety\AzSecureCredentials.xml"
Connect-AzAccount -Credential $cred2
Get-AzSubscription

#Connect to Exchange account
    #Check how to connect with an Office 365 account which uses multi factor authentication
# Store the credentials
    #Store crdentials in a safe manner, rather than entering password
#Now get the time of the day
#Main function
    #try Date=Friday
        # enable mailbox autoreply message
        # write output to log file successfully executed
    #catch
        #Write output to log file executed with error (Can use a try catch block)
    #try Date=Monday
