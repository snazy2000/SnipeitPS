<#
.SYNOPSIS
# Gets a list of Snipe-it Suppliers

.PARAMETER search
A text string to search the Supliers data

.PARAMETER id
A id of specific Suplier

.PARAMETER name
Optionally restrict Supplier results to this Supplier name.

.PARAMETER address
Optionally restrict Supplier results to this Supplier address.

.PARAMETER address2
Optionally restrict Supplier results to this Supplier address2.

.PARAMETER city
Optionally restrict Supplier results to this Supplier city.

.PARAMETER zip
Optionally restrict Supplier results to this Supplier zip.

.PARAMETER country
Optionally restrict Supplier results to this Supplier country.

.PARAMETER fax
Optionally restrict Supplier results to this Supplier fax number.

.PARAMETER email
Optionally restrict Supplier results to this Supplier email address.

.PARAMETER notes
Optionally restrict Supplier results to this Supplier notes field.

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
Get-SnipeitSupplier -search MySupplier

.EXAMPLE
Get-SnipeitSupplier -id 2

#>
function Get-SnipeitSupplier() {
    [CmdletBinding(DefaultParameterSetName = 'Search')]
    Param(
        [parameter(ParameterSetName='Search')]
        [string]$search,

        [parameter(ParameterSetName='Get with ID')]
        [int]$id,

        [parameter(ParameterSetName='Search')]
        [ValidateSet("asc", "desc")]
        [string]$order = "desc",

		[parameter(ParameterSetName='Search')]
		[string]$name,
		
		[parameter(ParameterSetName='Search')]
		[string]$address,
		
		[parameter(ParameterSetName='Search')]
		[string]$address2,
		
		[parameter(ParameterSetName='Search')]
		[string]$city,
		
		[parameter(ParameterSetName='Search')]
		[string]$zip,
		
		[parameter(ParameterSetName='Search')]
		[string]$country,
		
		[parameter(ParameterSetName='Search')]
		[string]$fax,
		
		[parameter(ParameterSetName='Search')]
		[string]$email,
		
		[parameter(ParameterSetName='Search')]
		[string]$notes,
		
        [parameter(ParameterSetName='Search')]
        [int]$limit = 50,

        [parameter(ParameterSetName='Search')]
        [int]$offset,

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

        $api = "/api/v1/suppliers"

        if ($search -and $id ) {
            Throw "[$($MyInvocation.MyCommand.Name)] Please specify only -search or -id parameter , not both "
        }

        if ($id) {
        $api= "/api/v1/suppliers/$id"
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
                $res=Get-SnipeitSupplier @callargs
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

