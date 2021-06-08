<#
.SYNOPSIS
Returns a fieldset or list of Snipe-it Fieldsets

.PARAMETER id
A id of specific fieldset

.PARAMETER url
URL of Snipeit system, can be set using Set-SnipeItInfo command

.PARAMETER apiKey
Users API Key for Snipeit, can be set using Set-SnipeItInfo command

.EXAMPLE
Get-SnipeItFieldset -url "https://assets.example.com" -token "token..."

.EXAMPLE
Get-SnipeItFieldset -url "https://assets.example.com" -token "token..." | Where-Object {$_.name -eq "Windows" }

#>

function Get-SnipeItFieldset() {
    Param(
        [int]$id,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    Test-SnipeItAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

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
