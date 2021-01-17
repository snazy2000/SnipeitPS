<#
.SYNOPSIS
# Gets a list of Snipe-it Companies

.PARAMETER search
A text string to search the Companies data

.PARAMETER id
A id of specific Company

.PARAMETER url
URL of Snipeit system, can be set using Set-Info command

.PARAMETER apiKey
Users API Key for Snipeit, can be set using Set-Info command

.EXAMPLE
Get-Company -url "https://assets.example.com" -token "token..."

.EXAMPLE
Get-Company -url "https://assets.example.com" -token "token..." | Where-Object {$_.name -eq "Company1" }

#>

function Get-Company()
{
    Param(
        [string]$search,

        [string]$id,

        [ValidateSet("asc", "desc")]
        [string]$order = "desc",

        [int]$limit = 50,

        [int]$offset,

        [parameter(mandatory=$true)]
        [string]$url,

        [parameter(mandatory=$true)]
        [string]$apiKey
    )

    $SearchParameter = . Get-ParameterValue

    $apiurl = "$url/api/v1/companies"

    if ($search -and $id ) {
         Throw "[$($MyInvocation.MyCommand.Name)] Please specify only -search or -id parameter , not both "
    }
    
    if ($id) {
       $apiuri= "$url/api/v1/companies/$id"      
    }

    $Parameters = @{
        Uri           = $apiurl
        Method        = 'Get'
        Token         = $apiKey
        GetParameters = $SearchParameter
    }

    $result = Invoke-SnipeitMethod @Parameters

    $result
}
