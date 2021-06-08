<#
    .SYNOPSIS
    Get list of checked out accessories
    .DESCRIPTION
    Get list of checked out accessories

    .PARAMETER id
    Unique ID For accessory to list

    .PARAMETER url
    URL of Snipeit system, can be set using Set-SnipeitInfo command

    .PARAMETER apiKey
    User's API Key for Snipeit, can be set using Set-SnipeitInfo command

    .EXAMPLE
    Get-SnipeitAccessoryOwner -id 1
#>
function Get-SnipeitAccessoryOwner()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Medium"
    )]

    Param(
        [parameter(mandatory = $true)]
        [int]$id,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    $Parameters = @{
        Uri    = "$url/api/v1/accessories/$id/checkedout"
        Method = 'GET'
        Token  = $apiKey
    }

    If ($PSCmdlet.ShouldProcess("ShouldProcess?"))
    {
        $result = Invoke-SnipeitMethod @Parameters
    }

    return $result
}
