function Set-SnipeItAlias()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]
    param()
    Write-Verbose "Setting compatibility aliases.. "
    $aliases= @{'Get-Asset' = 'Get-SnipeItAsset';
    'Get-AssetMaintenance' = 'Get-SnipeItAssetMaintenance';
    'Get-Category' = 'Get-SnipeItCategory';
    'Get-Company' = 'Get-SnipeItCompany';
    'Get-Component' = 'Get-SnipeItCompany';
    'Get-CustomField' = 'Get-SnipeItCustomField';
    'Get-Department' = 'Get-SnipeItDepartment';
    'Get-Fieldset' = 'Get-SnipeItFieldset';
    'Get-Manufacturer' = 'Get-SnipeItManufacturer';
    'Get-Model' = 'Get-SnipeItModel';
    'Get-Status' = 'Get-SnipeItStatus';
    'Get-Supplier' = 'Get-SnipeItSupplier';
    'Get-User' = 'Get-SnipeItUser';
    'New-Asset' = 'New-SnipeItAsset';
    'New-AssetMaintenance' = 'New-SnipeItAssetMaintenance';
    'New-Category' = 'New-SnipeItCategory';
    'New-Component' = 'New-SnipeItComponent';
    'New-CustomField' = 'New-SnipeItCustomField';
    'New-Department' = 'New-SnipeItDepartment';
    'New-License' = 'New-SnipeItLicense';
    'Set-License' = 'Set-SnipeItLicense';
    'New-Location' = 'New-SnipeItLocation';
    'New-Manufacturer' = 'New-SnipeItManufacturer';
    'New-Model' = 'New-SnipeItModel';
    'New-User' = 'New-SnipeItUser';
    'Set-Asset' = 'Set-SnipeItAsset';
    'Set-AssetOwner' = 'Set-SnipeItAssetOwner';
    'Set-Component' = 'Set-SnipeItComponent';
    'Set-Model' = 'Set-SnipeItModel';
    'Set-Info' = 'Set-SnipeItInfo';
    'Set-User' = 'Set-SnipeItUser';
    'New-Accessory' = 'New-SnipeItAccessory';
    'Set-Accessory' = 'Set-SnipeItAccessory';
    'Get-Accessory' = 'Get-SnipeItAccessory';
    'Remove-Asset' = 'Remove-SnipeItAsset';
    'Remove-User' = 'Remove-SnipeItUser';}
    Write-Verbose "All aliases are deprediated."
    ForEach ($key in $aliases.Keys ) {
        New-Alias -Name $key -Value $($aliases[$key]) -Scope 1
        Write-Verbose ("{0,5} -> {1}" -f $key,$($aliases[$key]))
    }
    Write-Verbose "Please start using native 'SnipeIt' prfixed functions instead."
    Get-Command -Module SnipeItPS -CommandType Alias | Select-Object -Property DisplayName,ResolvedCommand

}
