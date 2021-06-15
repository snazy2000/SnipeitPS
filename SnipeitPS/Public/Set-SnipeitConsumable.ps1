<#
.SYNOPSIS
Add a new Consumable to Snipe-it asset system

.DESCRIPTION
Long description

.PARAMETER id
Optional  id number of the Consumable

.PARAMETER name
Optional  Name of the Consumable

.PARAMETER qty
Optional Quantity of comsumable

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

.PARAMETER url
URL of Snipeit system, can be set using Set-SnipeitInfo command

.PARAMETER apiKey
Users API Key for Snipeit, can be set using Set-SnipeitInfo command


.EXAMPLE
New-Snipeitconsumable -name "Ink pack"  -qty 20 -category_id 3 -min_amt 5
Create consumable with stock count 20 , alert when stock is  5 or lower

#>

function Set-SnipeitConsumable()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]

    Param(
        [parameter(mandatory = $true)]
        [int[]]$id,

        [parameter(mandatory = $false)]
        [string]$name,

        [parameter(mandatory = $false)]
        [int]$qty,

        [parameter(mandatory = $false)]
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

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey

    )
    begin {
        $Values = . Get-ParameterValue -Parameters $MyInvocation.MyCommand.Parameters -BoundParameters $PSBoundParameters

        if ($Values['purchase_date']) {
            $Values['purchase_date'] = $Values['purchase_date'].ToString("yyyy-MM-dd")
        }

    }

    process {
        foreach($consumable_id in $id ){
            $Parameters = @{
                Uri    = "$url/api/v1/consumables/$consumable_id"
                Method = 'Put'
                Body   = $Values
                Token  = $apiKey
            }

            If ($PSCmdlet.ShouldProcess("ShouldProcess?"))
            {
                $result = Invoke-SnipeitMethod @Parameters
            }

            $result
            }
    }
}
