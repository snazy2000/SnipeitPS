<#
.SYNOPSIS
Returns a fieldset or list of Snipe-it Fieldsets

.PARAMETER id
A id of specific fieldset

.PARAMETER url
URL of Snipeit system, can be set using Set-SnipeitInfo command

.PARAMETER apiKey
Users API Key for Snipeit, can be set using Set-SnipeitInfo command

.EXAMPLE
Get-SnipeitFieldset -url "https://assets.example.com" -token "token..."

.EXAMPLE
Get-SnipeitFieldset -url "https://assets.example.com" -token "token..." | Where-Object {$_.name -eq "Windows" }

#>

function Get-SnipeitFieldset() {
    Param(
        [int]$id,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    Test-SnipeitAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

    if ($id) {
        $apiurl = "$url/api/v1/fieldsets/$id"
    } else {
        $apiurl = "$url/api/v1/fieldsets"
    }

    $Parameters = @{
        Uri           = $apiurl
        Method        = 'Get'
        Token         = $apiKey
    }

    $result = Invoke-SnipeitMethod @Parameters

    $result
}
