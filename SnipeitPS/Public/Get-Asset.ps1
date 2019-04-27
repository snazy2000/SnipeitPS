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
Get-Asset -search "myMachine" -url "https://assets.example.com" -token "token..."

.EXAMPLE
Get-Asset -search "myMachine" -url "https://assets.example.com" -token "token..."
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

        [int]$depreciation_id,

        [bool]$requestable = $false,

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

    $SearchParameter = . Get-ParameterValue

    $Parameters = @{
        Uri           = "$url/api/v1/hardware"
        Method        = 'Get'
        GetParameters = $SearchParameter
        Token         = $apiKey
    }

    $result = Invoke-SnipeitMethod @Parameters

    $result
}






