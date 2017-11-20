<#
.SYNOPSIS
# Gets a list of Snipe-it Categories

.PARAMETER url
URL of Snipeit system, can be set using Set-Info command

.PARAMETER apiKey
Users API Key for Snipeit, can be set using Set-Info command

.EXAMPLE
Get-Category -url "https://assets.example.com" -token "token..."

.EXAMPLE
Get-Category -url "https://assets.example.com" -token "token..." | Where-Object {$_.name -eq "Laptop" }

#>

function Get-Category()
{
    Param(
        [parameter(mandatory=$true)]
        [string]$url,

        [parameter(mandatory=$true)]
        [string]$apiKey
    )

    $Parameters = @{
        Uri           = "$url/api/v1/categories"
        Method        = 'Get'
        Token         = $apiKey
    }

    $result = Invoke-Method @Parameters

    $result
}
