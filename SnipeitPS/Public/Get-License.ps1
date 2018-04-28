<#
.SYNOPSIS
# Gets a list of Snipe-it Licenses

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

        [string]$name,

        [int] $company_id,

        [string]$product_key,

        [int]$order_number,

        [string]$purchase_order,

        [string]$license_name,

        [string]$license_email,

        [int]$manufacturer_id,

        [int]$supplier_id,

        [int]$depreciation_id,

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
    if ($PSBoundParameters.ContainsKey('name')) { $SearchParameter.Add("name", $name) }
    if ($PSBoundParameters.ContainsKey('company_id')) { $SearchParameter.Add("company_id", $company_id) }
    if ($PSBoundParameters.ContainsKey('product_key')) { $SearchParameter.Add("product_key", $product_key) }
    if ($PSBoundParameters.ContainsKey('order_number')) { $SearchParameter.Add("order_number", $order_number) }
    if ($PSBoundParameters.ContainsKey('purchase_order')) { $SearchParameter.Add("purchase_order", $purchase_order) }
    if ($PSBoundParameters.ContainsKey('license_name')) { $SearchParameter.Add("license_name", $license_name) }
    if ($PSBoundParameters.ContainsKey('license_email')) { $SearchParameter.Add("license_email", $license_email) }
    if ($PSBoundParameters.ContainsKey('manufacturer_id')) { $SearchParameter.Add("manufacturer_id", $manufacturer_id) }
    if ($PSBoundParameters.ContainsKey('supplier_id')) { $SearchParameter.Add("supplier_id", $supplier_id) }
    if ($PSBoundParameters.ContainsKey('depreciation_id')) { $SearchParameter.Add("depreciation_id", $depreciation_id) }

    $Parameters = @{
        Uri           = "$url/api/v1/licenses"
        Method        = 'Get'
        Token         = $apiKey
        GetParameters = $SearchParameter
    }

    $result = Invoke-SnipeitMethod @Parameters

    $result
}

