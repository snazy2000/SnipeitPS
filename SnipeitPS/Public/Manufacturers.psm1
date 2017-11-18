function Get-Manufacturer()
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
    [CmdletBinding(
        SupportsShouldProcess=$true,
        ConfirmImpact="High"
    )]

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

    $Parameters = @{
            Uri        = "$url/api/v1/manufacturers"
            Method     = 'post'
            Body       = $Body
            Token      = $apiKey
        }

    If ($PSCmdlet.ShouldProcess()) {
        $result = Invoke-Method @Parameters
    }

    $result
}
