<#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER name
    Parameter description

    .PARAMETER category_id
    Parameter description

    .PARAMETER qty
    Parameter description

    .PARAMETER url
    Parameter description

    .PARAMETER apiKey
    Parameter description

    .EXAMPLE
    An example

    .NOTES
    General notes
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

    $Values = . Get-ParameterValue

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

