<#
.SYNOPSIS
# Gets a list of Snipe-it Users

.PARAMETER url
URL of Snipeit system, can be set using Set-Info command

.PARAMETER apiKey
Users API Key for Snipeit, can be set using Set-Info command

.EXAMPLE
Get-Users -url "https://assets.dip.co.uk" -token "token..."

.EXAMPLE
Get-Users -url "https://assets.dip.co.uk" -token "token..." | Where-Object {$_.username -eq "stephenm" }

#>
function Get-User()
{
    Param(
        [parameter(mandatory=$true)]
        [string]$url,

        [parameter(mandatory=$true)]
        [string]$apiKey
    )

    $result = Invoke-Method -URi "$url/api/v1/users?limit=999" `
                  -Method GET `
                  -Token $apiKey

    $result
}
