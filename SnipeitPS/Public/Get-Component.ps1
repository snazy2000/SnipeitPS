<#
.SYNOPSIS
# Gets a list of Snipe-it Components

.PARAMETER url
URL of Snipeit system, can be set using Set-Info command

.PARAMETER apiKey
Users API Key for Snipeit, can be set using Set-Info command

.EXAMPLE
Get-Component -url "https://assets.example.com" -token "token..."

.EXAMPLE
Get-Component -url "https://assets.example.com" -token "token..." | Where-Object {$_.name -eq "Memory" }

#>

function Get-Component() {
    Param(
        [string]$search,

        [int]$category_id,

        [int]$company_id,

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
    if ($PSBoundParameters.ContainsKey('category_id')) { $SearchParameter.Add("category_id", $category_id) }
    if ($PSBoundParameters.ContainsKey('company_id')) { $SearchParameter.Add("company_id", $company_id) }

    $Parameters = @{
        Uri           = "$url/api/v1/components"
        Method        = 'Get'
        Token         = $apiKey
        GetParameters = $SearchParameter
    }

    $result = Invoke-SnipeitMethod @Parameters

    $result
}
