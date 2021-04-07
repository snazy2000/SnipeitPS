<#
    .SYNOPSIS
    Removes User from Snipe-it asset system
    .DESCRIPTION
    Long description
    .PARAMETER ID
    Unique ID For User to be removed
    .EXAMPLE
    Remove-User -ID 44 -url $url -apiKey $secret -Verbose
#>

function Remove-User ()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]

    Param(
    [parameter(mandatory = $true)]
        [string]$ID,
    [parameter(mandatory = $true)]
        [string]$URL,
    [parameter(mandatory = $true)]
        [string]$APIKey

    )

    $Values = @{
        "ID"      = $ID
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
