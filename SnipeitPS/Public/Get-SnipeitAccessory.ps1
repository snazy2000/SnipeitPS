<#
.SYNOPSIS
Gets a list of Snipe-it Accessories

.DESCRIPTION
Gets a list of Snipe-it Accessories

.PARAMETER search
A text string to search the Accessory data

.PARAMETER id
A id of specific Accessory

.PARAMETER limit
Specify the number of results you wish to return. Defaults to 50. Defines batch size for -all

.PARAMETER offset
Result offset to use

.PARAMETER all
A return all results, works with -offset and other parameters

.PARAMETER url
URL of Snipeit system, can be set using Set-SnipeitInfo command

.PARAMETER apiKey
Users API Key for Snipeit, can be set using Set-SnipeitInfo command

.EXAMPLE
Get-SnipeitAccessory -search Keyboard

.EXAMPLE
Get-SnipeitAccessory -id 1

.EXAMPLE
Get-SnipeitAccessory -user_id 1
Get accessories checked out to user ID 1

#>

function Get-SnipeitAccessory() {
    [CmdletBinding(DefaultParameterSetName = 'Search')]
    Param(
        [parameter(ParameterSetName='Search')]
        [string]$search,

        [parameter(ParameterSetName='Get by ID')]
        [int]$id,

        [parameter(ParameterSetName='Accessories checked out to user id')]
        [int]$user_id,

        [parameter(ParameterSetName='Search')]
        [int]$company_id,

        [parameter(ParameterSetName='Search')]
        [int]$category_id,

        [parameter(ParameterSetName='Search')]
        [int]$manufacturer_id,

        [parameter(ParameterSetName='Search')]
        [int]$supplier_id,

        [parameter(ParameterSetName='Search')]
        [string]$sort = "created_at",

        [parameter(ParameterSetName='Search')]
        [ValidateSet("asc", "desc")]
        [string]$order = "desc",

        [parameter(ParameterSetName='Search')]
        [int]$limit = 50,

        [parameter(ParameterSetName='Search')]
        [int]$offset,

        [parameter(ParameterSetName='Search')]
        [parameter(ParameterSetName='Accessories checked out to user id')]
        [switch]$all = $false,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )
    Test-SnipeitAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

    switch($PsCmdlet.ParameterSetName) {
        'Search' {$apiurl = "$url/api/v1/accessories"}
        'Get by ID' {$apiurl= "$url/api/v1/accessories/$id"}
        'Accessories checked out to user id' {$apiurl = "$url/api/v1/users/$user_id/accessories"}
    }

    $SearchParameter = . Get-ParameterValue -Parameters $MyInvocation.MyCommand.Parameters -BoundParameters $PSBoundParameters

    $Parameters = @{
        Uri           = $apiurl
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
            $res=Get-SnipeitAccessory @callargs
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






