function Get-Accessory() {
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

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    $SearchParameter = . Get-ParameterValue

    $Parameters = @{
        Uri           = "$url/api/v1/accessories"
        Method        = 'Get'
        GetParameters = $SearchParameter
        Token         = $apiKey
    }

    $result = Invoke-SnipeitMethod @Parameters

    $result
}






