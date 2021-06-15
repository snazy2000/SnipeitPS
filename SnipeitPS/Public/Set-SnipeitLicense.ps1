<#
    .SYNOPSIS
    Updates a licence

    .DESCRIPTION
    Updates licence on Snipe-It system

    .PARAMETER id
    ID number of license or array of license IDs

    .PARAMETER name
    Name of license

    .PARAMETER seats
    Number of license seats owned.

    .PARAMETER company_id
    Id number of company license belongs to

    .PARAMETER expiration_date
    Date of license expiration

    .PARAMETER expiration_date
    Date of license expiration

    .PARAMETER license_email
    Email address associated with license

    .PARAMETER license_name
    Name of license contact person

    .PARAMETER serial
    Serialnumber  of license

    .PARAMETER maintained
    Maintained status of license

    .PARAMETER manufacturer_id
    ID number of manufacturer of license.

    .PARAMETER notes
    License Notes

    .PARAMETER order_number
    Order number of license purchase

    .PARAMETER purchase_cost
    Cost of license

    .PARAMETER purchase_date
    Date of license purchase

    .PARAMETER reassignable
    Is license reassignable?

    .PARAMETER supplier_id
    ID number of license supplier

    .PARAMETER termination_date
    Termination date for license.

    .PARAMETER url
    URL of Snipeit system, can be set using Set-SnipeitInfo command

    .PARAMETER apiKey
    Users API Key for Snipeit, can be set using Set-SnipeitInfo command

    .EXAMPLE
    Set-SnipeitLicence -name "License" -seats 3 -company_id 1

#>

function Set-SnipeitLicense() {
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]

    Param(
        [parameter(mandatory = $true, ValueFromPipelineByPropertyName)]
        [int[]]$id,

        [ValidateLength(3, 255)]
        [string]$name,

        [ValidateRange(1, [int]::MaxValue)]
        [int]$seats,

        [ValidateRange(1, [int]::MaxValue)]
        [int]$category_id,

        [ValidateRange(1, [int]::MaxValue)]
        [int]$company_id,

        [datetime]$expiration_date,

        [ValidateLength(1, 120)]
        [mailaddress]$license_email,

        [ValidateLength(1, 100)]
        [string]$license_name,

        [bool]$maintained,

        [ValidateRange(1, [int]::MaxValue)]
        [int]$manufacturer_id,

        [string]$notes,


        [string]$order_number,

        [float]$purchase_cost,

        [datetime]$purchase_date,

        [bool]$reassignable,

        [string]$serial,

        [ValidateRange(1, [int]::MaxValue)]
        [int]$supplier_id,

        [datetime]$termination_date,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    begin{
        Test-SnipeitAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

        $Values = . Get-ParameterValue -Parameters $MyInvocation.MyCommand.Parameters -BoundParameters $PSBoundParameters

        if ($Values['expiration_date']) {
            $Values['expiration_date'] = $Values['expiration_date'].ToString("yyyy-MM-dd")
        }

        if ($Values['purchase_date']) {
            $Values['purchase_date'] = $Values['purchase_date'].ToString("yyyy-MM-dd")
        }

        if ($Values['termination_date']) {
            $Values['termination_date'] = $Values['termination_date'].ToString("yyyy-MM-dd")
        }

    }

    process {
        foreach($license_id in $id){
            $Parameters = @{
                Uri    = "$url/api/v1/licenses/$license_id"
                Method = 'PUT'
                Body   = $Values
                Token  = $apiKey
            }

            If ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
                $result = Invoke-SnipeitMethod @Parameters
            }

            $result
        }
    }
}
