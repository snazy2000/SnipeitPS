<#
.SYNOPSIS
# Gets a list of Snipe-it Manufacturers

.PARAMETER url
URL of Snipeit system, can be set using Set-Info command

.PARAMETER apiKey
Users API Key for Snipeit, can be set using Set-Info command

.EXAMPLE
Get-Manufacturer -url "https://assets.example.com" -token "token..."

.EXAMPLE
Get-Manufacturer -url "https://assets.example.com" -token "token..." | Where-Object {$_.name -eq "HP" }

#>

function Get-Manufacturer()
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

    $SearchParameter = @{
        sort   = $sort
        order  = $order
        limit  = $limit
        offset = $offset
    }

    if ($PSBoundParameters.ContainsKey('search')) { $SearchParameter.Add("search", $search) }

    $Parameters = @{
        Uri           = "$url/api/v1/manufacturers"
        Method        = 'Get'
        Token         = $apiKey
        GetParameters = $SearchParameter
    }

    $result = Invoke-SnipeitMethod @Parameters

    $result
}
