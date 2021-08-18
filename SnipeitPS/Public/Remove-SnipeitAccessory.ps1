<#
    .SYNOPSIS
    Removes Accessory from Snipe-it asset system
    .DESCRIPTION
    Removes Accessory or multiple Accessoriers from Snipe-it asset system
    .PARAMETER ID
    Unique ID For accessory to be removed
    .PARAMETER url
    Deprecated parameter, please use Connect-SnipeitPS instead. URL of Snipeit system.

    .PARAMETER apiKey
    Deprecated parameter, please use Connect-SnipeitPS instead. User's API Key for Snipeit.

    .EXAMPLE
    Remove-SnipeitAccessory -ID 44 -Verbose

    .EXAMPLE
    Get-SnipeitAccessory -search needle  | Remove-SnipeitAccessory
#>

function Remove-SnipeitAccessory () {
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]

    Param(
        [parameter(mandatory = $true,ValueFromPipelineByPropertyName)]
        [int[]]$id,

        [parameter(mandatory = $false)]
        [string]$url,

        [parameter(mandatory = $false)]
        [string]$apiKey
    )

    begin {
    }

    process {
        foreach($accessory_id in $id) {
            $Parameters = @{
                Api    = "/api/v1/accessories/$accessory_id"
                Method = 'Delete'
            }

            if ($PSBoundParameters.ContainsKey('apiKey')) {
                Write-Warning "-apiKey parameter is deprecated, please use Connect-SnipeitPS instead."
                Set-SnipeitPSSessionApiKey -apiKey $apikey
            }

            if ($PSBoundParameters.ContainsKey('url')) {
                Write-Warning "-url parameter is deprecated, please use Connect-SnipeitPS instead."
                Set-SnipeitPSSessionUrl -url $url
            }

            if ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
                $result = Invoke-SnipeitMethod @Parameters
            }

            $result
        }
    }
}
