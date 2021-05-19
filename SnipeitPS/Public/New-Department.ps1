<#
    .SYNOPSIS
    Creates a department

    .DESCRIPTION
    Creates a new department on Snipe-It system

    .PARAMETER name
    Department Name

    .PARAMETER company_id
    ID number of company

    .PARAMETER location_id
    ID number of location

    .PARAMETER manager_id
    ID number of manager

    .PARAMETER url
    URL of Snipeit system, can be set using Set-Info command

    .PARAMETER apiKey
    Users API Key for Snipeit, can be set using Set-Info command

    .EXAMPLE
    New-Department -name "Department1" -company_id 1 -localtion_id 1 -manager_id 3

#>

function New-Department() {
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]

    Param(
        [parameter(mandatory = $true)]
        [string]$name,

        [int]$company_id,

        [int]$location_id,

        [int]$manager_id,

        [string]$notes,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    $Values = . Get-ParameterValue $MyInvocation.MyCommand.Parameters

    $Body = $Values | ConvertTo-Json;

    $Parameters = @{
        Uri    = "$url/api/v1/departments"
        Method = 'POST'
        Body   = $Body
        Token  = $apiKey
    }

    If ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
        $result = Invoke-SnipeitMethod @Parameters
    }

    $result
}

