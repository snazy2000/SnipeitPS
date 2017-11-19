$scriptRoot = $PSScriptRoot + '\public'

Get-ChildItem $scriptRoot *.psd1 | ForEach-Object {
    Import-Module $_.FullName
}

$scriptRoot = $PSScriptRoot + '\private'

Get-ChildItem $scriptRoot *.psd1 | ForEach-Object {
    Import-Module $_.FullName
}
