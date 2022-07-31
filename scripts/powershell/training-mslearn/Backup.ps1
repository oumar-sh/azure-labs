Param(
    [string]$Path = './app',
    [string]$Destination = './.',
    [switch]$PathIsWebApp
)

If ($PathIsWebApp -eq $True) {
    Try
    {
        $ContainsApplicationFiles = "$((Get-ChildItem $Path).Extension | Sort-Object -Unique)" -match '\.js|\.html|\.css'

        If (-Not $ContainsApplicationFiles) {
            Throw "Not a web app"
        } Else {
            Write-Host "Source files look good, continuing"
        }
    } Catch {
        Throw "No backup created due to : $($_.Exception.Message)"
    }
}

If (-Not (Test-Path $Path))
{
    Throw "The source directory $Path does not exist, please specifiy an existing directory"
}

$date = Get-Date -format "yyyy-MM-dd"
$DestinationFile = "$($DestinationPath + 'backup-' + $date + '.zip')"

If (-Not (Test-Path $DestinationFile))
{
    Compress-Archive -Path $Path -CompressionLevel 'Fastest' -Destination "$($DestinationPath + 'backup-' + $date)"
    Write-Host "Created backup at $DestinationFile"
} Else {
    Write-Error "Today's backup already exists"
}
