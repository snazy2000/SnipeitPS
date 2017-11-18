function Get-Component()
{
    Param(
        [parameter(mandatory=$true)]
        [string]$url,

        [parameter(mandatory=$true)]
        [string]$apiKey
    )

    $result = Invoke-Method -URi "$url/api/v1/components" `
                  -Method GET `
                  -Token $apiKey

    $result
}

function New-Component()
{
    Param(
        [parameter(mandatory=$true)]
        [string]$name,

        [parameter(mandatory=$true)]
        [string]$category_id,

        [parameter(mandatory=$true)]
        [string]$qty,

        [parameter(mandatory=$true)]
        [string]$url,

        [parameter(mandatory=$true)]
        [string]$apiKey
    )

    $Values = @{
        "name" = $name
        "category_id" = $category_id
        "qty" = $qty
    }

    $Body = $Values | ConvertTo-Json;

    $result = Invoke-Method -URi "$url/api/v1/components" `
                  -Method POST `
                  -Body $Body `
                  -Token $apiKey

    $result
}

function Update-Component()
{
    Param(
        [parameter(mandatory=$true)]
        [string]$id,

        [parameter(mandatory=$true)]
        [string]$qty,

        [parameter(mandatory=$true)]
        [string]$url,

        [parameter(mandatory=$true)]
        [string]$apiKey
    )

    $Values = @{
        "qty" = $qty
    }

    $Body = $Values | ConvertTo-Json;

    $result = Invoke-Method -URi "$url/api/v1/components/$component_id" `
                  -Method Patch `
                  -Body $Body `
                  -Token $apiKey

    $result
}

<#
Checkout does not exsit yet :(

function Checkout-Component($component_id, $asset_id = "")
{
    $Values = @{
        "asset_id" = $asset_id
    }

    $Body = $Values | ConvertTo-Json;

    $Manufacturers = Invoke-RestMethod -Uri "http://assets.dip.co.uk/api/v1/hardware/$component_id/checkout" `
                      -Method Post `
                      -Header $headers `
                      -Body $Body `
                      -ContentType "application/json" `
                      -UserAgent "DI Script/0.1"

    return $Manufacturers
}#>
