<#
    .SYNOPSIS
    Update a Asset in the Snipe-it asset system

    .DESCRIPTION
    Long description

    .PARAMETER id
    ID of the Asset

    .PARAMETER Name
    Name of the Asset

    .PARAMETER Status_id
    Status ID of the asset, this can be got using Get-Status

    .PARAMETER Model_id
    Model ID of the asset, this can be got using Get-Model

    .PARAMETER url
    URL of Snipeit system, can be set using Set-Info command

    .PARAMETER apiKey
    Users API Key for Snipeit, can be set using Set-Info command

    .PARAMETER customfields
    Hastable of custom fields and extra fields that need passing through to Snipeit

    .EXAMPLE
    Set-Asset -id 1 -status_id 1 -model_id 1 -name "Machine1"

    .EXAMPLE
    Set-Asset -id 1 -status_id 1 -model_id 1 -name "Machine1" -CustomValues = @{ "_snipeit_os_5 = "Windows 10 Pro" }
#>

function Set-Asset()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "High"
    )]

    Param(
        [parameter(mandatory = $true)]
        [int]$id,

        [parameter(mandatory = $true)]
        [string]$Name,

        [parameter(mandatory = $true)]
        [string]$Status_id,

        [parameter(mandatory = $true)]
        [string]$Model_id,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey,

        [hashtable] $customfields
    )

    $Values = @{
        "name"      = $Name
        "status_id" = $status_id
        "model_id"  = $model_id
    }

    $Values += $customfields
    $Body = $Values | ConvertTo-Json;

    $Parameters = @{
        Uri    = "$url/api/v1/hardware/$id"
        Method = 'Put'
        Body   = $Body
        Token  = $apiKey
    }

    If ($PSCmdlet.ShouldProcess())
    {
        $result = Invoke-Method @Parameters
    }

    $result
}
