<#
.SYNOPSIS
# Gets a list of Snipe-it Models

.PARAMETER search
A text string to search the Models data

.PARAMETER id
A id of specific model

.PARAMETER url
URL of Snipeit system, can be set using Set-Info command

.PARAMETER apiKey
Users API Key for Snipeit, can be set using Set-Info command

.EXAMPLE
Get-Models -url "https://assets.example.com" -token "token..."

.EXAMPLE
Get-Models -url "https://assets.example.com" -token "token..." | Where-Object {$_.name -eq "DL380" }

#>

function Get-Model()
{
    Param(
        [string]$search,

        [int]$id,

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
    
    $apiurl = "$url/api/v1/models"

    if ($search -and $id ) {
         Throw "[$($MyInvocation.MyCommand.Name)] Please specify only -search or -id parameter , not both "
    }
    
    if ($id) {
       $apiurl= "$url/api/v1/models/id/$id"      
    }
    write-host "ID $id, -- $SearchParameter"
    $Parameters = @{
        Uri           = $apiurl
        Method        = 'Get'
        Token         = $apiKey
        #GetParameters = $SearchParameter
    }

    $result = Invoke-SnipeitMethod @Parameters

    $result
}
