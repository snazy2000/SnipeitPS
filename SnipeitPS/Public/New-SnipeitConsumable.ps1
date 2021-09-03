<#
.SYNOPSIS
Add a new Consumable to Snipe-it asset system

.DESCRIPTION
Long description

.PARAMETER name
Required  Name of the Consumable

.PARAMETER qty
Required Quantity of comsumable

.PARAMETER category_id
Required Category ID of the Consumable, this can be got using Get-SnipeitCategory

.PARAMETER min_amt
Optional minimum quantity of comsumable

.PARAMETER company_id
Optional Company id

.PARAMETER order_number
Optional Order number

.PARAMETER manufacturer_id
Manufaturer id number of the consumable

.PARAMETER location_id
Location id number of the consumable

.PARAMETER requestable
Is consumable requestable?

.PARAMETER purchase_date
Optional Purchase cost of the consumable

.PARAMETER purchase_cost
Optional Purchase cost of the consumable

.PARAMETER model_number
Model number of the consumable in months

.PARAMETER item_no
Item number for the consumable

.PARAMETER image
Consumable Image filename and path

.PARAMETER url
Deprecated parameter, please use Connect-SnipeitPS instead. URL of Snipeit system.

.PARAMETER apiKey
Deprecated parameter, please use Connect-SnipeitPS instead. Users API Key for Snipeit.


.EXAMPLE
New-Snipeitconsumable -name "Ink pack"  -qty 20 -category_id 3 -min_amt 5
Create consumable with stock count 20 , alert when stock is  5 or lower

#>

function New-SnipeitConsumable() {
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]

    Param(
        [parameter(mandatory = $true)]
        [string]$name,

        [parameter(mandatory = $true)]
        [int]$qty,

        [parameter(mandatory = $true)]
        [int]$category_id,

        [parameter(mandatory = $false)]
        [int]$min_amt,

        [parameter(mandatory = $false)]
        [int]$company_id,

        [parameter(mandatory = $false)]
        [string]$order_number,

        [parameter(mandatory = $false)]
        [int]$manufacturer_id,

        [parameter(mandatory = $false)]
        [int]$location_id,

        [parameter(mandatory = $false)]
        [bool]$requestable,

        [parameter(mandatory = $false)]
        [datetime]$purchase_date,

        [parameter(mandatory = $false)]
        [string]$purchase_cost,

        [parameter(mandatory = $false)]
        [string]$model_number,

        [parameter(mandatory = $false)]
        [string]$item_no,

        [ValidateScript({Test-Path $_})]
        [string]$image,

        [parameter(mandatory = $false)]
        [string]$url,

        [parameter(mandatory = $false)]
        [string]$apiKey

    )
    begin {
        $Values = . Get-ParameterValue -Parameters $MyInvocation.MyCommand.Parameters -BoundParameters $PSBoundParameters

        if ($Values['purchase_date']) {
            $Values['purchase_date'] = $Values['purchase_date'].ToString("yyyy-MM-dd")
        }

        $Parameters = @{
            Api    = "/api/v1/consumables"
            Method = 'Post'
            Body   = $Values
        }

        if ($PSBoundParameters.ContainsKey('apiKey') -and '' -ne [string]$apiKey) {
            Write-Warning "-apiKey parameter is deprecated, please use Connect-SnipeitPS instead."
            Set-SnipeitPSLegacyApiKey -apiKey $apikey
        }

        if ($PSBoundParameters.ContainsKey('url') -and '' -ne [string]$url) {
            Write-Warning "-url parameter is deprecated, please use Connect-SnipeitPS instead."
            Set-SnipeitPSLegacyUrl -url $url
        }
    }

    process {
        if ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
            $result = Invoke-SnipeitMethod @Parameters
        }

        $result
    }

    end {
        # reset legacy sessions
        if ($PSBoundParameters.ContainsKey('url') -and '' -ne [string]$url -or $PSBoundParameters.ContainsKey('apiKey') -and '' -ne [string]$apiKey) {
            Reset-SnipeitPSLegacyApi
        }
    }
}
