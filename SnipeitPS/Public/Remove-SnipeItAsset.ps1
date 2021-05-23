<#
    .SYNOPSIS
    Removes Asset from Snipe-it asset system
    .DESCRIPTION
    Removes Asset from Snipe-it asset system
    .PARAMETER ID
    Unique ID For Asset to be removed
    .PARAMETER url
    URL of Snipeit system, can be set using Set-SnipeItInfo command

    .PARAMETER apiKey
    User's API Key for Snipeit, can be set using Set-SnipeItInfo command

    .EXAMPLE
    Remove-Asset -ID 44 -Verbose
#>

function Remove-SnipeItAsset ()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]

    Param(
    [parameter(mandatory = $true)]
        [int]$ID,
    [parameter(mandatory = $true)]
        [string]$URL,
    [parameter(mandatory = $true)]
        [string]$APIKey

    )

    Test-SnipeItAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

    $Values = @{
        "ID"      = $Name
    }

    $Body = $Values | ConvertTo-Json

    $Parameters = @{
        Uri    = "$url/api/v1/hardware/$ID"
        Method = 'Delete'
        Body   = $Body
        Token  = $apiKey
    }

     If ($PSCmdlet.ShouldProcess("ShouldProcess?"))
    {
        $result = Invoke-SnipeitMethod @Parameters
    }

    $result
}
