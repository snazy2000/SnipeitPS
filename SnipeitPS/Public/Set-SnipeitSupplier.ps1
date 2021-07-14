<#
    .SYNOPSIS
    Modify the supplier

    .DESCRIPTION
    Modifieds the supplier on Snipe-It system

    .PARAMETER name
    Suppiers Name

    .PARAMETER address
    Address line 1 of supplier

    .PARAMETER address2
    Address line 1 of supplier

    .PARAMETER city
    City

    .PARAMETER state
    State

    .PARAMETER country
    Country

    .PARAMETER zip
    Zip code

    .PARAMETER phone
    Phone number

    .PARAMETER fax
    Fax number

    .PARAMETER email
    Email address

    .PARAMETER contact
    Contact person

    .PARAMETER notes
    Email address

    .PARAMETER image
    Image file name and path for item

    .PARAMETER image_delete
    Remove current image

    .PARAMETER RequestType
    Http request type to send Snipe IT system. Defaults to Patch you could use Put if needed.

    .PARAMETER url
    URL of Snipeit system, can be set using Set-SnipeitInfo command

    .PARAMETER apiKey
    Users API Key for Snipeit, can be set using Set-SnipeitInfo command

    .EXAMPLE
    New-SnipeitDepartment -name "Department1" -company_id 1 -localtion_id 1 -manager_id 3

#>

function Set-SnipeitSupplier() {
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]

    Param(
        [parameter(mandatory = $true)]
        [string]$name,

        [string]$address,

        [string]$address2,

        [string]$city,

        [string]$state,

        [string]$country,

        [string]$zip,

        [string]$phone,

        [string]$fax,

        [string]$email,

        [string]$contact,

        [string]$notes,

        [ValidateScript({Test-Path $_})]
        [string]$image,

        [switch]$image_delete,

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

    }
    process {
        foreach ($supplier_id in $id) {
            $Parameters = @{
                Uri    = "$url/api/v1/suppliers/$supplier_id"
                Method = $RequestType
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

