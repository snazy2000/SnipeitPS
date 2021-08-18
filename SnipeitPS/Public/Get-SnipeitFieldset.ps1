<#
.SYNOPSIS
Returns a fieldset or list of Snipe-it Fieldsets

.PARAMETER id
A id of specific fieldset

.PARAMETER url
Deprecated parameter, please use Connect-SnipeitPS instead. URL of Snipeit system.

.PARAMETER apiKey
Deprecated parameter, please use Connect-SnipeitPS instead. Users API Key for Snipeit.

.EXAMPLE
Get-SnipeitFieldset
Get all fieldsets

.EXAMPLE
Get-SnipeitFieldset  | Where-Object {$_.name -eq "Windows" }
Gets fieldset by name

#>

function Get-SnipeitFieldset() {
    Param(
        [int]$id,

        [parameter(mandatory = $false)]
        [string]$url,

        [parameter(mandatory = $false)]
        [string]$apiKey
    )

    Test-SnipeitAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

    if ($id) {
        $api = "/api/v1/fieldsets/$id"
    } else {
        $api = "/api/v1/fieldsets"
    }

    $Parameters = @{
        Api           = $api
        Method        = 'Get'
    }

    if ($PSBoundParameters.ContainsKey('apiKey')) {
        Write-Warning "-apiKey parameter is deprecated, please use Connect-SnipeitPS instead."
        Set-SnipeitPSSessionApiKey -apiKey $apikey
    }

    if ($PSBoundParameters.ContainsKey('url')) {
        Write-Warning "-url parameter is deprecated, please use Connect-SnipeitPS instead."
        Set-SnipeitPSSessionUrl -url $url
    }

    $result = Invoke-SnipeitMethod @Parameters

    $result
}
