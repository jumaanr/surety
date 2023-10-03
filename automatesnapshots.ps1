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
