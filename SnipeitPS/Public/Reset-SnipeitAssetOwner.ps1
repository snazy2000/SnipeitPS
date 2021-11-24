<#
    .SYNOPSIS
    Checkin asset
    .DESCRIPTION
    Checks asset in from current user/localtion/asset

    .PARAMETER ID
    Unique ID For asset to checkin

    .PARAMETER status_id
    Change asset status to

    .PARAMETER location_id
    Location id to change asset location to

    .PARAMETER note
    Notes about checkin

    .PARAMETER url
    Deprecated parameter, please use Connect-SnipeitPS instead. URL of Snipeit system.
    .PARAMETER apiKey
    Deprecated parameter, please use Connect-SnipeitPS instead. User's API Key for Snipeit.
    .EXAMPLE
    Remove-SnipeitUser -ID 44
#>
function Reset-SnipeitAssetOwner() {
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Medium"
    )]

    Param(
        [parameter(mandatory = $true)]
        [int]$id,

        [int]$status_id,

        [int]$location_id,

        [string]$note,

        [parameter(mandatory = $false)]
        [string]$url,

        [parameter(mandatory = $false)]
        [string]$apiKey
    )

    Test-SnipeitAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

    $Values = @{
        "note" = $note
    }

    if ($PSBoundParameters.ContainsKey('location_id')) { $Values.Add("location_id", $location_id) }
    if ($PSBoundParameters.ContainsKey('status_id')) { $Values.Add("status_id", $status_id) }

    $Parameters = @{
        Api    = "/api/v1/hardware/$id/checkin"
        Method = 'POST'
        Body   = $Values
    }

    if ($PSBoundParameters.ContainsKey('apiKey') -and '' -ne [string]$apiKey) {
        Write-Warning "-apiKey parameter is deprecated, please use Connect-SnipeitPS instead."
        Set-SnipeitPSLegacyApiKey -apiKey $apikey
    }

    if ($PSBoundParameters.ContainsKey('url') -and '' -ne [string]$url) {
        Write-Warning "-url parameter is deprecated, please use Connect-SnipeitPS instead."
        Set-SnipeitPSLegacyUrl -url $url
    }

    if ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
        $result = Invoke-SnipeitMethod @Parameters
    }

    # reset legacy sessions
    if ($PSBoundParameters.ContainsKey('url') -and '' -ne [string]$url -or $PSBoundParameters.ContainsKey('apiKey') -and '' -ne [string]$apiKey) {
        Reset-SnipeitPSLegacyApi
    }

    return $result
}
