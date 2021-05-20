<#
    .SYNOPSIS
    Creates a new user

    .DESCRIPTION
    Creates a new user to Snipe-IT system

    .PARAMETER first_name
    Users first name

    .PARAMETER last_name
    Users last name

    .PARAMETER username
    Username for user

    .PARAMETER active
    Can user log in to snipe-it?

    .PARAMETER notes
    User Notes

    .PARAMETER jobtitle
    Users job tittle

    .PARAMETER email
    email address

    .PARAMETER phone
    Phone number

    .PARAMETER company_id
    ID number of company users belogs to

    .PARAMETER location_id
    ID number of localtion

    .PARAMETER department_id
    ID number of department

    .PARAMETER manager_id
    ID number of manager

    .PARAMETER employee_num
    Employeenumber

    .PARAMETER ldap_import
    Mark user as import from ldap

    .PARAMETER url
    URL of Snipeit system, can be set using Set-Info command

    .PARAMETER apiKey
    User's API Key for Snipeit, can be set using Set-Info command

    .EXAMPLE
    New-user -fist_name It -lastname Snipe -username snipeit -activated $false -company_id 1 -location_id 1 -department_id 1
    Creates new a new user who can't login to system

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
        [alias('firstName')]
        [string]$first_name,

        [parameter(mandatory = $true)]
        [alias('lastName')]
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
        [alias('ldap_user')]
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
