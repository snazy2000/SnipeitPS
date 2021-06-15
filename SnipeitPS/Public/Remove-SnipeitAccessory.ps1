<#
    .SYNOPSIS
    Removes Accessory from Snipe-it asset system
    .DESCRIPTION
    Removes Accessory or multiple Accessoriers from Snipe-it asset system
    .PARAMETER ID
    Unique ID For accessory to be removed
    .PARAMETER url
    URL of Snipeit system, can be set using Set-SnipeitInfo command

    .PARAMETER apiKey
    User's API Key for Snipeit, can be set using Set-SnipeitInfo command

    .EXAMPLE
    Remove-SnipeitAccessory -ID 44 -Verbose

    .EXAMPLE
    Get-SnipeitAccessory -search needle  | Remove-SnipeitAccessory
#>

function Remove-SnipeitAccessory ()
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
        foreach($accessory_id in $id){
            $Parameters = @{
                Uri    = "$url/api/v1/accessories/$accessory_id"
                Method = 'Delete'
                Body   = @{}
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
