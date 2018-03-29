<#
.SYNOPSIS
# Gets a list of Snipe-it Users

.PARAMETER url
URL of Snipeit system, can be set using Set-Info command

.PARAMETER apiKey
Users API Key for Snipeit, can be set using Set-Info command

.EXAMPLE
Get-User -url "https://assets.example.com" -token "token..."

.EXAMPLE
Get-User -url "https://assets.example.com" -token "token..." | Where-Object {$_.username -eq "stephenm" }

#>
function Get-User()
{
    Param(
        [string]$search,

        [parameter(mandatory=$true)]
        [string]$url,

        [parameter(mandatory=$true)]
        [string]$apiKey
    )

    $Parameters = @{
        Uri           = "$url/api/v1/users"
        Method        = 'Get'
        GetParameters = @{
            search = $search
            limit  = 999
        }
        Token         = $apiKey
    }

    $result = Invoke-SnipeitMethod @Parameters

    $result
}
