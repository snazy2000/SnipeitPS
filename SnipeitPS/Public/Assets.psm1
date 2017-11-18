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

function New-Asset()
{
    [CmdletBinding(
        SupportsShouldProcess=$true,
        ConfirmImpact="High"
    )]

    Param(
        [parameter(mandatory=$true)]
        [string]$Name,

        [parameter(mandatory=$true)]
        [string]$Status_id,

        [parameter(mandatory=$true)]
        [string]$Model_id,

        [parameter(mandatory=$true)]
        [string]$url,

        [parameter(mandatory=$true)]
        [string]$apiKey,

        [hashtable] $customfields
    )

    $Values = @{
        "name" = $Name
        "status_id" = $status_id
        "model_id" = $model_id
    }

    $Values += $customfields

    $Body = $Values | ConvertTo-Json;

    $Parameters = @{
            Uri        = "$url/api/v1/hardware"
            Method     = 'Post'
            Body       = $Body
            Token      = $apiKey
        }

    If ($PSCmdlet.ShouldProcess()) {
        $result = Invoke-Method @Parameters
    }

    $result
}

function Set-Asset()
{
    [CmdletBinding(
        SupportsShouldProcess=$true,
        ConfirmImpact="High"
    )]

    Param(
        [parameter(mandatory=$true)]
        [int]$id,

        [parameter(mandatory=$true)]
        [string]$Name,

        [parameter(mandatory=$true)]
        [string]$Status_id,

        [parameter(mandatory=$true)]
        [string]$Model_id,

        [parameter(mandatory=$true)]
        [string]$url,

        [parameter(mandatory=$true)]
        [string]$apiKey,

        [hashtable] $customfields
    )

    $Values = @{
        "name" = $Name
        "status_id" = $status_id
        "model_id" = $model_id
    }

    $Values += $customfields
    $Body = $Values | ConvertTo-Json;

    $Parameters = @{
            Uri        = "$url/api/v1/hardware/$id"
            Method     = 'Put'
            Body       = $Body
            Token      = $apiKey
        }

    If ($PSCmdlet.ShouldProcess()) {
        $result = Invoke-Method @Parameters
    }

    $result
}

function Set-AssetOwner()
{
    [CmdletBinding(
        SupportsShouldProcess=$true,
        ConfirmImpact="High"
    )]

    Param(
        [parameter(mandatory=$true)]
        [int]$id,

        [parameter(mandatory=$true)]
        [int]$user_id,

        [parameter(mandatory=$true)]
        [string]$url,

        [parameter(mandatory=$true)]
        [string]$apiKey
    )

    $Values = @{
        "user_id" = $user_id
    }

    $Body = $Values | ConvertTo-Json;

    $Parameters = @{
            Uri        = "$url/api/v1/hardware/$id/checkout"
            Method     = 'POST'
            Body       = $Body
            Token      = $apiKey
        }

    If ($PSCmdlet.ShouldProcess()) {
        $result = Invoke-Method @Parameters
    }

    return $result
}
