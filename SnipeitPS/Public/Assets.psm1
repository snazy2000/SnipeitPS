function Get-Asset()
{
    Param( 
        [parameter(mandatory=$true)]            
        [string]$url,

        [parameter(mandatory=$true)]            
        [string]$apiKey
    )

    $result = Invoke-Method -URi "$url/api/v1/hardware" `
                  -Method GET `
                  -Token $apiKey

    $result
}

function New-Asset()
{
    Param( 
        [parameter(mandatory=$true)]            
        [string]$Name,
        
        [parameter(mandatory=$true)]            
        [string]$Status_id,

        [parameter(mandatory=$true)]            
        [string]$Model_id,
         
        [parameter(mandatory=$true)]            
        [string]$url,

        [parameter(mandatory=$true)]            
        [string]$apiKey,

        [string]$CPU,
          
        [string]$memory,
          
        [string]$OSDrive,
         
        [string]$OS
    )

    $Values = @{
        "name" = $Name
        "status_id" = $status_id
        "model_id" = $model_id
        _snipeit_cpu_2 = $CPU
        _snipeit_memory_gb_3 = $memory
        _snipeit_os_drive_4 = $OSDrive
        _snipeit_os_5 = $OS
    }

    $Body = $Values | ConvertTo-Json;

    $result = Invoke-Method -URi "$url/api/v1/hardware" `
                  -Method POST `
                  -Body $Body `
                  -Token $apiKey

    $result
}

function Set-Asset()
{
    Param( 
        [parameter(mandatory=$true)]            
        [int]$id,

        [parameter(mandatory=$true)]            
        [string]$Name,

        [parameter(mandatory=$true)]            
        [string]$Status_id,

        [parameter(mandatory=$true)]            
        [string]$Model_id,
         
        [parameter(mandatory=$true)]            
        [string]$url,

        [parameter(mandatory=$true)]            
        [string]$apiKey,

        [string]$CPU,
          
        [string]$memory,
          
        [string]$OSDrive,
         
        [string]$OS
    )

    $Values = @{
        "name" = $asset_name
        "status_id" = $status_id
        "model_id" = $model_id
        "_snipeit_cpu_2" = $CPU
        "_snipeit_memory_gb_3" = $memory
        "_snipeit_os_drive_4" = $OSDrive
        "_snipeit_os_5" = $OS
    }

    $Body = $Values | ConvertTo-Json;

    $result = Invoke-Method -URi "$url/api/v1/hardware/$id" `
                  -Method PUT `
                  -Body $Body `
                  -Token $apiKey

    $result
}

function Checkout-Asset()
{
    Param( 
        [parameter(mandatory=$true)]            
        [int]$id,

        [parameter(mandatory=$true)]            
        [int]$user_id,

        [parameter(mandatory=$true)]            
        [string]$url,

        [parameter(mandatory=$true)]            
        [string]$apiKey
    )

    $Values = @{
        "user_id" = $user_id
    }

    $Body = $Values | ConvertTo-Json;

    $result = Invoke-Method -Uri "$url/api/v1/hardware/$id/checkout" `
                      -Method POST `
                      -Token $apiKey `
                      -Body $Body 

    return $result
}
