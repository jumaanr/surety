#Get the current time stamp
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
Write-Host $timestamp
#Generate the snapshot name
$snapshotName = "snap-inc-vm-fc-azu-fw01-"+$timestamp
echo $snapshotName


$diskName = "yourDiskNameHere"
$resourceGroupName = "yourResourceGroupNameHere"
#$snapshotName = "yourDesiredSnapshotNameHere"

# Get the disk that you need to backup by creating an incremental snapshot
$yourDisk = Get-AzDisk -DiskName $diskName -ResourceGroupName $resourceGroupName

# Create an incremental snapshot by setting the SourceUri property with the value of the Id property of the disk
$snapshotConfig=New-AzSnapshotConfig -SourceUri $yourDisk.Id -Location $yourDisk.Location -CreateOption Copy -Incremental 
New-AzSnapshot -ResourceGroupName $resourceGroupName -SnapshotName $snapshotName -Snapshot $snapshotConfig

# https://learn.microsoft.com/en-us/azure/virtual-machines/disks-incremental-snapshots?tabs=azure-powershell

Connect-AzAccount
Disconnect-AzAccount
Get-AzSystemAssignedIdentity -Scope /subscriptions/c187e445-4fb2-4438-8629-c822fabcc911
Connect-AzAccount -Identity
Get-AzDisk -ResourceGroupName rg-auststheast-1 



#Precision Code
# Get the managed disk
$managedDisk = Get-AzDisk -ResourceGroupName $resourceGroupName -DiskName vm-fc-azu-fw01_disk2_5034d9c227fa41a0963e236c88ab8d2e


## Create an incremental snapshot by setting the SourceUri property with the value of the Id property of the disk
$snapshotConfig=New-AzSnapshotConfig -SourceUri $managedDisk.Id -Location $managedDisk.Location -CreateOption Copy -Incremental
New-AzSnapshot -ResourceGroupName AzureBackupRG_australiasoutheast_1 -SnapshotName $snapshotName -Snapshot $snapshotConfig 