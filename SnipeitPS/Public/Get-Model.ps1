<#
.SYNOPSIS
# Gets a list of Snipe-it Models

.PARAMETER url
URL of Snipeit system, can be set using Set-Info command

.PARAMETER apiKey
Users API Key for Snipeit, can be set using Set-Info command

.EXAMPLE
Get-Models -url "https://assets.example.com" -token "token..."

.EXAMPLE
Get-Models -url "https://assets.example.com" -token "token..." | Where-Object {$_.name -eq "DL380" }

#>

function Get-Model()
{
    Param(
        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    $Parameters = @{
        Uri           = "$url/api/v1/models"
        Method        = 'Get'
        Token         = $apiKey
    }

    $result = Invoke-SnipeitMethod @Parameters

    $result
}
