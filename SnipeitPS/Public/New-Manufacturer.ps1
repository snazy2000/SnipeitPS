<#
    .SYNOPSIS
    Add a new Manufacturer to Snipe-it asset system

    .DESCRIPTION
    Long description

    .PARAMETER Name
    Name of the Manufacturer

    .PARAMETER url
    URL of Snipeit system, can be set using Set-Info command

    .PARAMETER apiKey
    Users API Key for Snipeit, can be set using Set-Info command

    .EXAMPLE
    New-Manufacturer -name "HP"
#>

function New-Manufacturer()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "High"
    )]

    Param(
        [parameter(mandatory = $true)]
        [string]$Name,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )


    $Values = @{
        "name" = $Name
    }

    #Convert Values to JSON format
    $Body = $Values | ConvertTo-Json;

    $Parameters = @{
        Uri    = "$url/api/v1/manufacturers"
        Method = 'post'
        Body   = $Body
        Token  = $apiKey
    }

    If ($PSCmdlet.ShouldProcess())
    {
        $result = Invoke-Method @Parameters
    }

    $result
}
