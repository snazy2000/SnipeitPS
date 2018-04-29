<#
.SYNOPSIS
 Gets a list of Snipe-it Assets

.PARAMETER search
A text string to search the assets data

.PARAMETER order_number
Optionally restrict asset results to this order number

.PARAMETER model_id
Optionally restrict asset results to this asset model ID

.PARAMETER category_id
Optionally restrict asset results to this category ID

.PARAMETER manufacturer_id
Optionally restrict asset results to this manufacturer ID

.PARAMETER company_id
Optionally restrict asset results to this company ID

.PARAMETER location_id
Optionally restrict asset results to this location ID

.PARAMETER status
Optionally restrict asset results to one of these status types: RTD, Deployed, Undeployable, Deleted, Archived, Requestable

.PARAMETER status_id
Optionally restrict asset results to this status label ID

.PARAMETER sort
Specify the column name you wish to sort by

.PARAMETER order
Specify the order (asc or desc) you wish to order by on your sort column

.PARAMETER limit
Specify the number of results you wish to return. Defaults to 50.

.PARAMETER offset
Offset to use

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






