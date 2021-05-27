<#
    .SYNOPSIS
    Removes User from Snipe-it asset system
    .DESCRIPTION
    Long description
    .PARAMETER ID
    Unique ID For User to be removed

    .PARAMETER url
    URL of Snipeit system, can be set using Set-SnipeItInfo command

    .PARAMETER apiKey
    User's API Key for Snipeit, can be set using Set-SnipeItInfo command

    .EXAMPLE
    Remove-SnipeItUser -ID 44 -url $url -apiKey $secret -Verbose
#>

function Remove-SnipeItUser ()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]

    Param(
    [parameter(mandatory = $true)]
        [int]$id,
    [parameter(mandatory = $true)]
        [string]$URL,
    [parameter(mandatory = $true)]
        [string]$APIKey

    )

    Test-SnipeItAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

    $Values = @{
        "ID"      = $id
    }

    $Body = $Values | ConvertTo-Json

    $Parameters = @{
        Uri    = "$url/api/v1/users/$ID"
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
