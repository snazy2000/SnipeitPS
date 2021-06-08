<#
    .SYNOPSIS
    Returns specific Snipe-IT custom field or a list of all custom field

    .PARAMETER id
    A id of specific field

    .PARAMETER url
    URL of Snipeit system, can be set using Set-SnipeitInfo command

    .PARAMETER apiKey
    Users API Key for Snipeit, can be set using Set-SnipeitInfo command

    .EXAMPLE
    Get-SnipeitCustomField -url "https://assets.example.com" -token "token..."

#>

function Get-SnipeitCustomField()
{
    Param(
        [int]$id,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    Test-SnipeitAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

    if ($id) {
        $apiurl= "$url/api/v1/fields/$id"
    } else {
        $apiurl = "$url/api/v1/fields"
    }

    $Parameters = @{
        Uri           = $apiurl
        Method        = 'Get'
        Token         = $apiKey
    }


    $result = Invoke-SnipeitMethod @Parameters

    $result
}
