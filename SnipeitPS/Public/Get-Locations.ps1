<#
.SYNOPSIS
# Gets a list of Snipe-it Locations

.PARAMETER url
URL of Snipeit system, can be set using Set-Info command

.PARAMETER apiKey
Users API Key for Snipeit, can be set using Set-Info command

.EXAMPLE
Get-Location -url "https://assets.example.com" -token "token..."

.EXAMPLE
Get-Location -url "https://assets.example.com" -token "token..." | Where-Object {$_.name -eq "Location1" }

#>

function Get-Locations()
{
    Param(
        [string]$search,

        [ValidateSet("asc", "desc")]
        [string]$order = "desc",

        [int]$limit = 50,

        [int]$offset,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    $SearchParameter = . Get-ParameterValue

    $Parameters = @{
        Uri           = "$url/api/v1/locations"
        Method        = 'Get'
        Token         = $apiKey
        GetParameters = $SearchParameter
    }

    $result = Invoke-SnipeitMethod @Parameters

    $result
}

