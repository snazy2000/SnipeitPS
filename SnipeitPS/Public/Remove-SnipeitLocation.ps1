<#
    .SYNOPSIS
    Removes Location from Snipe-it asset system
    .DESCRIPTION
    Removes localtion or multiple locations from Snipe-it asset system
    .PARAMETER ID
    Unique ID For location to be removed
    .PARAMETER url
    URL of Snipeit system, can be set using Set-SnipeitInfo command

    .PARAMETER apiKey
    User's API Key for Snipeit, can be set using Set-SnipeitInfo command

    .EXAMPLE
    Remove-SnipeitLocation -ID 44 -Verbose

    .EXAMPLE
    Get-SnipeitLocation -city Arkham  | Remove-SnipeitLocation
#>

function Remove-SnipeitLocation ()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]

    Param(
    [parameter(mandatory = $true,ValueFromPipelineByPropertyName)]
        [int[]]$id,
    [parameter(mandatory = $true)]
        [string]$URL,
    [parameter(mandatory = $true)]
        [string]$APIKey

    )
    begin {
    }
    process {
        foreach($location_id in $id){
            $Parameters = @{
                Uri    = "$url/api/v1/locations/$asset_id"
                Method = 'Delete'
                Body   = '@{}'
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
