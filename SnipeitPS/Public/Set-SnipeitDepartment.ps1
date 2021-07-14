<#
    .SYNOPSIS
    Updates a department

    .DESCRIPTION
    Updates the department on Snipe-It system

    .PARAMETER id
    Id number of Department

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

    .PARAMETER RequestType
    Http request type to send Snipe IT system. Defaults to Patch you could use Put if needed.

    .PARAMETER url
    URL of Snipeit system, can be set using Set-SnipeitInfo command

    .PARAMETER apiKey
    Users API Key for Snipeit, can be set using Set-SnipeitInfo command

    .EXAMPLE
    Set-SnipeitDepartment -id 4  -manager_id 3

#>

function Set-SnipeitDepartment() {
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]

    Param(
        [parameter(mandatory = $true,ValueFromPipelineByPropertyName)]
        [int[]]$id,

        [string]$name,

        [Nullable[System.Int32]]$company_id,

        [Nullable[System.Int32]]$location_id,

        [Nullable[System.Int32]]$manager_id,

        [string]$notes,

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

    begin {

        $Values = . Get-ParameterValue -Parameters $MyInvocation.MyCommand.Parameters -BoundParameters $PSBoundParameters
    }

    process {
        foreach ($department_id in $id) {
            $Parameters = @{
                Uri    = "$url/api/v1/departments/$department_id"
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

