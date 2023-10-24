# Define variables
$resourceGroupName = "rg-auststheast-1"
$diskName_osDisk = "vm-fc-azu-fw01_OsDisk_1_28ed602e556041099b349f1464ec1d84"
$diskName_dataDisk = "vm-fc-azu-fw01_disk2_5034d9c227fa41a0963e236c88ab8d2e"

#Tags
$tags = @{

    VM = "vm-fc-azu-fw01"

}


#Get the current time stamp
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
#Generating snapshot name
$snapshotName_osDisk = "snap-inc-vm-fc-azu-fw01-osdisk-"+$timestamp
$snapshotName_dataDisk = "snap-inc-vm-fc-azu-fw01-datadisk-"+$timestamp

Write-Host $snapshotName_osDisk
Write-Host $snapshotName_dataDisk

# Get the managed disk
$managedDisk_osDisk = Get-AzDisk -ResourceGroupName $resourceGroupName -DiskName $diskName_osDisk
$managedDisk_dataDisk = Get-AzDisk -ResourceGroupName $resourceGroupName -DiskName $diskName_dataDisk

## Create an incremental snapshot by setting the SourceUri property with the value of the Id property of the disk
$snapshotConfig_osDisk=New-AzSnapshotConfig -SourceUri $managedDisk_osDisk.Id -Location $managedDisk_osDisk.Location -CreateOption Copy -Incremental -Tag $tags
New-AzSnapshot -ResourceGroupName AzureBackupRG_australiasoutheast_1 -SnapshotName $snapshotName_osDisk -Snapshot $snapshotConfig_osDisk

## Create an incremental snapshot by setting the SourceUri property with the value of the Id property of the disk
$snapshotConfig_dataDisk=New-AzSnapshotConfig -SourceUri $managedDisk_dataDisk.Id -Location $managedDisk_dataDisk.Location -CreateOption Copy -Incremental -Tag $tags
New-AzSnapshot -ResourceGroupName AzureBackupRG_australiasoutheast_1 -SnapshotName $snapshotName_dataDisk -Snapshot $snapshotConfig_dataDisk

#---------Retrive the list of AzSnapshots--------#
# Define the target tag and value
$tagName = "VM"
$tagValue = "vm-fc-azu-fw01"

# Get snapshots with the specified tag and value
$snapshots = Get-AzSnapshot | Where-Object { $_.Tags[$tagName] -eq $tagValue }

# Display information about each matching snapshot
foreach ($snapshot in $snapshots) {
    Write-Output "Snapshot Name: $($snapshot.Name)"
    Write-Output "Resource Group: $($snapshot.ResourceGroupName)"
    Write-Output "ID: $($snapshot.Id)"
    Write-Output "Creation Time: $($snapshot.TimeCreated)"
    Write-Output "--------------------------------"
}

