function Remove-SnipeitAssetMaintenance {
    <#
        .SYNOPSIS
        Remove asset maintenance from Snipe-it asset system
        .DESCRIPTION
        Removes asset maintenance event or events from Snipe-it asset system by ID
        .PARAMETER ID
        Unique ID of the asset maintenance to be removed
        .PARAMETER url
        URL of Snipeit system, can be set using Set-SnipeitInfoeItInfo command

        .PARAMETER apiKey
        User's API Key for Snipeit, can be set using Set-SnipeitInfo command

        .EXAMPLE
        Remove-SnipeitAssetMaintenance -ID 44 -url $url -apiKey $secret -Verbose
    #>
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]
    param (
        # Asset maintenance ID
        [Parameter(Mandatory = $true,ValueFromPipelineByPropertyName)]
        [int[]]
        $id,

        # Snipeit URL
        [Parameter(Mandatory = $true)]
        [string]
        $url,

        # Snipeit ApiKey
        [Parameter(Mandatory = $true)]
        [string]
        $apiKey
    )
    begin {
        Test-SnipeitAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name
    }
    process {
        foreach($maintenance_id in $id){
            $Parameters = @{
                Uri    = "$url/api/v1/maintenances/$maintenance_id"
                Method = 'Delete'
                Body   = '{}'
                Token  = $apiKey
            }

            If ($PSCmdlet.ShouldProcess("ShouldProcess?"))
            {
                $result = Invoke-SnipeitMethod @Parameters
            }

            $result
        }
    }
}
