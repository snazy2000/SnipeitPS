<#
.SYNOPSIS
Create a new component

.DESCRIPTION
Createa new componen on Snipe-It system

.PARAMETER name
Component name

.PARAMETER category_id
ID number of category

.PARAMETER qty
Quantity of the components you have

.PARAMETER location_id
ID number of the location the accessory is assigned to

.PARAMETER order_number
Order number of the component

.PARAMETER purchase_date
Date accessory was purchased

.PARAMETER purchase_cost
Cost of item being purchased.

.PARAMETER url
URL of Snipeit system, can be set using Set-SnipeItInfo command

.PARAMETER apiKey
User's API Key for Snipeit, can be set using Set-SnipeItInfo command

.EXAMPLE
An example

.NOTES
General notes
#>

function New-SnipeItComponent() {
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]

    Param(
        [parameter(mandatory = $true)]
        [string]$name,

        [parameter(mandatory = $true)]
        [int]$category_id,

        [parameter(mandatory = $true)]
        [string]$qty,

        [int]$company_id,

        [int]$location_id,

        [string]$order_number,

        [datetime]$purchase_date,

        [float]$purchase_cost,

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
        Uri    = "$url/api/v1/components"
        Method = 'POST'
        Body   = $Body
        Token  = $apiKey
    }

    If ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
        $result = Invoke-SnipeitMethod @Parameters
    }

    $result
}

