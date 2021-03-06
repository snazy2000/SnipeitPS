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

    .PARAMETER password
    Password for user

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

    .PARAMETER image
    User Image file name and path

    .PARAMETER url
    URL of Snipeit system, can be set using Set-SnipeitInfo command

    .PARAMETER apiKey
    User's API Key for Snipeit, can be set using Set-SnipeitInfo command

    .EXAMPLE
    New-Snipeituser -fist_name It -lastname Snipe -username snipeit -activated $false -company_id 1 -location_id 1 -department_id 1
    Creates new a new user who can't login to system

    .NOTES
    General notes
#>
function New-SnipeitUser() {

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

        [ValidateScript({Test-Path $_})]
        [string]$image,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    Test-SnipeitAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

    $Values = . Get-ParameterValue -Parameters $MyInvocation.MyCommand.Parameters -BoundParameters $PSBoundParameters

    if ($password ) {
            $Values['password_confirmation'] = $password
    }

    $Parameters = @{
        Uri    = "$url/api/v1/users"
        Method = 'post'
        Body   = $Values
        Token  = $apiKey
    }

    If ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
        $result = Invoke-SnipeitMethod @Parameters
    }

    $result
}
