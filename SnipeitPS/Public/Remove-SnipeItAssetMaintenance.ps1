function Remove-SnipeItAssetMaintenance {
    <#
        .SYNOPSIS
        Remove asset maintenance from Snipe-it asset system
        .DESCRIPTION
        Removes asset maintenance event from Snipe-it asset system by ID
        .PARAMETER ID
        Unique ID of the asset maintenance to be removed
        .PARAMETER url
        URL of Snipeit system, can be set using Set-SnipeItInfoeItInfo command

        .PARAMETER apiKey
        User's API Key for Snipeit, can be set using Set-SnipeItInfo command

        .EXAMPLE
        Remove-AssetMaintenance -ID 44 -url $url -apiKey $secret -Verbose
    #>
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]
    param (
        # Asset maintenance ID
        [Parameter(Mandatory = $true)]
        [int]
        $ID,

        # SnipeIt URL
        [Parameter(Mandatory = $true)]
        [string]
        $url,

        # SnipeIt ApiKey
        [Parameter(Mandatory = $true)]
        [string]
        $apiKey
    )

    $Values = @{
        "ID"      = $ID
    }

    $Body = $Values | ConvertTo-Json

    $Parameters = @{
        Uri    = "$url/api/v1/maintenances/$ID"
        Method = 'Delete'
        Body   = $Body
        Token  = $apiKey
    }

        If ($PSCmdlet.ShouldProcess("ShouldProcess?"))
    {
        $result = Invoke-SnipeitMethod @Parameters
    }

    $result
}
