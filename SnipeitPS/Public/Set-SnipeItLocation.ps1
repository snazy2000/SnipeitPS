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

    .PARAMETER url
    URL of Snipeit system, can be set using Set-SnipeItInfo command

    .PARAMETER apiKey
    Users API Key for Snipeit, can be set using Set-SnipeItInfo command

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

        [int]$manager_id,

        [string]$ldap_ou,

        [int]$parent_id,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    begin{
        Test-SnipeItAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

        $Values = . Get-ParameterValue $MyInvocation.MyCommand.Parameters

        $Body = $Values | ConvertTo-Json;
    }

    process{
        foreach ($location_id in $id) {
            $Parameters = @{
                Uri    = "$url/api/v1/locations/$location_id"
                Method = 'PUT'
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

