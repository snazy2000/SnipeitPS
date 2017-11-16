function Get-Manufacturers()
{
    Param( 
        [parameter(mandatory=$true)]            
        [string]$url,

        [parameter(mandatory=$true)]            
        [string]$apiKey
    )

    $result = Invoke-Method -URi "$url/api/v1/manufacturers" `
                  -Method GET `
                  -Token $apiKey

    $result
}

function New-Manufacturer()
{
    Param( 
        [parameter(mandatory=$true)]            
        [string]$Name,

        [parameter(mandatory=$true)]            
        [string]$url,

        [parameter(mandatory=$true)]            
        [string]$apiKey
    )


    $Values = @{
        "name" = $Name
    }

    #Convert Values to JSON format
    $Body = $Values | ConvertTo-Json;

    $result = Invoke-Method -URi "$url/api/v1/manufacturers" `
                  -Method POST `
                  -Body $Body `
                  -Token $apiKey
                  
    $result
}