<#
.SYNOPSIS
# Gets a list of Snipe-it Users

.PARAMETER search
A text string to search the User data

.PARAMETER id
A id of specific User

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
        
        [string]$id,

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

    $SearchParameter = . Get-ParameterValue
    
    $apiurl = "$url/api/v1/users"

    if ($search -and $id ) {
         Throw "[$($MyInvocation.MyCommand.Name)] Please specify only -search or -id parameter , not both "
    }
    
    if ($id) {
       $apiurl= "$url/api/v1/users/$id"      
    }
    $Parameters = @{
        Uri           = $apiurl
        Method        = 'Get'
        GetParameters = $SearchParameter
        Token         = $apiKey
    }

    $result = Invoke-SnipeitMethod @Parameters

    $result
}
