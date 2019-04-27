<#
    .SYNOPSIS
    Add a new Asset to Snipe-it asset system

    .DESCRIPTION
    Long description

    .PARAMETER Tag
    Asset Tag for the Asset

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
    New-Asset -status_id 1 -model_id 1 -name "Machine1"

    .EXAMPLE
    New-Asset -status_id 1 -model_id 1 -name "Machine1" -CustomValues = @{ "_snipeit_os_5 = "Windows 10 Pro" }
#>

function New-AssetMaintenance() {
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]

    Param(
        [parameter(mandatory = $true)]
        [int]$asset_id,

        [parameter(mandatory = $true)]
        [int]$supplier_id,

        [parameter(mandatory = $true)]
        [string]$asset_maintenance_type,

        [parameter(mandatory = $true)]
        [string]$title,

        [parameter(mandatory = $true)]
        [datetime]$startDate,

        [parameter(mandatory = $false)]
        [datetime]$completionDate,

        [bool]$is_warranty = $false,

        [decimal]$cost,

        [string]$notes,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    $Values = . Get-ParameterValue

    if ($values['start_date']) {
        $values['start_date'] = $values['start_date'].ToString("yyyy-MM-dd")
    }

    if ($values['completionDate']) {
        $values['completionDate'] = $values['completionDate'].ToString("yyyy-MM-dd")
    }

    $Body = $Values | ConvertTo-Json;

    $Parameters = @{
        Uri    = "$url/api/v1/maintenances"
        Method = 'Post'
        Body   = $Body
        Token  = $apiKey
    }

    If ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
        $result = Invoke-SnipeitMethod @Parameters
    }

    $result
}
