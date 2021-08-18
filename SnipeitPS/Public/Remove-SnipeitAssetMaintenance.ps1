<#
    .SYNOPSIS
    Remove asset maintenance from Snipe-it asset system

    .DESCRIPTION
    Removes asset maintenance event or events from Snipe-it asset system by ID

    .PARAMETER ID
    Unique ID of the asset maintenance to be removed

    .PARAMETER url
    Deprecated parameter, please use Connect-SnipeitPS instead. URL of Snipeit system.
    .PARAMETER url
    Deprecated parameter, please use Connect-SnipeitPS instead. User's API Key for Snipeit.

    .EXAMPLE
    Remove-SnipeitAssetMaintenance -ID 44
#>
function Remove-SnipeitAssetMaintenance {

    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]
    param (
        [Parameter(Mandatory = $true,ValueFromPipelineByPropertyName)]
        [int[]]
        $id,

        [parameter(mandatory = $false)]
        [string]$url,

        [parameter(mandatory = $false)]
        [string]$apiKey
    )

    begin {
        Test-SnipeitAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name
    }

    process {
        foreach($maintenance_id in $id) {
            $Parameters = @{
                Api    = "/api/v1/maintenances/$maintenance_id"
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
