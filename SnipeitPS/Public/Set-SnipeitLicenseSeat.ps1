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

    .PARAMETER RequestType
    Http request type to send Snipe IT system. Defaults to Patch you could use Put if needed.

    .PARAMETER url
    URL of Snipeit system, can be set using Set-SnipeitInfo command

    .PARAMETER apiKey
    User's API Key for Snipeit, can be set using Set-SnipeitInfo command

    .EXAMPLE
    Set-SnipeitLicenceSeat -ID 1 -seat_id 1 -assigned_id 3
    Checkout licence to user id 3

    .EXAMPLE
    Set-SnipeitLicenceSeat -ID 1 -seat_id 1 -asset_id 3
    Checkout licence to asset id 3

    .EXAMPLE
    Set-SnipeitLicenceSeat -ID 1 -seat_id 1 -asset_id $null -assigned_id $null
    Checkin licence seat id 1 of licence id 1

#>
function Set-SnipeitLicenseSeat()
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

        [Alias('assigned_id')]

        [Nullable[System.Int32]]$assigned_to,


        [Nullable[System.Int32]]$asset_id,

        [string]$note,

        [ValidateSet("Put","Patch")]
        [string]$RequestType = "Patch",

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    begin{
        $Values = . Get-ParameterValue -Parameters $MyInvocation.MyCommand.Parameters -BoundParameters $PSBoundParameters
    }

    process{
        foreach($license_id in $id) {
            $Parameters = @{
                Uri    = "$url/api/v1/licenses/$license_id/seats/$seat_id"
                Method = $RequestType
                Body   = $Values
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
