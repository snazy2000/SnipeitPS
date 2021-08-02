<#
.SYNOPSIS
Add a new Audit to Snipe-it asset system

.DESCRIPTION
Long description

.PARAMETER Tag
The asset tag of the asset you wish to audit

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
        [string]$url,

        [parameter(mandatory = $false)]
        [string]$apiKey

    )

    Test-SnipeitAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

    $Values = @{
        "location_id" = $location_id
    }

    if ($PSBoundParameters.ContainsKey('tag')) {
        $Values += @{"asset_tag" = $tag}
    }

    $Parameters = @{
        Api    = "/api/v1/hardware/audit"
        Method = 'Post'
        Body   = $Values
    }

    if ($PSBoundParameters.ContainsKey('apiKey')) {
        Write-Warning "-apiKey parameter is deprecated, please use Connect-SnipeitPS instead."
        Set-SnipeitPSSessionApiKey -apiKey $apikey
    }

    if ($PSBoundParameters.ContainsKey('url')) {
        Write-Warning "-url parameter is deprecated, please use Connect-SnipeitPS instead."
        Set-SnipeitPSSessionApiKey -url $url
    }

    if ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
        $result = Invoke-SnipeitMethod @Parameters
    }

    $result
}
