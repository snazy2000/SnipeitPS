function Test-SnipeItAlias()
{
    [CmdletBinding()]
    param(
        [parameter(mandatory = $true)]
        [string]$invocationName,
        [parameter(mandatory = $true)]
        [string]$commandName
    )
    if($invocationName -ne $commandName) {
        Write-Warning "$invocationName is still working, but it has been superceded by $commandName, please use it instead."
    }
}
