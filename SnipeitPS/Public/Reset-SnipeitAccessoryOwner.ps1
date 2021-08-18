<#
    .SYNOPSIS
    Checkin  accessories

    .DESCRIPTION
    Checkin  accessories

    .PARAMETER  assigned_pivot_id
    This is the assigned_pivot_id of the accessory+user relationships in the accessories_users table
    Use Get-SnipeitAccessoryOwner to find out nooded value

    .PARAMETER url
    Deprecated parameter, please use Connect-SnipeitPS instead. URL of Snipeit system.

    .PARAMETER apiKey
    Deprecated parameter, please use Connect-SnipeitPS instead. User's API Key for Snipeit.

       .EXAMPLE
    To get the accessories_users table for specific accessory id number

    Get-SnipeitAccessoryOwner -id 1

    Thenselect  assigned_pivot_id for userid you like check in

    Get-SnipeitAccessoryOwner -assigned_pivot_id xxx

#>
function Reset-SnipeitAccessoryOwner() {
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Medium"
    )]

    Param(
        [parameter(mandatory = $true)]
        [int]$assigned_pivot_id,

        [parameter(mandatory = $false)]
        [string]$url,

        [parameter(mandatory = $false)]
        [string]$apiKey
    )

    $Parameters = @{
        Api    = "/api/v1/accessories/$assigned_pivot_id/checkin"
        Method = 'Post'
        Body   = @{}
    }

    if ($PSBoundParameters.ContainsKey('apiKey')) {
        Write-Warning "-apiKey parameter is deprecated, please use Connect-SnipeitPS instead."
        Set-SnipeitPSSessionApiKey -apiKey $apikey
    }

    if ($PSBoundParameters.ContainsKey('url')) {
        Write-Warning "-url parameter is deprecated, please use Connect-SnipeitPS instead."
        Set-SnipeitPSSessionUrl -url $url
    }

    if ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
        $result = Invoke-SnipeitMethod @Parameters
    }

    return $result
}
