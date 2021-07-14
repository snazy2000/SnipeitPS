<#
.SYNOPSIS
Create a new Snipe-IT Category

.PARAMETER name
Name of new category to be created

.PARAMETER type
Type of new category to be created (asset, accessory, consumable, component, license)

.PARAMETER eula_text
This allows you to customize your EULAs for specific types of assets

.PARAMETER use_default_eula
If switch is present, use the primary default EULA

.PARAMETER require_acceptance
If switch is present, require users to confirm acceptance of assets in this category

.PARAMETER checkin_email
If switch is present, send email to user on checkin/checkout

.PARAMETER image
Category image filename and path

.PARAMETER url
URL of Snipeit system, can be set using Set-SnipeitInfo command

.PARAMETER apiKey
User's API Key for Snipeit, can be set using Set-SnipeitInfo command

.EXAMPLE
New-SnipeitCategory -name "Laptops" -category_type asset -url "Snipe-IT URL here..." -apiKey "API key here..."
#>

function New-SnipeitCategory()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]

    Param(
        [parameter(mandatory = $true)]
        [string]$name,

        [parameter(mandatory = $true)]
        [ValidateSet("asset", "accessory", "consumable", "component", "license")]
        [string]$category_type,

        [string]$eula_text,

        [switch]$use_default_eula,

        [switch]$require_acceptance,

        [switch]$checkin_email,

        [ValidateScript({Test-Path $_})]
        [string]$image,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey

    )
    begin {
        Test-SnipeitAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

        if($eula_text -and $use_default_eula){
            throw 'Dont use -use_defalt_eula if -eula_text is set'
        }

        $Values = . Get-ParameterValue -Parameters $MyInvocation.MyCommand.Parameters -BoundParameters $PSBoundParameters
    }

    process {

        $Parameters = @{
            Uri    = "$url/api/v1/categories"
            Method = 'POST'
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
