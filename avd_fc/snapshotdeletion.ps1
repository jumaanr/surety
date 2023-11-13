<#
    Version: 2.0
    Author: Jumaan Rimzy behalf of SuretyIT
    Creation Date: 10/24/23
    Purpose/Change: Delete Azure Managed Disk Snapshot older than 5 days

#>

# Connect to the Azure account using managed identity
Connect-AzAccount -Identity

#Set the subscription context
Set-AzContext -SubscriptionId c187e445-4fb2-4438-8629-c822fabcc911

# Define Variables
$backup_ResourGroup = "AzureBackupRG_australiasoutheast_1"

# Define the threshold date (5 days ago)
$thresholdDate = (Get-Date).AddDays(-5)
Write-Output "Checking snapshots created on or before :" $thresholdDate

#---------Retrive the list of AzSnapshots--------#
# Define the target tag and value
$tagName = "VM"
$tagValue = "vm-fc-azu-fw01"
#---------Filter Snapshots Conditions---------#
# Get snapshots with the specified tag and value
$snapshots = Get-AzSnapshot -ResourceGroupName $backup_ResourGroup | Where-Object { $_.Tags[$tagName] -eq $tagValue }
# Get snapshots older than 5 days
#$snapshots = $snapshots | Where-Object { $_.TimeCreated -lt $thresholdDate }
# Get snapshots which are incremental
$snapshots = $snapshots | Where-Object {$_.Incremental}
#-----------------------------------------------

#Check if any snapshots found, if not exit the script
if ($snapshots.Count -eq 0) {
    
    Write-Output "No snapshots found to delete"
    return
}
else {
    
    # Display information about each matching snapshot
    foreach ($snapshot in $snapshots) {
        Write-Output "Snapshot Name: $($snapshot.Name)"
        Write-Output "Resource Group: $($snapshot.ResourceGroupName)"
        Write-Output "ID: $($snapshot.Id)"
        Write-Output "Creation Time: $($snapshot.TimeCreated)"
        Write-Output "--------------------------------"
    }

#----- Delete the filtered out snapshots--------

    foreach ($snapshot in $snapshots) {
        <# $currentItemName is the current item #>
        $_snapshotName = $snapshot.Name
        Remove-AzSnapshot -ResourceGroupName $backup_ResourGroup -SnapshotName $_snapshotName -Force
        Write-Output "Deleted snapshot :" $_snapshotName
    }

$_timestamp = Get-Date -Format "yyyy/MM/dd-HH:mm:ss"
Write-Output "Snapshot deletion operation successfully completed at : $($_timestamp)"

}

