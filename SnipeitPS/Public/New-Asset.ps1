<#
    .SYNOPSIS
    Add a new Asset to Snipe-it asset system

    .DESCRIPTION
    Long description

    .PARAMETER Tag
    Asset Tag for the Asset

    .PARAMETER Name
    Name of the Asset

    .PARAMETER Status_id
    Status ID of the asset, this can be got using Get-Status

    .PARAMETER Model_id
    Model ID of the asset, this can be got using Get-Model

    .PARAMETER url
    URL of Snipeit system, can be set using Set-Info command

    .PARAMETER apiKey
    Users API Key for Snipeit, can be set using Set-Info command

    .PARAMETER customfields
    Hastable of custom fields and extra fields that need passing through to Snipeit

    .EXAMPLE
    New-Asset -status_id 1 -model_id 1 -name "Machine1"

    .EXAMPLE
    New-Asset -status_id 1 -model_id 1 -name "Machine1" -CustomValues = @{ "_snipeit_os_5 = "Windows 10 Pro" }
#>

function New-Asset()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "High"
    )]

    Param(
        [string]$tag,

        [parameter(mandatory = $true)]
        [string]$Name,

        [parameter(mandatory = $true)]
        [string]$Status_id,

        [parameter(mandatory = $true)]
        [string]$Model_id,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey,

        [hashtable] $customfields
    )

    $Values = @{
        "name"      = $Name
        "status_id" = $status_id
        "model_id"  = $model_id
    }

    if ($PSBoundParameters.ContainsKey('tag'))
    {
        $Values += @{"asset_tag" = $tag}
    }

    if ($customfields)
    {
        $Values += $customfields
    }

    $Body = $Values | ConvertTo-Json;

    $Parameters = @{
        Uri    = "$url/api/v1/hardware"
        Method = 'Post'
        Body   = $Body
        Token  = $apiKey
    }

    If ($PSCmdlet.ShouldProcess("ShouldProcess?"))
    {
        $result = Invoke-SnipeitMethod @Parameters
    }

    $result
}
