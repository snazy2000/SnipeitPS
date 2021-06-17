<#
.SYNOPSIS
Updates accessory on Snipe-It system

.DESCRIPTION
Updates accessory on Snipe-It system

.PARAMETER name
ID number of Accessory or array of IDs on Snipe-It system

.PARAMETER notes
Notes about the accessory

.PARAMETER qty
Quantity of the accessory you have

.PARAMETER min_amt
Minimum amount of the accessory, before alert is triggered

.PARAMETER category_id
ID number of the category the accessory belongs to

.PARAMETER company_id
ID Number of the company the accessory is assigned to

.PARAMETER manufacturer_id
ID number of the manufacturer for this accessory.

.PARAMETER model_number
Model number for this accessory

.PARAMETER order_number
Order number for this accessory.

.PARAMETER purchase_cost
Cost of item being purchased.

.PARAMETER purchase_date
Date accessory was purchased

.PARAMETER order_number
Order number for this accessory.

.PARAMETER purchase_cost
Cost of item being purchased.

.PARAMETER purchase_date
Date accessory was purchased

.PARAMETER supplier_id
ID number of the supplier for this accessory

.PARAMETER location_id
ID number of the location the accessory is assigned to

.PARAMETER min_qty
Min quantity of the accessory before alert is triggered

.PARAMETER url
URL of Snipeit system, can be set using Set-SnipeitInfoeItInfo command

.PARAMETER apiKey
Users API Key for Snipeit, can be set using Set-SnipeitInfoeItInfoeItInfo command

.EXAMPLE
Set-SnipeitAccessory -id 1 -qty 3

#>
function Set-SnipeitAccessory() {
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]

    Param(
        [parameter(mandatory = $true,ValueFromPipelineByPropertyName)]
        [int[]]$id,

        [ValidateLength(3, 255)]
        [string]$name,

        [int]$qty,

        [ValidateRange(1, [int]::MaxValue)]
        [int]$category_id,

        [Nullable[System.Int32]]$company_id,

        [Nullable[System.Int32]]$manufacturer_id,

        [string]$model_number,

        [string]$order_number,

        [float]$purchase_cost,

        [datetime]$purchase_date,

        [Nullable[System.Int32]]$min_amt,

        [Nullable[System.Int32]]$supplier_id,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    begin {
        Test-SnipeitAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

        $Values = . Get-ParameterValue -Parameters $MyInvocation.MyCommand.Parameters -BoundParameters $PSBoundParameters

        if ($values['purchase_date']) {
            $values['purchase_date'] = $values['purchase_date'].ToString("yyyy-MM-dd")
        }

        $Body = $Values | ConvertTo-Json;
        Write-Verbose "Body: $Body"
        }

    process {
        foreach($accessory_id in $id){
            $Parameters = @{
                Uri    = "$url/api/v1/accessories/$accessory_id"
                Method = 'Put'
                Body   = $Body
                Token  = $apiKey
            }

            If ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
                $result = Invoke-SnipeitMethod @Parameters
            }

            $result
       }
    }
}

