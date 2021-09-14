<#
.SYNOPSIS
Gets a list of Snipe-it Licenses

.PARAMETER search
A text string to search the Licenses data

.PARAMETER id
A id of specific License

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
Get-SnipeitLicense -search SomeLicense

.EXAMPLE
Get-SnipeitLicense -id 1

#>

function Get-SnipeitLicense() {
    [CmdletBinding(DefaultParameterSetName = 'Search')]
    Param(
        [parameter(ParameterSetName='Search')]
        [string]$search,

        [parameter(ParameterSetName='Get with ID')]
        [int]$id,

        [parameter(ParameterSetName='Get licenses checked out to user ID')]
        [int]$user_id,

        [parameter(ParameterSetName='Get licenses checked out to asset ID')]
        [int]$asset_id,

        [parameter(ParameterSetName='Search')]
        [string]$name,

        [parameter(ParameterSetName='Search')]
        [int] $company_id,

        [parameter(ParameterSetName='Search')]
        [string]$product_key,

        [parameter(ParameterSetName='Search')]
        [string]$order_number,

        [parameter(ParameterSetName='Search')]
        [string]$purchase_order,

        [parameter(ParameterSetName='Search')]
        [string]$license_name,

        [parameter(ParameterSetName='Search')]
        [mailaddress]$license_email,

        [parameter(ParameterSetName='Search')]
        [int]$manufacturer_id,

        [parameter(ParameterSetName='Search')]
        [int]$supplier_id,

        [parameter(ParameterSetName='Search')]
        [int]$depreciation_id,

        [parameter(ParameterSetName='Search')]
        [int]$category_id,

        [parameter(ParameterSetName='Search')]
        [ValidateSet("asc", "desc")]
        [string]$order = "desc",

        [parameter(ParameterSetName='Search')]
        [ValidateSet('created_at','id', 'name', 'purchase_cost', 'expiration_date', 'purchase_order', 'order_number', 'notes', 'purchase_date', 'serial', 'company', 'category', 'license_name', 'license_email', 'free_seats_count', 'seats', 'manufacturer', 'supplier')]
        [string]$sort = "created_at",

        [parameter(ParameterSetName='Search')]
        [int]$limit = 50,

        [parameter(ParameterSetName='Search')]
        [int]$offset,
        [parameter(ParameterSetName='Get licenses checked out to user ID')]
        [parameter(ParameterSetName='Get licenses checked out to asset ID')]
        [parameter(ParameterSetName='Search')]
        [switch]$all = $false,

        [parameter(mandatory = $false)]
        [string]$url,

        [parameter(mandatory = $false)]
        [string]$apiKey
    )
    begin {
        Test-SnipeitAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

        $SearchParameter = . Get-ParameterValue -Parameters $MyInvocation.MyCommand.Parameters -BoundParameters $PSBoundParameters

        switch($PsCmdlet.ParameterSetName) {
            'Search' {$api = "/api/v1/licenses"}
            'Get with ID' {$api= "/api/v1/licenses/$id"}
            'Get licenses checked out to user ID' {$api= "/api/v1/users/$user_id/licenses"}
            'Get licenses checked out to asset ID' {$api= "/api/v1/hardware/$asset_id/licenses"}
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
            $callargs.Remove('all')

            while ($true) {
                $callargs['offset'] = $offstart
                $callargs['limit'] = $limit
                $res=Get-SnipeitLicense @callargs
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

    end {
        # reset legacy sessions
        if ($PSBoundParameters.ContainsKey('url') -and '' -ne [string]$url -or $PSBoundParameters.ContainsKey('apiKey') -and '' -ne [string]$apiKey) {
            Reset-SnipeitPSLegacyApi
        }
    }
}

