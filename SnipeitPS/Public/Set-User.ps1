<#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER id
    Parameter description

    .PARAMETER first_name
    Parameter description

    .PARAMETER last_name
    Parameter description

    .PARAMETER userName
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

    .PARAMETER activated
    Parameter description

    .PARAMETER notes
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
function Set-User() {

    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Medium"
    )]

    Param(
        [parameter(mandatory = $true)]
        [int]$id,

        [string]$first_name,

        [string]$last_name,

        [string]$userName,

        [string]$jobtitle,

        [string]$email,

        [string]$phone,

        [int]$company_id,

        [int]$location_id,

        [int]$department_id,

        [int]$manager_id,

        [string]$employee_num,

        [bool]$activated,

        [string]$notes,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    $Values = @{}

    #$exclude = @('id', 'url', 'apiKey')
    #$excludeRegex = [string]::Join('|', $exclude) # create the regex

    foreach ($psbp in $PSBoundParameters.GetEnumerator()) {
        #if ($psbp.Key -notmatch $excludeRegex) {
            $Values.Add($psbp.Key, $psbp.Value)
        #}
    }

    $Body = $Values | ConvertTo-Json;

    $Parameters = @{
        Uri    = "$url/api/v1/users/$id"
        Method = 'PATCH'
        Body   = $Body
        Token  = $apiKey
    }

    If ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
        $result = Invoke-SnipeitMethod @Parameters
    }

    $result
}
