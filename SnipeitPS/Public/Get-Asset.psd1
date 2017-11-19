<#
.SYNOPSIS
# Gets a list of Snipe-it Assets

.PARAMETER url
URL of Snipeit system, can be set using Set-Info command

.PARAMETER apiKey
Users API Key for Snipeit, can be set using Set-Info command

.EXAMPLE
Get-Asset -url "https://assets.dip.co.uk" -token "token..."

.EXAMPLE
Get-Asset -url "https://assets.dip.co.uk" -token "token..." | Where-Object {$_.name -eq "SUPPORT23" }

#>

function Get-Asset()
{
    Param(
        [parameter(mandatory=$true)]
        [string]$url,

        [parameter(mandatory=$true)]
        [string]$apiKey
    )

    $result = Invoke-Method -URi "$url/api/v1/hardware" `
                  -Method GET `
                  -Token $apiKey

    $result
}






