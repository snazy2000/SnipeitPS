<#
.SYNOPSIS
# Gets a list of Snipe-it Suppliers

.PARAMETER search
A text string to search the Supliers data

.PARAMETER id
A id of specific Suplier

.PARAMETER url
URL of Snipeit system, can be set using Set-Info command

.PARAMETER apiKey
Users API Key for Snipeit, can be set using Set-Info command

.EXAMPLE
Get-Supplier -url "https://assets.example.com" -token "token..."

.EXAMPLE
Get-Supplier -url "https://assets.example.com" -token "token..." | Where-Object {$_.name -eq "MySupplier" }

#>

function Get-Supplier()
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
    
    $apiurl = "$url/api/v1/suppliers"

    if ($search -and $id ) {
         Throw "[$($MyInvocation.MyCommand.Name)] Please specify only -search or -id parameter , not both "
    }
    
    if ($id) {
       $apiuri= "$url/api/v1/suppliers/$id"      
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

