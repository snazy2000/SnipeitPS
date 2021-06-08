<#
    .SYNOPSIS
    Add a new Location to Snipe-it asset system

    .DESCRIPTION
    Long description

    .PARAMETER name
    Name of the Location

    .PARAMETER address
    Address line 1 of the location

    .PARAMETER address2
    Address line 2 of the location

    .PARAMETER state
    Address State of the location

    .PARAMETER country
    Country of the location

    .PARAMETER zip
    The zip code of the location

    .PARAMETER ldap_ou
    The LDAP OU of the location

    .PARAMETER parent_id
    Parent location ID for the location

    .PARAMETER currency
    Currency used at the location

    .PARAMETER city
    City of the location

    .PARAMETER manager_id
    The manager ID of the location

    .PARAMETER url
    URL of Snipeit system, can be set using Set-SnipeItInfo command

    .PARAMETER apiKey
    Users API Key for Snipeit, can be set using Set-SnipeItInfo command

    .EXAMPLE
    New-SnipeItLocation -name "Room 1" -address "123 Asset Street" -parent_id 14
#>

function New-SnipeItLocation() {
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

        [string]$currency,

        [int]$parent_id,

        [int]$manager_id,

        [string]$ldap_ou,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    Test-SnipeItAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

    $Values = . Get-ParameterValue -Parameters $MyInvocation.MyCommand.Parameters -BoundParameters $PSBoundParameters

    $Body = $Values | ConvertTo-Json;

    $Parameters = @{
        Uri    = "$url/api/v1/locations"
        Method = 'post'
        Body   = $Body
        Token  = $apiKey
    }

    If ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
        $result = Invoke-SnipeitMethod @Parameters
    }

    $result
}
