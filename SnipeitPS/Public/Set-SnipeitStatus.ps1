<#
.SYNOPSIS
Sets  Snipe-it Status Labels

.PARAMETER id
A id of specific Status Label


.PARAMETER color
Hex code showing what color the status label should be on the pie chart in the dashboard

.PARAMETER show_in_nav
1 or 0 - determine whether the status label should show in the left-side nav of the web GUI

.PARAMETER default_label
1 or 0 - determine whether it should be bubbled up to the top of the list of available statuses

.PARAMETER RequestType
Http request type to send Snipe IT system. Defaults to Patch you could use Put if needed.

.PARAMETER url
Deprecated parameter, please use Connect-SnipeitPS instead. URL of Snipeit system.

.PARAMETER apiKey
Deprecated parameter, please use Connect-SnipeitPS instead. Users API Key for Snipeit.

.EXAMPLE
Get-SnipeitStatus -search  "Ready to Deploy"

.EXAMPLE
Set-SnipeitStatus -id 3 -name 'Waiting for arrival' -type pending

#>

function Set-SnipeitStatus() {
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Medium"
    )]
    Param(
        [parameter(Mandatory=$true,ValueFromPipelineByPropertyName)]
        [int[]]$id,

        [string]$name,

        [parameter(Mandatory=$true)]
        [ValidateSet('deployable','undeployable','pending','archived')]
        [string]$type,

        [string]$notes,

        [string]$color,

        [bool]$show_in_nav,

        [bool]$default_label,

        [ValidateSet("Put","Patch")]
        [string]$RequestType = "Patch",

        [parameter(mandatory = $false)]
        [string]$url,

        [parameter(mandatory = $false)]
        [string]$apiKey
    )

    begin {
        $Values = . Get-ParameterValue -Parameters $MyInvocation.MyCommand.Parameters -BoundParameters $PSBoundParameters
    }

    process {
        foreach($status_id in $id) {
            $Parameters = @{
                Api           = "/api/v1/statuslabels/$status_id"
                Method        = $RequestType
                Body          = $Values
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
            $result
        }
    }

    end {
        # reset legacy sessions
        if ($PSBoundParameters.ContainsKey('url') -and '' -ne [string]$url -or $PSBoundParameters.ContainsKey('apiKey') -and '' -ne [string]$apiKey) {
            Reset-SnipeitPSLegacyApi
        }
    }
}
