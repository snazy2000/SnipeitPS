<#
    .SYNOPSIS
    Set license seat or checkout license seat
    .DESCRIPTION
    Checkout specific license seat to user, asset or both

    .PARAMETER ID
    Unique ID For license to checkout or array of IDs

    .PARAMETER assigned_to
    Id of target user

    .PARAMETER asset_id
    Id of target asset

    .PARAMETER note
    Notes about checkout

    .PARAMETER url
    URL of Snipeit system, can be set using Set-SnipeItInfo command

    .PARAMETER apiKey
    User's API Key for Snipeit, can be set using Set-SnipeItInfo command

    .EXAMPLE
    Set-SnipeItLicenceSeat -ID 1 -seat_id 1 -assigned_id 3  -Verbose
    Checkout licence to user id 3

    .EXAMPLE
    Set-SnipeItLicenceSeat -ID 1 -seat_id 1 -asset_id 3  -Verbose
    Checkout licence to asset id 3

#>
function Set-SnipeItLicenseSeat()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Medium"
    )]

    Param(
        [parameter(mandatory = $true)]
        [int[]]$id,

        [parameter(mandatory = $true)]
        [int]$seat_id,

        [int]$assigned_id,

        [int]$asset_id,

        [string]$note,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    begin{
        $Values = . Get-ParameterValue -Parameters $MyInvocation.MyCommand.Parameters -BoundParameters $PSBoundParameters

        $Body = $Values | ConvertTo-Json;
    }

    process{
        foreach($license_id in $id) {
            $Parameters = @{
                Uri    = "$url/api/v1/licenses/$license_id/seats/$seat_id"
                Method = 'Patch'
                Body   = $Body
                Token  = $apiKey
            }

            If ($PSCmdlet.ShouldProcess("ShouldProcess?"))
            {
                $result = Invoke-SnipeitMethod @Parameters
            }

            return $result
        }
    }
}
