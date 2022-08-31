<#
.SYNOPSIS
Gets a list of Snipe-it Locations

.PARAMETER search
A text string to search the Locations data

.PARAMETER id
A id of specific Location

.PARAMETER name
Optionally restrict Location results to this Location name.

.PARAMETER address
Optionally restrict Location results to this Location address.

.PARAMETER address2
Optionally restrict Location results to this Location address2.

.PARAMETER city
Optionally restrict Location results to this Location city.

.PARAMETER zip
Optionally restrict Location results to this Location zip.

.PARAMETER country
Optionally restrict Location results to this Location country.

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
Get-SnipeitLocation -search Location1

.EXAMPLE
Get-SnipeitLocation -id 3

#>

function Get-SnipeitLocation() {
    [CmdletBinding(DefaultParameterSetName = 'Search')]
    Param(
        [parameter(ParameterSetName='Search')]
        [string]$search,

        [parameter(ParameterSetName='Get with ID')]
        [int]$id,

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
        [ValidateSet("asc", "desc")]
        [string]$order = "desc",

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

        $api = "/api/v1/locations"

        if ($search -and $id ) {
            Throw "[$($MyInvocation.MyCommand.Name)] Please specify only -search or -id parameter , not both "
        }

        if ($id) {
        $api= "/api/v1/locations/$id"
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
                $res=Get-SnipeitLocation @callargs
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

