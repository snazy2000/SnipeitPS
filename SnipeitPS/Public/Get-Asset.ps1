<#
.SYNOPSIS
 Gets a list of Snipe-it Assets

.PARAMETER search
A text string to search the assets data

.PARAMETER id
A text string to search the assets data

.PARAMETER asset_tag
Specify exact asset tag to query

.PARAMETER asset_serial
Specify exact asset serial to query

.PARAMETER all
A return all results , works with -search and other filters

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
Get-Asset -url "https://assets.example.com"-token "token..."

.EXAMPLE
Get-Asset -search "myMachine"-url "https://assets.example.com"-token "token..."

.EXAMPLE
Get-Asset -search "myMachine"-url "https://assets.example.com"-token "token..."

.EXAMPLE
Get-Asset -asset_tag "myAssetTag"-url "https://assets.example.com"-token "token..."
#>
function Get-Asset() {
    Param(
        [string]$search,

        [string]$id,

        [string]$asset_tag,

        [string]$asset_serial,

        [bool]$all = $false,

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


    $apiurl = "$url/api/v1/hardware"

    if($search -and ($asset_tag -or $asset_serial -or $id)) {
         Throw "[$($MyInvocation.MyCommand.Name)] Please specify only one of -search , -asset_tag or -asset_serial parameter"
    }

    if($id) {
       if( $search -or $asset_serial -or $asset_tag) {
         Throw "[$($MyInvocation.MyCommand.Name)] Please specify only one of -search , -asset_tag or -asset_serial parameter"
       }
       $apiurl= "$url/api/v1/hardware/$id"     
    }

    if($asset_tag) {
       if( $search -or $asset_serial -or $id) {
         Throw "[$($MyInvocation.MyCommand.Name)] Please specify only one of -search , -asset_tag or -asset_serial parameter"
       }
       $apiurl= "$url/api/v1/hardware/bytag/$asset_tag"     
    }

    if($asset_serial) {
       if( $search -or $asset_tag) {
         Throw "[$($MyInvocation.MyCommand.Name)] Please specify only one of-search , -asset_tag or -asset_serial parameter"
       }
       $apiurl= "$url/api/v1/hardware/byserial/$asset_serial"     
    }

    $Parameters = @{
        Uri           = $apiurl
        Method        = 'Get'
        GetParameters = $SearchParameter
        Token         = $apiKey
    }

    if($all) {
        $offstart = $(if($offset){$offset} Else {0})
        $callargs = $SearchParameter
        $callargs.Remove('all')

        while($true) {
            $callargs['offset'] = $offstart
            $callargs['limit'] = $limit         
            $res=Get-Asset @callargs 
            $res
            if( $res.count -lt $limit) {
                break
            }
            $offstart = $offstart + $limit
        }
    } else {
        $result = Invoke-SnipeitMethod @Parameters
        $result
    }

    
}






