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
    URL of Snipeit system, can be set using Set-SnipeItInfo command

    .PARAMETER apiKey
    User's API Key for Snipeit, can be set using Set-SnipeItInfo command

    .EXAMPLE
    Update-SnipeItUser -id 3 -fist_name It -lastname Snipe -username snipeit -activated $false -company_id 1 -location_id 1 -department_id 1
    Updates user with id 3

    .NOTES
    General notes
#>
function Set-SnipeItUser() {

    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Medium"
    )]

    Param(
        [parameter(mandatory = $true,ValueFromPipelineByPropertyName)]
        [int[]]$id,

        [string]$first_name,

        [string]$last_name,

        [string]$userName,

        [AllowEmptyString()]
        [string]$jobtitle,

        [AllowEmptyString()]
        [string]$email,

        [AllowEmptyString()]
        [string]$phone,

        [int]$company_id,

        [int]$location_id,

        [int]$department_id,

        [int]$manager_id,

        [AllowEmptyString()]
        [string]$employee_num,

        [bool]$activated,

        [AllowEmptyString()]
        [string]$notes,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )
    begin{
        Test-SnipeItAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

        $Values = . Get-ParameterValue $MyInvocation.MyCommand.Parameters

        $Body = $Values | ConvertTo-Json;
    }

    process{
        foreach($user_id in $id) {
            $Parameters = @{
                Uri    = "$url/api/v1/users/$user_id"
                Method = 'PATCH'
                Body   = $Body
                Token  = $apiKey
            }

            If ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
                $result = Invoke-SnipeitMethod @Parameters
            }

            $result
        }
    }
}
