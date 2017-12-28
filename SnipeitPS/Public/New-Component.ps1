<#
    .SYNOPSIS
    Short description

    .DESCRIPTION
    Long description

    .PARAMETER name
    Parameter description

    .PARAMETER category_id
    Parameter description

    .PARAMETER qty
    Parameter description

    .PARAMETER url
    Parameter description

    .PARAMETER apiKey
    Parameter description

    .EXAMPLE
    An example

    .NOTES
    General notes
#>

function New-Component()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "High"
    )]

    Param(
        [parameter(mandatory = $true)]
        [string]$name,

        [parameter(mandatory = $true)]
        [string]$category_id,

        [parameter(mandatory = $true)]
        [string]$qty,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    $Values = @{
        "name"        = $name
        "category_id" = $category_id
        "qty"         = $qty
    }

    $Body = $Values | ConvertTo-Json;

    $Parameters = @{
        Uri    = "$url/api/v1/components"
        Method = 'POST'
        Body   = $Body
        Token  = $apiKey
    }

    If ($PSCmdlet.ShouldProcess("ShouldProcess?"))
    {
        $result = Invoke-SnipeitMethod @Parameters
    }

    $result
}

