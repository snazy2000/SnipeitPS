function Get-Users()
{
    Param( 
        [parameter(mandatory=$true)]            
        [string]$url,

        [parameter(mandatory=$true)]            
        [string]$apiKey
    )

    $result = Invoke-Method -URi "$url/api/v1/users?limit=999" `
                  -Method GET `
                  -Token $apiKey

    $result
}
