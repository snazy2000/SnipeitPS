<#
    .SYNOPSIS
    Returns a list of all Snipe-IT custom fields

    .PARAMETER url
    URL of Snipeit system, can be set using Set-Info command

    .PARAMETER apiKey
    Users API Key for Snipeit, can be set using Set-Info command

    .EXAMPLE
    Get-Field -url "https://assets.example.com" -token "token..."

#>

function Get-CustomField()
{
    Param(
        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    $Parameters = @{
        Uri           = "$url/api/v1/fields"
        Method        = 'Get'
        Token         = $apiKey
    }


    $result = Invoke-SnipeitMethod @Parameters

    $result
}
