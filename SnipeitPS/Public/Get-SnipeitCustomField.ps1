<#
    .SYNOPSIS
    Returns specific Snipe-IT custom field or a list of all custom field

    .PARAMETER id
    A id of specific field

    .PARAMETER url
    Deprecated parameter, please use Connect-SnipeitPS instead. URL of Snipeit system.

    .PARAMETER apiKey
    Deprecated parameter, please use Connect-SnipeitPS instead. Users API Key for Snipeit.

    .EXAMPLE
    Get-SnipeitCustomField
    Get all custom fields

    .EXAMPLE
    Get-SnipeitCustomField -id 1
    Get custom field with ID 1


#>

function Get-SnipeitCustomField() {
    Param(
        [int]$id,

        [parameter(mandatory = $false)]
        [string]$url,

        [parameter(mandatory = $false)]
        [string]$apiKey
    )

    Test-SnipeitAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

    if ($id) {
        $api= "/api/v1/fields/$id"
    } else {
        $api = "/api/v1/fields"
    }

    $Parameters = @{
        Api           = $api
        Method        = 'Get'
     }

     if ($PSBoundParameters.ContainsKey('apiKey')) {
        Write-Warning "-apiKey parameter is deprecated, please use Connect-SnipeitPS instead."
        Set-SnipeitPSSessionApiKey -apiKey $apikey
    }

    if ($PSBoundParameters.ContainsKey('url')) {
        Write-Warning "-url parameter is deprecated, please use Connect-SnipeitPS instead."
        Set-SnipeitPSSessionApiKey -url $url
    }



    $result = Invoke-SnipeitMethod @Parameters

    $result
}
