<#
    .SYNOPSIS
    Set license seat or checkout license seat
    .DESCRIPTION
    Checkout specific license seat to user, asset or both

    .PARAMETER ID
    Unique ID For asset to checkout

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
function Set-SnipeItLicenceSeat()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Medium"
    )]

    Param(
        [parameter(mandatory = $true)]
        [int]$id,

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

    $Values = . Get-ParameterValue $MyInvocation.MyCommand.Parameters

    $Body = $Values | ConvertTo-Json;

    $Parameters = @{
        Uri    = "$url/api/v1/licenses/$id/seats/$seat_id"
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
