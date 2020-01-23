<#
    .SYNOPSIS
    Removes Asset to Snipe-it asset system
    .DESCRIPTION
    Long description
    .PARAMETER ID
    Unique ID For Asset to be removed
    
    .EXAMPLE
    Remove-Asset -ID 44 -url $url -apiKey $secret -Verbose
#>

function Remove-Asset ()
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
        "ID"      = $Name
    }
    
    $Body = $Values | ConvertTo-Json;

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
