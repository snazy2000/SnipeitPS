<#
.SYNOPSIS
Add a new Audit to Snipe-it asset system

.DESCRIPTION
Long description

.PARAMETER Tag
The asset tag of the asset you wish to audit

.PARAMETER Next_audit
Due date for the asset's next audit

.PARAMETER Location_id
ID of the location you want to associate with the audit

.EXAMPLE
New-SnipeitAudit -tag 1 -location_id 1

#>

function New-SnipeitAudit() {
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]

    Param(
        [parameter(mandatory = $true)]
        [string]$tag,

        [int]$location_id,

        [parameter(mandatory = $false)]
        [datetime]$next_audit,

        [parameter(mandatory = $false)]
        [string]$url,

        [parameter(mandatory = $false)]
        [string]$apiKey

    )
    begin {
        Test-SnipeitAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

        $Values = @{
            "location_id" = $location_id
        }

        if ($PSBoundParameters.ContainsKey('tag')) {
            $Values += @{"asset_tag" = $tag}
        }
        
        if ($PSBoundParameters.ContainsKey('next_audit')) {
            $Values += @{"next_audit_date" = ($next_audit).ToString("yyyy-MM-dd")}
        }

        $Parameters = @{
            Api    = "/api/v1/hardware/audit"
            Method = 'Post'
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
    }

    process {
        if ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
            $result = Invoke-SnipeitMethod @Parameters
        }

        $result
    }

    end {
        # reset legacy sessions
        if ($PSBoundParameters.ContainsKey('url') -and '' -ne [string]$url -or $PSBoundParameters.ContainsKey('apiKey') -and '' -ne [string]$apiKey) {
            Reset-SnipeitPSLegacyApi
        }
    }
}
