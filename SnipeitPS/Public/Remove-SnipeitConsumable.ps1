<#
    .SYNOPSIS
    Removes consumable from Snipe-it asset system
    .DESCRIPTION
    Removes consumable or multiple consumables from Snipe-it asset system
    .PARAMETER ID
    Unique ID For consumable to be removed

    .PARAMETER url
    URL of Snipeit system, can be set using Set-SnipeitInfo command

    .PARAMETER apiKey
    User's API Key for Snipeit, can be set using Set-SnipeitInfo command

    .EXAMPLE
    Remove-SnipeitConsumable -ID 44 -Verbose

    .EXAMPLE
    Get-SnipeitConsumable -search "paper"  | Remove-Snipeitconsumable
#>

function Remove-SnipeitConsumable ()
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
        foreach($consumable_id in $id){
            $Parameters = @{
                Uri    = "$url/api/v1/consumables/$consumable_id"
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
