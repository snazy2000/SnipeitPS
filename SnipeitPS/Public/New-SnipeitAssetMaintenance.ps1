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
URL of Snipeit system, can be set using Set-SnipeitInfo command

.PARAMETER apiKey
Users API Key for Snipeit, can be set using Set-SnipeitInfo command

.EXAMPLE
New-SnipeitAssetMaintenence -asset_id 1 -supplier_id 1 -title "replace keyboard" -start_date 2021-01-01
#>
function New-SnipeitAssetMaintenance() {
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

    Test-SnipeitAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

    $Values = . Get-ParameterValue -Parameters $MyInvocation.MyCommand.Parameters -BoundParameters $PSBoundParameters

    if ($Values['start_date']) {
        $Values['start_date'] = $Values['start_date'].ToString("yyyy-MM-dd")
    }

    if ($Values['completion_date']) {
        $Values['completion_date'] = $Values['completion_date'].ToString("yyyy-MM-dd")
    }


    $Parameters = @{
        Uri    = "$url/api/v1/maintenances"
        Method = 'Post'
        Body   = $Values
        Token  = $apiKey
    }

    If ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
        $result = Invoke-SnipeitMethod @Parameters
    }

    $result
}
