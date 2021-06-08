function Set-SnipeitAlias()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]
    param()
    Write-Verbose "Setting compatibility aliases.. "
    Write-Verbose "All aliases are deprediated."
    $SnipeitAliases = get-SnipeitAlias
    ForEach ($key in $SnipeitAliases.Keys ) {
        New-Alias -Name $key -Value $($SnipeitAliases[$key]) -Scope 1
        Write-Verbose ("{0,5} -> {1}" -f $key,$($SnipeitAliases[$key]))
    }
    Write-Verbose "Please start using native 'Snipeit' prfixed functions instead."
    Get-Command -Module SnipeitPS -CommandType Alias | Select-Object -Property DisplayName,ResolvedCommand

}
