<#
.SYNOPSIS
Returns a fieldset or list of Snipe-it Fieldsets

.PARAMETER id
A id of specific fieldset

.PARAMETER url
URL of Snipeit system, can be set using Set-Info command

.PARAMETER apiKey
Users API Key for Snipeit, can be set using Set-Info command

.EXAMPLE
Get-Fieldset -url "https://assets.example.com" -token "token..."

.EXAMPLE
Get-Fieldset -url "https://assets.example.com" -token "token..." | Where-Object {$_.name -eq "Windows" }

#>

function Get-Fieldset() {
    Param(
        [int]$id,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    if ($id) {
        $apiurl = "$url/api/v1/fieldsets/$id"
    } else {
        $apiurl = "$url/api/v1/fieldsets"
    }

    $Parameters = @{
        Uri           = $apiurl
        Method        = 'Get'
        Token         = $apiKey
    }

    $result = Invoke-SnipeitMethod @Parameters

    $result
}
