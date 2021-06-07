<#
.SYNOPSIS
Updates component

.DESCRIPTION
Updates component on Snipe-It system

.PARAMETER id
ID number of  name

.PARAMETER name
Component name

.PARAMETER category_id
ID number of category

.PARAMETER qty
Quantity of the components you have

.PARAMETER location_id
ID number of the location the accessory is assigned to

.PARAMETER order_number
Order number for the accessory

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
function Set-SnipeItComponent()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Medium"
    )]

    Param(
        [parameter(mandatory = $true)]
        [int]$id,

        [parameter(mandatory = $true)]
        [int]$qty,

        [string]$name,

        [int]$company_id,

        [int]$location_id,

        [AllowEmptyString()]
        [string]$order_number,

        [datetime]$purchase_date,

        [float]$purchase_cost,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    Test-SnipeItAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

    $values = . Get-ParameterValue -Parameters $MyInvocation.MyCommand.Parameters -BoundParameters $PSBoundParameters

    if ($values['purchase_date']) {
        $values['purchase_date'] = $values['purchase_date'].ToString("yyyy-MM-dd")
    }

    $Body = $values | ConvertTo-Json;

    $Parameters = @{
        Uri    = "$url/api/v1/components/$id"
        Method = 'Patch'
        Body   = $Body
        Token  = $apiKey
    }

    If ($PSCmdlet.ShouldProcess("ShouldProcess?"))
    {
        $result = Invoke-SnipeitMethod @Parameters
    }

    $result
}
