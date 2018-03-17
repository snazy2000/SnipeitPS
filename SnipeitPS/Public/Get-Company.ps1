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
        [parameter(mandatory=$true)]
        [string]$url,

        [parameter(mandatory=$true)]
        [string]$apiKey
    )

    $Parameters = @{
        Uri           = "$url/api/v1/companies"
        Method        = 'Get'
        Token         = $apiKey
    }

    $result = Invoke-SnipeitMethod @Parameters

    $result
}
