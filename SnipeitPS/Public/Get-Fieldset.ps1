<#
.SYNOPSIS
# Gets a list of Snipe-it Fieldsets

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
        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    $Parameters = @{
        Uri           = "$url/api/v1/fieldsets"
        Method        = 'Get'
        Token         = $apiKey
    }

    $result = Invoke-SnipeitMethod @Parameters

    $result
}
