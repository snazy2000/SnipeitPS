<#
    .SYNOPSIS
    Creates a new user

    .PARAMETER id
    ID number of Snipe--It user or array of IDs

    .DESCRIPTION
    Creates a new user to Snipe-IT system

    .PARAMETER first_name
    Users first name

    .PARAMETER last_name
    Users last name

    .PARAMETER username
    Username for user

    .PARAMETER activated
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

    .PARAMETER url
    URL of Snipeit system, can be set using Set-SnipeitInfo command

    .PARAMETER apiKey
    User's API Key for Snipeit, can be set using Set-SnipeitInfo command

    .EXAMPLE
    Update-SnipeitUser -id 3 -fist_name It -lastname Snipe -username snipeit -activated $false -company_id 1 -location_id 1 -department_id 1
    Updates user with id 3

    .NOTES
    General notes
#>
function Set-SnipeitUser() {

    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Medium"
    )]

    Param(
        [parameter(mandatory = $true,ValueFromPipelineByPropertyName)]
        [int[]]$id,

        [ValidateLength(1,256)]
        [string]$first_name,

        [string]$last_name,

        [ValidateLength(1,256)]
        [string]$userName,

        [string]$jobtitle,

        [string]$email,

        [string]$phone,

        [string]$password,

        [Nullable[System.Int32]]$company_id,

        [Nullable[System.Int32]]$location_id,

        [Nullable[System.Int32]]$department_id,

        [Nullable[System.Int32]]$manager_id,

        [string]$employee_num,

        [bool]$activated,

        [string]$notes,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )
    begin{
        Test-SnipeitAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

        $Values = . Get-ParameterValue -Parameters $MyInvocation.MyCommand.Parameters -BoundParameters $PSBoundParameters

        if ($password) {
            $Values['password_confirmation'] = $password
        }

    }

    process{
        foreach($user_id in $id) {
            $Parameters = @{
                Uri    = "$url/api/v1/users/$user_id"
                Method = 'PATCH'
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
