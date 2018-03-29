<#
.SYNOPSIS
# Gets a list of Snipe-it Departments

.PARAMETER url
URL of Snipeit system, can be set using Set-Info command

.PARAMETER apiKey
Users API Key for Snipeit, can be set using Set-Info command

.EXAMPLE
Get-Department -url "https://assets.example.com" -token "token..."

.EXAMPLE
Get-Department -url "https://assets.example.com" -token "token..." | Where-Object {$_.name -eq "Department1" }

#>

function Get-Department()
{
    Param(
        [string]$search,

        [parameter(mandatory=$true)]
        [string]$url,

        [parameter(mandatory=$true)]
        [string]$apiKey
    )

    $Parameters = @{
        Uri           = "$url/api/v1/departments"
        Method        = 'Get'
        Token         = $apiKey
        GetParameters = @{
            search = $search
            limit  = 999
        }
    }

    $result = Invoke-SnipeitMethod @Parameters

    $result
}

