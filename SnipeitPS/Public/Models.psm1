
function Get-Models()
{
    Param(
        [parameter(mandatory=$true)]
        [string]$url,

        [parameter(mandatory=$true)]
        [string]$apiKey
    )

    $result = Invoke-Method -URi "$url/api/v1/models" `
                  -Method GET `
                  -Token $apiKey

    $result
}


function New-Model()
{
    Param(
        [parameter(mandatory=$true)]
        [string]$name,

        [parameter(mandatory=$true)]
        [int]$category_id,

        [parameter(mandatory=$true)]
        [int]$manufacturer_id,

        [parameter(mandatory=$true)]
        [int]$fieldset_id,

        [parameter(mandatory=$true)]
        [string]$url,

        [parameter(mandatory=$true)]
        [string]$apiKey
    )

    $Values = @{
        name = $name
        category_id = $category_id
        manufacturer_id = $manufacturer_id
        fieldset_id = $fieldset_id
    }

    $Body = $Values | ConvertTo-Json;

    $result = Invoke-Method -URi "$url/api/v1/models" `
                  -Method POST `
                  -Body $Body `
                  -Token $apiKey

    $result
}
