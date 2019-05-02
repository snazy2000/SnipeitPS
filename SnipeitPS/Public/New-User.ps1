<#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER firstName
    Parameter description

    .PARAMETER lastName
    Parameter description

    .PARAMETER userName
    Parameter description

    .PARAMETER jobTitle
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

    .PARAMETER ldap_user
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
function New-User() {

    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]

    Param(
        [parameter(mandatory = $true)]
        [string]$firstName,

        [parameter(mandatory = $true)]
        [string]$lastName,

        [parameter(mandatory = $true)]
        [string]$userName,

        [string]$password,

        [string]$jobTitle,

        [string]$email,

        [string]$phone,

        [int]$company_id,

        [int]$location_id,

        [int]$department_id,

        [int]$manager_id,

        [string]$employee_num,

        [bool]$ldap_user = $false,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    $Values = @{
        first_name    = $firstName
        last_name     = $lastName
        username      = $userName

        email         = $email
        phone         = $phone
        company_id    = $company_id
        location_id   = $location_id
        department_id = $department_id
        manager_id    = $manager_id
        jobtitle      = $jobTitle
        employee_num  = $employee_num
        notes         = "Imported using SnipeitPS Script"
        activated     = 1
    }

    if ($ldap_user -eq $false) {
        $ldap = @{
            password    = $password
            password_confirmation = $password
            ldap_import = 0
        }
        $Values += $ldap
    }
    else {
        $ldap = @{
            ldap_import = 1
        }
        $Values += $ldap
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
