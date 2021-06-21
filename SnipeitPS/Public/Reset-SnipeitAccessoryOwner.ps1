<#
    .SYNOPSIS
    Checkin  accessories

    .DESCRIPTION
    Checkin  accessories

    .PARAMETER  assigned_pivot_id
    This is the assigned_pivot_id of the accessory+user relationships in the accessories_users table
    Use Get-SnipeitAccessoryOwner to find out nooded value

    .PARAMETER url
    URL of Snipeit system, can be set using Set-SnipeitInfo command

    .PARAMETER apiKey
    User's API Key for Snipeit, can be set using Set-SnipeitInfo command

       .EXAMPLE
    To get the accessories_users table for specific accessory id number

    Get-SnipeitAccessoryOwner -id 1

    Thenselect  assigned_pivot_id for userid you like check in

    Get-SnipeitAccessoryOwner -assigned_pivot_id xxx

#>
function Reset-SnipeitAccessoryOwner()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Medium"
    )]

    Param(
        [parameter(mandatory = $true)]
        [int]$assigned_pivot_id,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    $Parameters = @{
        Uri    = "$url/api/v1/accessories/$assigned_pivot_id/checkin"
        Method = 'Post'
        Body   = @{}
        Token  = $apiKey
    }

    If ($PSCmdlet.ShouldProcess("ShouldProcess?"))
    {
        $result = Invoke-SnipeitMethod @Parameters
    }

    return $result
}
