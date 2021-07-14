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

.PARAMETER min_amt
Minimum Quantity of the components before alert is triggered

.PARAMETER location_id
ID number of the location the accessory is assigned to

.PARAMETER order_number
Order number for the accessory

.PARAMETER purchase_date
Date accessory was purchased

.PARAMETER purchase_cost
Cost of item being purchased.

.PARAMETER image
Image file name and path for item

.PARAMETER image_delete
Remove current image

.PARAMETER RequestType
Http request type to send Snipe IT system. Defaults to Patch you could use Put if needed.

.PARAMETER url
URL of Snipeit system, can be set using Set-SnipeitInfo command

.PARAMETER apiKey
User's API Key for Snipeit, can be set using Set-SnipeitInfo command

.EXAMPLE
An example

.NOTES
General notes
#>
function Set-SnipeitComponent()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Medium"
    )]

    Param(
        [parameter(mandatory = $true,ValueFromPipelineByPropertyName)]
        [int[]]$id,

        [parameter(mandatory = $true)]
        [int]$qty,

        [Nullable[System.Int32]]$min_amt,

        [string]$name,

        [Nullable[System.Int32]]$company_id,

        [Nullable[System.Int32]]$location_id,


        [string]$order_number,

        [datetime]$purchase_date,

        [float]$purchase_cost,

        [ValidateScript({Test-Path $_})]
        [string]$image,

        [switch]$image_delete=$false,

        [ValidateSet("Put","Patch")]
        [string]$RequestType = "Patch",

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )
    begin {
        Test-SnipeitAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

        $Values = . Get-ParameterValue -Parameters $MyInvocation.MyCommand.Parameters -BoundParameters $PSBoundParameters

        if ($Values['purchase_date']) {
            $Values['purchase_date'] = $Values['purchase_date'].ToString("yyyy-MM-dd")
        }
    }

    process {
        foreach($component_id in $id){
        $Parameters = @{
            Uri    = "$url/api/v1/components/$component_id"
            Method = $RequestType
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
