<#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER first_name
    Parameter description

    .PARAMETER last_name
    Parameter description

    .PARAMETER username
    Parameter description

    .PARAMETER active
    Parameter description

    .PARAMETER notes
    Parameter description

    .PARAMETER jobtitle
    Parameter description

    .PARAMETER email
    Parameter description

    .PARAMETER phone
    Parameter description

    .PARAMETER company_id
    Parameter description

    .PARAMETER location_id
    Parameter description

    .PARAMETER department_id
    Parameter description

    .PARAMETER manager_id
    Parameter description

    .PARAMETER employee_num
    Parameter description

    .PARAMETER ldap_import
    Mark user as import from ldap

    .PARAMETER url
    Parameter description

    .PARAMETER apiKey
    Parameter description

    .EXAMPLE
    An example

    .NOTES
    General notes
    #>
function New-User() {

    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]

    Param(
        [parameter(mandatory = $true)]
        [string]$first_name,

        [parameter(mandatory = $true)]
        [string]$last_name,

        [parameter(mandatory = $true)]
        [string]$username,

        [string]$password,

        [bool]$activated = $false,

        [string]$notes,

        [string]$jobtitle,

        [string]$email,

        [string]$phone,

        [int]$company_id,

        [int]$location_id,

        [int]$department_id,

        [int]$manager_id,

        [string]$employee_num,

        [bool]$ldap_import = $false,


        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    $Values = . Get-ParameterValue $MyInvocation.MyCommand.Parameters

    if ($password ) {
            $Values['password_confirmation'] = $password
    }

    $Body = $Values | ConvertTo-Json;

    $Parameters = @{
        Uri    = "$url/api/v1/users"
        Method = 'post'
        Body   = $Body
        Token  = $apiKey
    }

    If ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
        $result = Invoke-SnipeitMethod @Parameters
    }

    $result
}
