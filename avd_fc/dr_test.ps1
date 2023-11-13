#define and assign values to variables
$subscription = c187e445-4fb2-4438-8629-c822fabcc911
$test_resourceGroup = restore-test-rg-aussteast-02

#Connect with Azure Account
Connect-AzAccount -UseDeviceAuthentication
Get-AzSubscription
Set-AzContext -Subscription $subscription
#Disconnect from Azure Account
Disconnect-AzAccount

#Get the resource groups available
Get-AzResourceGroup | Format-Table
#Get the resources available
Get-AzResource -ResourceGroupName $test_resourceGroup
Get-AzResource -ResourceId /subscriptions/c187e445-4fb2-4438-8629-c822fabcc911/resourceGroups/restore-test-rg-aussteast-02/providers/Microsoft.Compute/virtualMachines/t-avdvmfcazu-0 | Format-List
Get-AzResource -ResourceGroupName restore-test-rg-aussteast-02 -ResourceType Microsoft.Compute/virtualMachines -Name t-avdvmfcazu-0 | Select Name, ProvisioningTime
