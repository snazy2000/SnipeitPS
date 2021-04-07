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

        [int]$location_id,

        [ValidateSet("asc", "desc")]
        [string]$order = "desc",

        [ValidateSet('id', 'name', 'min_amt', 'order_number', 'serial', 'purchase_date', 'purchase_cost', 'company', 'category', 'qty', 'location', 'image', 'created_at')]
        [string]$sort = "created_at",

        [int]$limit = 50,

        [int]$offset,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    $SearchParameter = . Get-ParameterValue

    $Parameters = @{
        Uri           = "$url/api/v1/components"
        Method        = 'Get'
        Token         = $apiKey
        GetParameters = $SearchParameter
    }

    $result = Invoke-SnipeitMethod @Parameters

    $result
}
