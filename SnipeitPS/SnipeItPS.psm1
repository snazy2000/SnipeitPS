$scriptRoot = $PSScriptRoot + '\public'

Get-ChildItem $scriptRoot *.psm1 | ForEach-Object {
    Import-Module $_.FullName
}

$scriptRoot = $PSScriptRoot + '\private'

Get-ChildItem $scriptRoot *.psm1 | ForEach-Object {
    Import-Module $_.FullName
}