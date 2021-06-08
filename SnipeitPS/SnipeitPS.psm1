<#
.DESCRIPTION
Powershell API for SnipeIt Asset Management
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
