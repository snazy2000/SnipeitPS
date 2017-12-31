$scriptRoot = $PSScriptRoot + '\public'

Get-ChildItem $scriptRoot *.ps1 | ForEach-Object {
    Import-Module $_.FullName
}

$scriptRoot = $PSScriptRoot + '\private'

Get-ChildItem $scriptRoot *.ps1 | ForEach-Object {
    Import-Module $_.FullName
}
