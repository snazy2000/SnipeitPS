<#
.SYNOPSIS
Gets a list of Snipe-it Assets or specific asset

.PARAMETER search
A text string to search the assets data

.PARAMETER id
ID number of excact snipeit asset

.PARAMETER asset_tag
Exact asset tag to query

.PARAMETER asset_serial
Exact asset serialnumber to query

.PARAMETER audit_due
Retrieve a list of assets that are due for auditing soon.

.PARAMETER audit_overdue
Retrieve a list of assets that are overdue for auditing.

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
Specify the number of results you wish to return. Defaults to 50. Defines batch size for -all

.PARAMETER offset
Offset to use

.PARAMETER all
A return all results, works with -offset and other parameters

.PARAMETER url
Deprecated parameter, please use Connect-SnipeitPS instead. URL of Snipeit system.

.PARAMETER apiKey
Deprecated parameter, please use Connect-SnipeitPS instead. Users API Key for Snipeit.

.EXAMPLE
Get-SnipeitAsset -all
Returens all assets

.EXAMPLE
Get-SnipeitAsset -search "myMachine"
Search for specific asset

.EXAMPLE
Get-SnipeitAsset -id 3
Get asset with id number 3

.EXAMPLE
Get-SnipeitAsset -asset_tag snipe0003
Get asset with asset tag snipe00033

.EXAMPLE
Get-SnipeitAsset -serial 1234
Get asset with searial number 1234

.EXAMPLE
Get-SnipeitAsser -audit_due
Get Assets due auditing soon

.EXAMPLE
Get-SnipeitAsser -audit_overdue
Get Assets overdue for auditing

.EXAMPLE
Get-AnipeitAsset -user_id 4
Get Assets checked out to user id 4

.EXAMPLE
Get-SnipeitAsset -component_id 5
Get Assets with component id 5


#>

function Get-SnipeitAsset() {
    [CmdletBinding(DefaultParameterSetName = 'Search')]
    Param(
        [parameter(ParameterSetName='Search')]
        [string]$search,

        [parameter(ParameterSetName='Get with id')]
        [int]$id,

        [parameter(ParameterSetName='Get with asset tag')]
        [string]$asset_tag,

        [parameter(ParameterSetName='Get with serial')]
        [Alias('asset_serial')]
        [string]$serial,

        [parameter(ParameterSetName='Assets due auditing soon')]
        [switch]$audit_due,

        [parameter(ParameterSetName='Assets overdue for auditing')]
        [switch]$audit_overdue,

        [parameter(ParameterSetName='Assets checked out to user id')]
        [int]$user_id,

        [parameter(ParameterSetName='Assets with component id')]
        [int]$component_id,

        [parameter(ParameterSetName='Search')]
        [string]$order_number,

        [parameter(ParameterSetName='Search')]
        [int]$model_id,

        [parameter(ParameterSetName='Search')]
        [int]$category_id,

        [parameter(ParameterSetName='Search')]
        [int]$manufacturer_id,

        [parameter(ParameterSetName='Search')]
        [int]$company_id,

        [parameter(ParameterSetName='Search')]
        [int]$location_id,

        [parameter(ParameterSetName='Search')]
        [int]$depreciation_id,

        [parameter(ParameterSetName='Search')]
        [bool]$requestable = $false,

        [parameter(ParameterSetName='Search')]
        [string]$status,

        [parameter(ParameterSetName='Search')]
        [int]$status_id,

        [parameter(ParameterSetName='Search')]
        [parameter(ParameterSetName='Assets due auditing soon')]
        [parameter(ParameterSetName='Assets overdue for auditing')]
        [parameter(ParameterSetName='Assets checked out to user id')]
        [parameter(ParameterSetName='Assets with component id')]
        [ValidateSet('id','created_at','asset_tag','serial','order_number','model_id','category_id','manufacturer_id','company_id','location_id','status','status_id')]
        [string]$sort,

        [parameter(ParameterSetName='Search')]
        [parameter(ParameterSetName='Assets due auditing soon')]
        [parameter(ParameterSetName='Assets overdue for auditing')]
        [parameter(ParameterSetName='Assets checked out to user id')]
        [parameter(ParameterSetName='Assets with component id')]
        [ValidateSet("asc", "desc")]
        [string]$order,

        [parameter(ParameterSetName='Search')]
        [parameter(ParameterSetName='Assets due auditing soon')]
        [parameter(ParameterSetName='Assets overdue for auditing')]
        [parameter(ParameterSetName='Assets checked out to user id')]
        [parameter(ParameterSetName='Assets with component id')]
        [int]$limit = 50,

        [parameter(ParameterSetName='Search')]
        [parameter(ParameterSetName='Assets due auditing soon')]
        [parameter(ParameterSetName='Assets overdue for auditing')]
        [parameter(ParameterSetName='Assets checked out to user id')]
        [parameter(ParameterSetName='Assets with component id')]
        [int]$offset,

        [parameter(ParameterSetName='Search')]
        [parameter(ParameterSetName='Assets due auditing soon')]
        [parameter(ParameterSetName='Assets overdue for auditing')]
        [parameter(ParameterSetName='Assets checked out to user id')]
        [parameter(ParameterSetName='Assets with component id')]
        [switch]$all = $false,

        [parameter(mandatory = $false)]
        [string]$url,

        [parameter(mandatory = $false)]
        [string]$apiKey
    )

    begin {
        Test-SnipeitAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

        $SearchParameter = . Get-ParameterValue -Parameters $MyInvocation.MyCommand.Parameters -BoundParameters $PSBoundParameters

        switch ($PsCmdlet.ParameterSetName) {
            'Search' { $api = "/api/v1/hardware" }
            'Get with id'  {$api= "/api/v1/hardware/$id"}
            'Get with asset tag' {$api= "/api/v1/hardware/bytag/$asset_tag"}
            'Get with serial' { $api= "/api/v1/hardware/byserial/$serial"}
            'Assets due auditing soon' {$api = "/api/v1/hardware/audit/due"}
            'Assets overdue for auditing' {$api = "/api/v1/hardware/audit/overdue"}
            'Assets checked out to user id'{$api = "/api/v1/users/$user_id/assets"}
            'Assets with component id' {$api = "/api/v1/components/$component_id/assets"}
        }

        $Parameters = @{
            Api           = $api
            Method        = 'Get'
            GetParameters = $SearchParameter
        }

        if ($PSBoundParameters.ContainsKey('apiKey') -and '' -ne [string]$apiKey) {
            Write-Warning "-apiKey parameter is deprecated, please use Connect-SnipeitPS instead."
            Set-SnipeitPSLegacyApiKey -apiKey $apikey
        }

        if ($PSBoundParameters.ContainsKey('url') -and '' -ne [string]$url) {
            Write-Warning "-url parameter is deprecated, please use Connect-SnipeitPS instead."
            Set-SnipeitPSLegacyUrl -url $url
        }
    }

    process {
        if ($all) {
            $offstart = $(if ($offset) {$offset} Else {0})
            $callargs = $SearchParameter
            Write-Verbose "Callargs: $($callargs | convertto-json)"
            $callargs.Remove('all')

            while ($true) {
                $callargs['offset'] = $offstart
                $callargs['limit'] = $limit
                $res=Get-SnipeitAsset @callargs
                $res
                if ( $res.count -lt $limit) {
                    break
                }
                $offstart = $offstart + $limit
            }
        } else {
            $result = Invoke-SnipeitMethod @Parameters
            $result
        }
    }

    end {
        # reset legacy sessions
        if ($PSBoundParameters.ContainsKey('url') -and '' -ne [string]$url -or $PSBoundParameters.ContainsKey('apiKey') -and '' -ne [string]$apiKey) {
            Reset-SnipeitPSLegacyApi
        }
    }

}






