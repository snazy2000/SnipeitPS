<#
    .SYNOPSIS
    Removes Asset from Snipe-it asset system
    .DESCRIPTION
    Removes asset or multiple assets from Snipe-it asset system
    .PARAMETER ID
    Unique ID For Asset to be removed
    .PARAMETER url
    URL of Snipeit system, can be set using Set-SnipeitInfo command

    .PARAMETER apiKey
    User's API Key for Snipeit, can be set using Set-SnipeitInfo command

    .EXAMPLE
    Remove-SnipeitAsset -ID 44 -Verbose

    .EXAMPLE
    Get-SnipeitAsset -serial 123456789  | Remove-SnipeitAsset
#>

function Remove-SnipeitAsset ()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]

    Param(
        [parameter(mandatory = $true,ValueFromPipelineByPropertyName)]
        [int[]]$id,

        [parameter(mandatory = $false)]
        [string]$url,

        [parameter(mandatory = $false)]
        [string]$apiKey
    )

    begin {
        Test-SnipeitAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name
    }

    process {
        foreach($asset_id in $id){
            $Parameters = @{
                Uri    = "$url/api/v1/hardware/$asset_id"
                Method = 'Delete'
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
