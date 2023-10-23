# Define variables
$resourceGroupName = "rg-auststheast-1"
$snapshotName = "Test_Snapshot"


# Get the managed disk
$managedDisk = Get-AzDisk -ResourceGroupName $resourceGroupName -DiskName vm-fc-azu-fw01_disk2_5034d9c227fa41a0963e236c88ab8d2e


## Create an incremental snapshot by setting the SourceUri property with the value of the Id property of the disk
$snapshotConfig=New-AzSnapshotConfig -SourceUri $managedDisk.Id -Location $managedDisk.Location -CreateOption Copy -Incremental
New-AzSnapshot -ResourceGroupName AzureBackupRG_australiasoutheast_1 -SnapshotName $snapshotName -Snapshot $snapshotConfig