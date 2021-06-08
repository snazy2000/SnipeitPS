function Test-SnipeitAlias()
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
        Write-Warning 'To update your scripts you can use Update-SnipeitAlias helper function: '
        Write-Warning '"Get-Content [your-script.ps1] | Update-SnipeitAlias | Out-File [new-script-name.ps1]"'
    }
}
