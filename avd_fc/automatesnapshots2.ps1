<#
    Version: 2.0
    Author: Jumaan Rimzy behalf of SuretyIT
    Creation Date: 10/24/23
    Purpose/Change: Creating Azure Managed Disk Snapshot daily

#>

# Define variables
$resourceGroupName = "rg-auststheast-1"
$diskName_osDisk = "vm-fc-azu-fw01_OsDisk_1_28ed602e556041099b349f1464ec1d84"
$diskName_dataDisk = "vm-fc-azu-fw01_disk2_5034d9c227fa41a0963e236c88ab8d2e"
$backup_ResourGroup = "AzureBackupRG_australiasoutheast_1"

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

try {
    
    ## Create an incremental snapshot by setting the SourceUri property with the value of the Id property of the disk
    $snapshotConfig_osDisk=New-AzSnapshotConfig -SourceUri $managedDisk_osDisk.Id -Location $managedDisk_osDisk.Location -CreateOption Copy -Incremental -Tag $tags
    $_newSnapshot1 = New-AzSnapshot -ResourceGroupName $backup_ResourGroup -SnapshotName $snapshotName_osDisk -Snapshot $snapshotConfig_osDisk
    Write-Output "Snapshot Created : $($_newSnapshot1.Name)"

    ## Create an incremental snapshot by setting the SourceUri property with the value of the Id property of the disk
    $snapshotConfig_dataDisk=New-AzSnapshotConfig -SourceUri $managedDisk_dataDisk.Id -Location $managedDisk_dataDisk.Location -CreateOption Copy -Incremental -Tag $tags
    $_newSnapshot2 =New-AzSnapshot -ResourceGroupName $backup_ResourGroup -SnapshotName $snapshotName_dataDisk -Snapshot $snapshotConfig_dataDisk
    Write-Output "Snapshot Created : $($_newSnapshot2.Name)"

    $_timestamp = Get-Date -Format "yyyy/MM/dd-HH:mm:ss"
    Write-Output "Snapshot creation operation successfully completed at : $($_timestamp)"
}
catch {
    Write-Error "Snapshot Creation Operation Failed"
}
