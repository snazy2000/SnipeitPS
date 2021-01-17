<#
.SYNOPSIS
# Gets a list of Snipe-it Licenses

.PARAMETER search
A text string to search the Licenses data

.PARAMETER id
A id of specific License

.PARAMETER url
URL of Snipeit system, can be set using Set-Info command

.PARAMETER apiKey
Users API Key for Snipeit, can be set using Set-Info command

.EXAMPLE
Get-License -url "https://assets.example.com" -token "token..."

.EXAMPLE
Get-License -url "https://assets.example.com" -token "token..." | Where-Object {$_.name -eq "License" }

#>

function Get-License() {
    Param(
        [string]$search,

        [string]$id,

        [string]$name,

        [int] $company_id,

        [string]$product_key,

        [int]$order_number,

        [string]$purchase_order,

        [string]$license_name,

        [mailaddress]$license_email,

        [int]$manufacturer_id,

        [int]$supplier_id,

        [int]$depreciation_id,

        [int]$category_id,

        [ValidateSet("asc", "desc")]
        [string]$order = "desc",

        [ValidateSet('id', 'name', 'purchase_cost', 'expiration_date', 'purchase_order', 'order_number', 'notes', 'purchase_date', 'serial', 'company', 'category', 'license_name', 'license_email', 'free_seats_count', 'seats', 'manufacturer', 'supplier')]
        [string]$sort = "created_at",

        [int]$limit = 50,

        [int]$offset,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    $SearchParameter = . Get-ParameterValue
    
    $apiurl = "$url/api/v1/licenses"

    if ($search -and $id ) {
         Throw "[$($MyInvocation.MyCommand.Name)] Please specify only -search or -id parameter , not both "
    }
    
    if ($id) {
       $apiuri= "$url/api/v1/licenses/$id"      
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

