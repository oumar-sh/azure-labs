Param(
    [string] $ResourceGroupName
)

$currentDate = Get-Date -Format "dd-MM-yyyy"
$outputFolder = '.\output'

# Check if the folder resources-list already exists
if (Test-Path -Path "$outputFolder\resources-list") {
    Write-Host "Resources list folder exists !" -ForegroundColor Green
} else {
    Write-Host "Resources list folder does not exist ! Creating the folder ..." -ForegroundColor Green
    New-Item -Path $outputFolder -Name "resources-list" -ItemType "directory"
}

If ($ResourceGroupName) {
    # Retrieve the resources in the resource group
    $outputFile = "$outputFolder\resources-list\ResourcesList-$ResourceGroupName-$currentDate.csv"
    Get-AzResource -ResourceGroupName $ResourceGroupName | Select-Object Name, Location, ResourceGroupName, Type, Id, SubscriptionId  | Export-Csv -Path $outputFile -NoTypeInformation
} Else {
    # Retrieve all the resources from the current subscription
    $outputFile = "$outputFolder\resources-list\ResourcesList-$currentDate.csv"
    Get-AzResource | Export-Csv -Path $outputFile -NoTypeInformation
}

Write-Host "Resources have been retrieved successfully!" -ForegroundColor Green
