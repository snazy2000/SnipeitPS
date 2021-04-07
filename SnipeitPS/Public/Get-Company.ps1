<#
.SYNOPSIS
# Gets a list of Snipe-it Companies

.PARAMETER url
URL of Snipeit system, can be set using Set-Info command

.PARAMETER apiKey
Users API Key for Snipeit, can be set using Set-Info command

.EXAMPLE
Get-Company -url "https://assets.example.com" -token "token..."

.EXAMPLE
Get-Company -url "https://assets.example.com" -token "token..." | Where-Object {$_.name -eq "Company1" }

#>

function Get-Company()
{
    Param(
        [string]$search,

        [ValidateSet("asc", "desc")]
        [string]$order = "desc",

        [int]$limit = 50,

        [int]$offset,

        [parameter(mandatory=$true)]
        [string]$url,

        [parameter(mandatory=$true)]
        [string]$apiKey
    )

    $SearchParameter = . Get-ParameterValue

    $Parameters = @{
        Uri           = "$url/api/v1/companies"
        Method        = 'Get'
        Token         = $apiKey
        GetParameters = $SearchParameter
    }

    $result = Invoke-SnipeitMethod @Parameters

    $result
}
