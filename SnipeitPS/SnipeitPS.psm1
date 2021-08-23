<#
.DESCRIPTION
Powershell API for Snipeit Asset Management
#>
$scriptRoot = $PSScriptRoot + '\Public'

Get-ChildItem $scriptRoot *.ps1 | ForEach-Object {
    . $_.FullName
}

$scriptRoot = $PSScriptRoot + '\Private'

Get-ChildItem $scriptRoot *.ps1 | ForEach-Object {
    . $_.FullName
}

#Create unprefixed aliases
Set-SnipeitAlias

#Session variable for storing current session information
$SnipeitPSSession = [ordered]@{
    'url' = $null
    'apiKey' = $null
}
New-Variable -Name SnipeitPSSession  -Value $SnipeitPSSession -Scope Script -Force

