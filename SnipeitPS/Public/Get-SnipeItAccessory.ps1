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
URL of Snipeit system, can be set using Set-SnipeItInfo command

.PARAMETER apiKey
Users API Key for Snipeit, can be set using Set-SnipeItInfo command

.EXAMPLE
Get-SnipeItAccessory -search Keyboard

.EXAMPLE
Get-SnipeItAccessory -id 1

#>

function Get-SnipeItAccessory() {
    Param(
        [string]$search,

        [int]$company_id,

        [int]$category_id,

        [int]$manufacturer_id,

        [int]$supplier_id,

        [string]$sort = "created_at",

        [ValidateSet("asc", "desc")]
        [string]$order = "desc",

        [int]$limit = 50,

        [int]$offset,

        [switch]$all = $false,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )
    Test-SnipeItAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

    $SearchParameter = . Get-ParameterValue $MyInvocation.MyCommand.Parameters

    $Parameters = @{
        Uri           = "$url/api/v1/accessories"
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
            $res=Get-SnipeItAccessory @callargs
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






