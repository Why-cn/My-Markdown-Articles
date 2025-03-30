<#
   You can use the following command in "Windows Terminal - PowerShell"
   to temporarily bypass the execution policy and run this script:
   
   PowerShell -ExecutionPolicy Bypass -File "SteamCommon.ps1"
#>

# Check if Steam is installed
$steamRegPath = "HKCU:\Software\Valve\Steam"
$steamPath = $null

if (Test-Path $steamRegPath) {
    $steamPath = (Get-ItemProperty -Path $steamRegPath).SteamPath
} else {
    Write-Host "Steam is not installed. Download it here: https://store.steampowered.com/about/"
    exit
}

# Locate steamapps\common folder
$steamCommonPath = Join-Path -Path $steamPath -ChildPath "steamapps\common"

if (-Not (Test-Path $steamCommonPath)) {
    Write-Host "The folder 'steamapps\common' was not found. You may need to log in and download any game first."
    exit
}

# Set the SteamCommon path as a User environment variable
[System.Environment]::SetEnvironmentVariable("SteamCommon", $steamCommonPath, [System.EnvironmentVariableTarget]::User)
Write-Host "Environment variable 'SteamCommon' set to: $steamCommonPath"
