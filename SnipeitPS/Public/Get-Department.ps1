<#
.SYNOPSIS
# Gets a list of Snipe-it Departments

.PARAMETER search
A text string to search the Departments data

.PARAMETER id
A id of specific Department

.PARAMETER url
URL of Snipeit system, can be set using Set-Info command

.PARAMETER apiKey
Users API Key for Snipeit, can be set using Set-Info command

.EXAMPLE
Get-Department -url "https://assets.example.com" -token "token..."

.EXAMPLE
Get-Department -url "https://assets.example.com" -token "token..." | Where-Object {$_.name -eq "Department1" }

#>

function Get-Department()
{
    Param(
        [string]$search,

        [string]$id,

        [ValidateSet("asc", "desc")]
        [string]$order = "desc",

        [int]$limit = 50,

        [int]$offset,

        [ValidateSet('id', 'name', 'image', 'users_count', 'created_at')]
        [string]$sort = "created_at",

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    $SearchParameter = . Get-ParameterValue
    
    $apiurl = "$url/api/v1/departments"

    if ($search -and $id ) {
         Throw "[$($MyInvocation.MyCommand.Name)] Please specify only -search or -id parameter , not both "
    }
    
    if ($id) {
       $apiurl= "$url/api/v1/departments/$id"      
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

