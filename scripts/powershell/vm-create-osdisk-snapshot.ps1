Param (
    [Parameter(Mandatory, HelpMessage = "Please provide a valid virtual machine name")]
    [string] $vmName,
    [Parameter(Mandatory, HelpMessage = "Please provide a valid snapshot name")]
    [string] $snapshotName,
    [Parameter(Mandatory, HelpMessage = "Please provide a valid resource group name")]
    [string] $resourceGroupName
)

#Get the VM object
Write-Host "Retrieving the virtual machine object ..."
$vm = Get-AzVM -Name $vmName -ResourceGroupName $resourceGroupName

#Get the OS disk object
Write-Host "Retrieving the disk object ..."
$disk = Get-AzDisk -ResourceGroupName $resourceGroupName -DiskName $vm.StorageProfile.OsDisk.Name
# Create the snapshot in the same location as the disk
$location = $disk.Location

#Create the snapshot configuration (Add -AccountType Premium_LRS to use the snapshot to create a VM that needs high-performing)
$snapshotConfig = New-AzSnapshotConfig -SourceUri $disk.Id -OsType Windows -CreateOption Copy -Location $location

#Take the snapshot
Write-Host "Creating the snapshot ..."
$snapshot = New-AzSnapshot -Snapshot $snapshotConfig -SnapshotName $snapshotName -ResourceGroupName $resourceGroupName

Write-Host "The snaphot $($snapshot.Name) has been successfully created from disk $($disk.Name)" -ForegroundColor Green