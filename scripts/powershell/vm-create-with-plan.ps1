Param (
    [Parameter(Mandatory, HelpMessage = "Please provide a valid virtual machine name")]
    [string] $vmName,
    [Parameter(Mandatory, HelpMessage = "Please provide a valid disk name")]
    [string] $osDiskName,
    [Parameter(Mandatory, HelpMessage = "Please provide a valid network interface name")]
    [string] $nicName,
    [Parameter(Mandatory, HelpMessage = "Please provide a valid resource group name")]
    [string] $resourceGroupName
)

# Get the OsDisk object
Write-Host "Retrieving the OS Disk ..."
$osDisk = Get-AzDisk -ResourceGroupName $resourceGroupName -DiskName $osDiskName
$location = $osDisk.Location

# Get the existing network interface object
Write-Host "Retrieving the network interface ..."
$nic = Get-AzNetworkInterface -Name $nicName -ResourceGroupName $resourceGroupName

# Creating the virtual machine configuration
$vmConfig = New-AzVMConfig -VMName $vmName -VMSize "Standard_D4s_v3" | Set-AzVMPlan -Publisher "wallix" -Product "wallixbastion" -Name "bastion"
$vm = Add-AzVMNetworkInterface -VM $vmConfig -Id $nic.Id
$vm = Set-AzVMOSDisk -VM $vm1 -ManagedDiskId $osDisk.Id -StorageAccountType Standard_LRS -DiskSizeInGB 128 -CreateOption Attach -Linux

# Creating the new virtual machine
Write-Host "Creating the new virtual machine ..."
New-AzVM -ResourceGroupName $resourceGroupName -Location $location -VM $vm

Write-Host "The virtual machine has been successfully created" -ForegroundColor Green