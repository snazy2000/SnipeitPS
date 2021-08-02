<#
    .SYNOPSIS
    Sets authetication information. Deprecated, use Connect-SnipeitPS instead.

    .DESCRIPTION
    Deprecated combatibilty function that Set apikey and url user to connect Snipe-It system.
    Please use Connect-SnipeitPS instead.

    .PARAMETER url
    URL of Snipeit system.

    .PARAMETER apiKey
    User's API Key for Snipeit.

    .EXAMPLE
    Set-SnipeitInfo -url $url -apiKey -Verbose
#>
function Set-SnipeitInfo {
    [CmdletBinding()]
    [System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseShouldProcessForStateChangingFunctions', '')]
    param (
        [parameter(Mandatory=$true)]
        [Uri]$url,
        [parameter(Mandatory=$true)]
        [String]$apiKey
    )

    BEGIN {

        Write-Warning "Deprecated $($MyInvocation.InvocationName)  is still working, please use Connect-SnipeitPS instead."
    }

    PROCESS {
        Connect-SnipeitPS -Url $url -apiKey $apiKey
    }
}
