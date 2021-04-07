<#
    .SYNOPSIS
    Updates Location in Snipe-it asset system

    .DESCRIPTION
    Long description

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

    .PARAMETER ldap_ou
    LDAP OU of Location

    .PARAMETER parent_id
    Parent location as id

    .PARAMETER url
    URL of Snipeit system, can be set using Set-Info command

    .PARAMETER apiKey
    Users API Key for Snipeit, can be set using Set-Info command

    .EXAMPLE
    Set-SnipeitLocation -id 123 -name "Some storage"  -parent_id 100

  
#>
function Set-SnipeitLocation() {
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]

    Param(
        [parameter(mandatory = $true)]
        [int]$id,

        [ValidateLength(3, 255)]
        [string]$name,

        [string]$address,

        [string]$address2,

        [string]$state,

        [string]$country,

        [string]$zip,

        [int]$manager_id,

        [string]$ldap_ou,

        [int]$parent_id,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    $Values = . Get-ParameterValue

    $Body = $Values | ConvertTo-Json;

    $Parameters = @{
        Uri    = "$url/api/v1/locations/$id"
        Method = 'PUT'
        Body   = $Body
        Token  = $apiKey
    }

    If ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
        $result = Invoke-SnipeitMethod @Parameters
    }

    $result
}

