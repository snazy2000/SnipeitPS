<#
.SYNOPSIS
# Gets a list of Snipe-it Locations

.PARAMETER search
A text string to search the Locations data

.PARAMETER id
A id of specific Location

.PARAMETER url
URL of Snipeit system, can be set using Set-Info command

.PARAMETER apiKey
Users API Key for Snipeit, can be set using Set-Info command

.EXAMPLE
Get-Location -url "https://assets.example.com" -token "token..."

.EXAMPLE
Get-Location -url "https://assets.example.com" -token "token..." | Where-Object {$_.name -eq "Location1" }

#>

function Get-SnipeitLocation()
{
    Param(
        [string]$search,
        
        [string]$id,

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

    $apiurl = "$url/api/v1/locations"

    if ($search -and $id ) {
         Throw "[$($MyInvocation.MyCommand.Name)] Please specify only -search or -id parameter , not both "
    }
    
    if ($id) {
       $apiuri= "$url/api/v1/locations/$id"      
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

