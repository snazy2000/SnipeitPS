<#
.SYNOPSIS
Create a new Snipe-IT Category

.PARAMETER name
Name of new category to be created

.PARAMETER type
Type of new category to be created (asset, accessory, consumable, component, license)

.PARAMETER url
URL of Snipeit system, can be set using Set-SnipeitInfo command

.PARAMETER apiKey
User's API Key for Snipeit, can be set using Set-SnipeitInfo command

.PARAMETER use_default_eula
If switch is present, use the primary default EULA

.PARAMETER eula_text
This allows you to customize your EULAs for specific types of assets

.PARAMETER require_acceptance
If switch is present, require users to confirm acceptance of assets in this category

.PARAMETER checkin_email
Should the user be emailed the EULA and/or an acceptance confirmation email when this item is checked in?

.EXAMPLE
Set-SnipeitCategory -id 4 -name "Laptops"
#>

function Set-SnipeitCategory()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]

    Param(
        [parameter(mandatory = $true)]
        [int[]]$id,

        [string]$name,

        [ValidateSet("asset", "accessory", "consumable", "component", "license")]
        [string]$category_type,

        [string]$eula_text,

        [bool]$use_default_eula,

        [bool]$require_acceptance,

        [bool]$checkin_email,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey

    )

    begin {
        Test-SnipeitAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

        $Values = . Get-ParameterValue -Parameters $MyInvocation.MyCommand.Parameters -BoundParameters $PSBoundParameters
    }

    process {
        foreach($category_id in $id){
            $Parameters = @{
                Uri    = "$url/api/v1/categories/$category_id"
                Method = 'Put'
                Body   = $values
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
