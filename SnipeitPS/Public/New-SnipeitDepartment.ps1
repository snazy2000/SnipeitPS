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

    .PARAMETER image
    Image file name and path for item

    .PARAMETER image_delete
    Remove current image

    .PARAMETER url
    URL of Snipeit system, can be set using Set-SnipeitInfo command

    .PARAMETER apiKey
    Users API Key for Snipeit, can be set using Set-SnipeitInfo command

    .EXAMPLE
    New-SnipeitDepartment -name "Department1" -company_id 1 -localtion_id 1 -manager_id 3

#>

function New-SnipeitDepartment() {
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

        [ValidateScript({Test-Path $_})]
        [string]$image,

        [switch]$image_delete=$false,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    Test-SnipeitAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

    $Values = . Get-ParameterValue -Parameters $MyInvocation.MyCommand.Parameters -BoundParameters $PSBoundParameters

    $Parameters = @{
        Uri    = "$url/api/v1/departments"
        Method = 'POST'
        Body   = $Values
        Token  = $apiKey
    }

    If ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
        $result = Invoke-SnipeitMethod @Parameters
    }

    $result
}

