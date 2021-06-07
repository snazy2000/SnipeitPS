<#
.SYNOPSIS
Creates new accessory on Snipe-It system

.DESCRIPTION
Creates new accessory on Snipe-It system

.PARAMETER name
Accessory name

.PARAMETER notes
Notes about the accessory

.PARAMETER qty
Quantity of the accessory you have

.PARAMETER category_id
ID number of the category the accessory belongs to

.PARAMETER company_id
ID Number of the company the accessory is assigned to

.PARAMETER manufacturer_id
ID number of the manufacturer for this accessory.

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
URL of Snipeit system, can be set using Set-SnipeItInfo command

.PARAMETER apiKey
Users API Key for Snipeit, can be set using Set-SnipeItInfo command

.EXAMPLE
New-SnipeItAccessory -name "Accessory" -qty 3  -category_id 1

#>
function New-SnipeItAccessory() {
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]

    Param(
        [parameter(mandatory = $true)]
        [ValidateLength(3, 255)]
        [string]$name,

        [parameter(mandatory = $true)]
        [int]$qty,

        [parameter(mandatory = $true)]
        [ValidateRange(1, [int]::MaxValue)]
        [int]$category_id,

        [ValidateRange(1, [int]::MaxValue)]
        [int]$company_id,

        [ValidateRange(1, [int]::MaxValue)]
        [int]$manufacturer_id,

        [string]$order_number,

        [float]$purchase_cost,

        [datetime]$purchase_date,

        [int]$min_qty,

        [ValidateRange(1, [int]::MaxValue)]
        [int]$supplier_id,

        [ValidateRange(1, [int]::MaxValue)]
        [int]$location_id,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    Test-SnipeItAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

    $Values = . Get-ParameterValue -Parameters $MyInvocation.MyCommand.Parameters -BoundParameters $PSBoundParameters

    if ($values['purchase_date']) {
        $values['purchase_date'] = $values['purchase_date'].ToString("yyyy-MM-dd")
    }

    $Body = $Values | ConvertTo-Json;

    $Parameters = @{
        Uri    = "$url/api/v1/accessories"
        Method = 'POST'
        Body   = $Body
        Token  = $apiKey
    }

    If ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
        $result = Invoke-SnipeitMethod @Parameters
    }

    $result
}

