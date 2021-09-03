<#
    .SYNOPSIS
    Checkout accessory
    .DESCRIPTION
    Checkout accessory to user

    .PARAMETER id
    Unique ID  For accessory or array of IDs to checkout

    .PARAMETER assigned_id
    Id of target user

    .PARAMETER note
    Notes about checkout

    .PARAMETER url
    Deprecated parameter, please use Connect-SnipeitPS instead. URL of Snipeit system.

    .PARAMETER apiKey
    Deprecated parameter, please use Connect-SnipeitPS instead. User's API Key for Snipeit.

    .EXAMPLE
    Set-SnipeitAccessoryOwner -id 1 -assigned_id 1  -note "testing check out to user"
#>
function Set-SnipeitAccessoryOwner() {
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Medium"
    )]

    Param(
        [parameter(mandatory = $true,ValueFromPipelineByPropertyName)]
        [int[]]$id,

        [parameter(mandatory = $true)]
        [int]$assigned_to,

        [string] $note,

        [parameter(mandatory = $false)]
        [string]$url,

        [parameter(mandatory = $false)]
        [string]$apiKey
    )
    begin{
        $Values = . Get-ParameterValue -Parameters $MyInvocation.MyCommand.Parameters -BoundParameters $PSBoundParameters
    }

    process {
        foreach($accessory_id in $id) {
            $Parameters = @{
                Api    = "/api/v1/accessories/$accessory_id/checkout"
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

            return $result
        }
    }

    end {
        # reset legacy sessions
        if ($PSBoundParameters.ContainsKey('url') -and '' -ne [string]$url -or $PSBoundParameters.ContainsKey('apiKey') -and '' -ne [string]$apiKey) {
            Reset-SnipeitPSLegacyApi
        }
    }
}
