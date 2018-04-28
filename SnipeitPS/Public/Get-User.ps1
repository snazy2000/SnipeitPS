<#
.SYNOPSIS
# Gets a list of Snipe-it Users

.PARAMETER url
URL of Snipeit system, can be set using Set-Info command

.PARAMETER apiKey
Users API Key for Snipeit, can be set using Set-Info command

.EXAMPLE
Get-User -url "https://assets.example.com" -token "token..."

.EXAMPLE
Get-User -url "https://assets.example.com" -token "token..." | Where-Object {$_.username -eq "stephenm" }

#>
function Get-User() {
    Param(
        [string]$search,

        [int]$company_id,

        [int]$location_id,

        [int]$group_id,

        [int]$department_id,

        [ValidateSet("asc", "desc")]
        [string]$order = "desc",

        [int]$limit = 50,

        [int]$offset,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    $SearchParameter = @{
        sort   = $sort
        order  = $order
        limit  = $limit
        offset = $offset
    }

    if ($PSBoundParameters.ContainsKey('search')) { $SearchParameter.Add("search", $search) }
    if ($PSBoundParameters.ContainsKey('company_id')) { $SearchParameter.Add("company_id", $company_id) }
    if ($PSBoundParameters.ContainsKey('location_id')) { $SearchParameter.Add("location_id", $location_id) }
    if ($PSBoundParameters.ContainsKey('group_id')) { $SearchParameter.Add("group_id", $group_id) }
    if ($PSBoundParameters.ContainsKey('department_id')) { $SearchParameter.Add("department_id", $department_id) }

    $Parameters = @{
        Uri           = "$url/api/v1/users"
        Method        = 'Get'
        GetParameters = $SearchParameter
        Token         = $apiKey
    }

    $result = Invoke-SnipeitMethod @Parameters

    $result
}
