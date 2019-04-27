<#
.SYNOPSIS
 Gets a list of Snipe-it Assets

.PARAMETER asset_id


.PARAMETER search
A text string to search the assets data

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
Get-AssetMaintenances -url "https://assets.example.com" -token "token..."

.EXAMPLE
Get-AssetMaintenances -search "myMachine" -url "https://assets.example.com" -token "token..."

.EXAMPLE
Get-AssetMaintenances -search "myMachine" -url "https://assets.example.com" -token "token..."
#>
function Get-AssetMaintenance() {
    Param(
        [string]$search,

        [int]$asset_id,

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
        Uri           = "$url/api/v1/maintenances"
        Method        = 'Get'
        GetParameters = $SearchParameter
        Token         = $apiKey
    }

    $result = Invoke-SnipeitMethod @Parameters

    $result
}






