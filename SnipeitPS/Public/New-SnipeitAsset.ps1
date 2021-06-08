<#
.SYNOPSIS
Add a new Asset to Snipe-it asset system

.DESCRIPTION
Long description


.PARAMETER status_id
Required Status ID of the asset, this can be got using Get-Status

.PARAMETER model_id
Required Model ID of the asset, this can be got using Get-Model

.PARAMETER name
Optional Name of the Asset

.PARAMETER asset_tag
Asset Tag for the Asset, not required when snipe asset_tag autogeneration is on.

.PARAMETER serial
Optional Serial number of the Asset

.PARAMETER company_id
Optional Company id

.PARAMETER order_number
Optional Order number

.PARAMETER notes
Optional Notes

.PARAMETER warranty_monhts
Optional Warranty lenght of the Asset in months

.PARAMETER purchase_cost
Optional Purchase cost of the Asset

.PARAMETER purchase_date
Optional Purchase cost of the Asset

.PARAMETER rtd_location_id
Optional Default location id for the asset

.PARAMETER url
URL of Snipeit system, can be set using Set-SnipeitInfo command

.PARAMETER apiKey
Users API Key for Snipeit, can be set using Set-SnipeitInfo command

.PARAMETER customfields
Hastable of custom fields and extra fields that need passing through to Snipeit.
Use internal field names from snipeit .You can use Get-CustomField to get internal field names.

.EXAMPLE
New-SnipeitAsset -status_id 1 -model_id 1 -name "Machine1"
Create asset with automatic tag if tag genaration is enabled on snipe-it, other wise without tag

.EXAMPLE
New-SnipeitAsset -status_id 1 -model_id 1 -name "Machine1" -asset_tag "DEV123"
Specifying asset tag when creating asset

.EXAMPLE
New-SnipeitAsset -status_id 1 -model_id 1 -name "Machine1" -CustomValues = @{ "_snipeit_os_5" = "Windows 10 Pro" }
Using customfields when creating asset.
#>

function New-SnipeitAsset()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]

    Param(

        [parameter(mandatory = $true)]
        [int]$status_id,

        [parameter(mandatory = $true)]
        [int]$model_id,

        [parameter(mandatory = $false)]
        [string]$name,

        [parameter(mandatory = $false)]
        [Alias('tag')]
        [string]$asset_tag,

        [parameter(mandatory = $false)]
        [string]$serial,

        [parameter(mandatory = $false)]
        [int]$company_id,

        [parameter(mandatory = $false)]
        [string]$order_number,

        [parameter(mandatory = $false)]
        [string]$notes,

        [parameter(mandatory = $false)]
        [int]$warranty_months,

        [parameter(mandatory = $false)]
        [string]$purchase_cost,

        [parameter(mandatory = $false)]
        [datetime]$purchase_date,

        [parameter(mandatory = $false)]
        [int]$supplier_id,

        [parameter(mandatory = $false)]
        [int]$rtd_location_id,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey,

        [hashtable] $customfields
    )

    Test-SnipeitAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

    $Values = . Get-ParameterValue -Parameters $MyInvocation.MyCommand.Parameters -BoundParameters $PSBoundParameters

    if ($values['purchase_date']) {
        $values['purchase_date'] = $values['purchase_date'].ToString("yyyy-MM-dd")
    }

    if ($customfields)
    {
        $Values += $customfields
    }

    $Body = $Values | ConvertTo-Json;

    $Parameters = @{
        Uri    = "$url/api/v1/hardware"
        Method = 'Post'
        Body   = $Body
        Token  = $apiKey
    }

    If ($PSCmdlet.ShouldProcess("ShouldProcess?"))
    {
        $result = Invoke-SnipeitMethod @Parameters
    }

    $result
}
