Param (
    [Parameter(Mandatory, HelpMessage = "Please provide a valid application gateway name")]
    [string] $AppGwName,
    [Parameter(Mandatory, HelpMessage = "Please provide a valid resource group name")]
    [string] $ResourceGroupName
)

$AppGw = Get-AzApplicationGateway -Name $AppGwName -ResourceGroupName $ResourceGroupName

$AppGw = Stop-AzApplicationGateway -ApplicationGateway $AppGw

Write-Host "The application gateway $($AppGw.Name) is successfully stopped" -ForegroundColor Green