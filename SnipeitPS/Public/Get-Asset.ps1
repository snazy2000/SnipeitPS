<#
.SYNOPSIS
# Gets a list of Snipe-it Assets

.PARAMETER url
URL of Snipeit system, can be set using Set-Info command

.PARAMETER apiKey
Users API Key for Snipeit, can be set using Set-Info command

.EXAMPLE
Get-Asset -url "https://assets.example.com" -token "token..."

.EXAMPLE
Get-Asset -url "https://assets.example.com" -token "token..." | Where-Object {$_.name -eq "MyMachine" }

#>

function Get-Asset() {
    Param(
        [string]$search,

        [int]$order_number,

        [int]$model_id,

        [int]$category_id,

        [int]$manufacturer_id,

        [int]$company_id,

        [int]$location_id,

        [string]$status,

        [int]$status_id,

        [string]$sort = "created_at",

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
        sort    = $sort
        order   = $order
        limit   = $limit
        offset  = $offset
    }

    if ($PSBoundParameters.ContainsKey('search')) { $SearchParameter.Add("search", $search) }
    if ($PSBoundParameters.ContainsKey('order_number')) { $SearchParameter.Add("order_number", $order_number) }
    if ($PSBoundParameters.ContainsKey('model_id')) { $SearchParameter.Add("model_id", $model_id) }
    if ($PSBoundParameters.ContainsKey('category_id')) { $SearchParameter.Add("category_id", $category_id) }
    if ($PSBoundParameters.ContainsKey('manufacturer_id')) { $SearchParameter.Add("manufacturer_id", $manufacturer_id) }
    if ($PSBoundParameters.ContainsKey('company_id')) { $SearchParameter.Add("company_id", $company_id) }
    if ($PSBoundParameters.ContainsKey('location_id')) { $SearchParameter.Add("location_id", $location_id) }
    if ($PSBoundParameters.ContainsKey('status_id')) { $SearchParameter.Add("status_id", $order_number) }
    if ($PSBoundParameters.ContainsKey('status')) { $SearchParameter.Add("status", $order_number) }
    if ($PSBoundParameters.ContainsKey('order_number')) { $SearchParameter.Add("order_number", $order_number) }

    $Parameters = @{
        Uri           = "$url/api/v1/hardware"
        Method        = 'Get'
        GetParameters = $SearchParameter
        Token         = $apiKey
    }

    $result = Invoke-SnipeitMethod @Parameters

    $result
}






