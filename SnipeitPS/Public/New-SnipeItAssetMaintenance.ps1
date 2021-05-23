<#
.SYNOPSIS
Add a new Asset maintenence to Snipe-it asset system

.DESCRIPTION
Long description


.PARAMETER title
Required Title of maintenance

.PARAMETER asset_id
Required ID of the asset, this can be got using Get-Asset

.PARAMETER supplier_id
Required maintenance supplier

.PARAMETER start_date
Required start date

.PARAMETER is_warranty
Optional Maintenance done under warranty

.PARAMETER cost
Optional cost

.PARAMETER comletion_date
Optional completion date

.PARAMETER notes
Optional cost

.PARAMETER url
URL of Snipeit system, can be set using Set-SnipeItInfo command

.PARAMETER apiKey
Users API Key for Snipeit, can be set using Set-SnipeItInfo command

.EXAMPLE
New-AssetMaintenence -asset_id 1 -supplier_id 1 -title "replace keyboard" -start_date 2021-01-01
#>
function New-SnipeItAssetMaintenance() {
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
        [datetime]$start_date,

        [parameter(mandatory = $false)]
        [datetime]$completion_date,

        [bool]$is_warranty = $false,

        [decimal]$cost,

        [string]$notes,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    Test-SnipeItAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

    $Values = . Get-ParameterValue $MyInvocation.MyCommand.Parameters

    if ($values['start_date']) {
        $values['start_date'] = $values['start_date'].ToString("yyyy-MM-dd")
    }

    if ($values['completion_date']) {
        $values['completion_date'] = $values['completion_date'].ToString("yyyy-MM-dd")
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
