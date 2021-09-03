<#
.SYNOPSIS
Gets a list of Snipe-it Models

.PARAMETER search
A text string to search the Models data

.PARAMETER id
A id of specific model

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
Get-SnipeitModel -search "DL380"

.EXAMPLE
Get-SnipeitModel -id 1

#>

function Get-SnipeitModel() {
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

        $api = "/api/v1/models"

        if ($search -and $id ) {
            Throw "[$($MyInvocation.MyCommand.Name)] Please specify only -search or -id parameter , not both "
        }

        if ($id) {
        $api= "/api/v1/models/$id"
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
                $res=Get-SnipeitModel @callargs
                $res
                if ($res.count -ne $limit ) {
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
