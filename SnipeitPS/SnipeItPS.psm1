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
Set-Alias -Name Get-Asset -Value Get-SnipeItAsset
Set-Alias -Name Get-AssetMaintenance -Value Get-SnipeItAssetMaintenance
Set-Alias -Name Get-Category -Value Get-SnipeItCategory
Set-Alias -Name Get-Company -Value Get-SnipeItCompany
Set-Alias -Name Get-Component -Value Get-SnipeItCompany
Set-Alias -Name Get-CustomField -Value Get-SnipeItCustomField
Set-Alias -Name Get-Department -Value Get-SnipeItDepartment
Set-Alias -Name Get-Fieldset -Value Get-SnipeItFieldset
Set-Alias -Name Get-Manufacturer -Value Get-SnipeItManufacturer
Set-Alias -Name Get-Model -Value Get-SnipeItModel
Set-Alias -Name Get-Status -Value Get-SnipeItStatus
Set-Alias -Name Get-Supplier -Value Get-SnipeItSupplier
Set-Alias -Name Get-User -Value Get-SnipeItUser
Set-Alias -Name New-Asset -Value New-SnipeItAsset
Set-Alias -Name New-AssetMaintenance -Value New-SnipeItAssetMaintenance
Set-Alias -Name New-Category -Value New-SnipeItCategory
Set-Alias -Name New-Component -Value New-SnipeItComponent
Set-Alias -Name New-CustomField -Value New-SnipeItCustomField
Set-Alias -Name New-Department -Value New-SnipeItDepartment
Set-Alias -Name New-License -Value New-SnipeItLicense
Set-Alias -Name Set-License -Value Set-SnipeItLicense
Set-Alias -Name New-Location -Value New-SnipeItLocation
Set-Alias -Name New-Manufacturer -Value New-Manufacturer
Set-Alias -Name New-Model -Value New-SnipeItModel
Set-Alias -Name New-User -Value New-SnipeItUser
Set-Alias -Name Set-Asset -Value Set-SnipeItAsset
Set-Alias -Name Set-AssetOwner -Value Set-SnipeItAssetOwner
Set-Alias -Name Set-Component -Value Set-SnipeItComponent
Set-Alias -Name Set-Model -Value Set-SnipeItModel
Set-Alias -Name Set-Info -Value Set-SnipeItInfo
Set-Alias -Name Set-User -Value Set-SnipeItUser
Set-Alias -Name New-Accessory -Value New-SnipeItAccessory
Set-Alias -Name Set-Accessory -Value Set-SnipeItAccessory
Set-Alias -Name Get-Accessory -Value Get-SnipeItAccessory
Set-Alias -Name Remove-Asset -Value Remove-SnipeItAsset
Set-Alias -Name Remove-User -Value Remove-SnipeItUser
