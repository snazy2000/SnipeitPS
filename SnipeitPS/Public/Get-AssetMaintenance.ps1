<#
.SYNOPSIS
Lists Snipe-it Assets Maintenances

.PARAMETER asset_id
Asset ID of the asset you'd like to return maintenances for

.PARAMETER search
Search string

.PARAMETER sort
Specify the column name you wish to sort by

.PARAMETER order
Specify the order (asc or desc) you wish to order by on your sort column

.PARAMETER limit
Specify the number of results you wish to return. Defaults to 50. Defines batch size for -all

.PARAMETER offset
Offset to use

.PARAMETER all
A return all results, works with -offset and other parameters

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

        [switch]$all = $false,

        [int]$offset,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    $SearchParameter = . Get-ParameterValue $MyInvocation.MyCommand.Parameters

    $Parameters = @{
        Uri           = "$url/api/v1/maintenances"
        Method        = 'Get'
        GetParameters = $SearchParameter
        Token         = $apiKey
    }

    if ($all) {
        $offstart = $(if($offset){$offset} Else {0})
        $callargs = $SearchParameter
        $callargs.Remove('all')

        while ($true) {
            $callargs['offset'] = $offstart
            $callargs['limit'] = $limit
            $res=Get-AssetMaintenance @callargs
            $res
            if ($res.count -lt $limit) {
                break
            }
            $offstart = $offstart + $limit
        }
    } else {
        $result = Invoke-SnipeitMethod @Parameters
        $result
    }
}






