<#
.DESCRIPTION
Powershell API for Snipeit Asset Management
#>
$scriptRoot = $PSScriptRoot + '\Public'

Get-ChildItem $scriptRoot *.ps1 | ForEach-Object {
    Import-Module $_.FullName
}

$scriptRoot = $PSScriptRoot + '\Private'

Get-ChildItem $scriptRoot *.ps1 | ForEach-Object {
    Import-Module $_.FullName
}

#Create unprefixed aliases
Set-SnipeitAlias

#Session variable for storing current session information
$SnipeitPSSession = [ordered]@{
    'url' = $null
    'apiKey' = $null
}
New-Variable -Name SnipeitPSSession  -Value $SnipeitPSSession -Scope Script -Force

#Config variable
$SnipeitPSConfig = [ordered]@{
    'latest' = $null
    'connections' = [ordered]@{}
}
New-Variable -Name SnipeitPSConfig  -Value $SnipeitPSConfig -Scope Script -Force
