<#
.SYNOPSIS
# Gets a list of Snipe-it Users

.PARAMETER search
A text string to search the User data

.PARAMETER id
A id of specific User

.PARAMETER username
Search string for username field

.PARAMETER email
Search string for email field

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
Get-SnipeitUser -search SomeSurname

.EXAMPLE
Get-SnipeitUser -id 3

.EXAMPLE
Get-SnipeitUser -username someuser

.EXAMPLE
Get-SnipeitUser -email user@somedomain.com

.EXAMPLE
Get-SnipeitUser -accessory_id 3
Get users with accessory id 3 has been checked out to
#>

function Get-SnipeitUser() {
    [CmdletBinding(DefaultParameterSetName = 'Search')]
    Param(
        [parameter(ParameterSetName='Search')]
        [string]$search,

        [parameter(ParameterSetName='Get with ID')]
        [string]$id,

        [parameter(ParameterSetName='Get users a specific accessory id has been checked out to')]
        [string]$accessory_id,

        [parameter(ParameterSetName='Search')]
        [int]$company_id,

        [parameter(ParameterSetName='Search')]
        [int]$location_id,

        [parameter(ParameterSetName='Search')]
        [int]$group_id,

        [parameter(ParameterSetName='Search')]
        [int]$department_id,

        [parameter(ParameterSetName='Search')]
        [string]$username,

        [parameter(ParameterSetName='Search')]
        [string]$email,

        [parameter(ParameterSetName='Search')]
        [ValidateSet("asc", "desc")]
        [string]$order = "desc",

        [parameter(ParameterSetName='Search')]
        [int]$limit = 50,

        [parameter(ParameterSetName='Search')]
        [int]$offset,

        [parameter(ParameterSetName='Search')]
        [parameter(ParameterSetName='Get users a specific accessory id has been checked out to')]
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
            'Search' { $api = "/api/v1/users"}
            'Get with id'  {$api= "/api/v1/users/$id"}
            'Get users a specific accessory id has been checked out to' {$api= "/api/v1/accessories/$accessory_id/checkedout"}
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
                $res=Get-SnipeitUser @callargs
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
