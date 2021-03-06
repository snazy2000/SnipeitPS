<#
    .SYNOPSIS
    Updates Location in Snipe-it asset system

    .DESCRIPTION
    Long description

    .PARAMETER id
    ID number of location or array or IDs

    .PARAMETER name
    Name of Location

    .PARAMETER address
    Address line 1

    .PARAMETER address2
    Address line 2

    .PARAMETER state
    Address State

    .PARAMETER country
    Address Contry

    .PARAMETER zip
    Address zipcode

    .PARAMETER state
    Address State

    .PARAMETER manager_id
    Location manager as id

    .PARAMETER city
    City of the location

    .PARAMETER currency
    Currency used at the location

    .PARAMETER ldap_ou
    LDAP OU of Location

    .PARAMETER parent_id
    Parent location as id

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
    Set-SnipeitLocation -id 123 -name "Some storage"  -parent_id 100


#>
function Set-SnipeitLocation() {
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]

    Param(
        [parameter(mandatory = $true,ValueFromPipelineByPropertyName)]
        [int[]]$id,

        [ValidateLength(3, 255)]
        [string]$name,

        [string]$address,

        [string]$address2,

        [string]$state,

        [string]$country,

        [string]$zip,

        [string]$city,

        [string]$currency,

        [Nullable[System.Int32]]$manager_id,

        [string]$ldap_ou,

        [Nullable[System.Int32]]$parent_id,

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

    begin{
        Test-SnipeitAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

        $Values = . Get-ParameterValue -Parameters $MyInvocation.MyCommand.Parameters -BoundParameters $PSBoundParameters
    }

    process{
        foreach ($location_id in $id) {
            $Parameters = @{
                Uri    = "$url/api/v1/locations/$location_id"
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

