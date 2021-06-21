<#
    .SYNOPSIS
    Removes Asset model from Snipe-it asset system
    .DESCRIPTION
    Removes asset model or multiple assets models from Snipe-it asset system
    .PARAMETER ID
    Unique ID For Model to be removed
    .PARAMETER url
    URL of Snipeit system, can be set using Set-SnipeitInfo command

    .PARAMETER apiKey
    User's API Key for Snipeit, can be set using Set-SnipeitInfo command

    .EXAMPLE
    Remove-SnipeitModel -ID 44 -Verbose

    .EXAMPLE
    Get-SnipeitModel -search needle  | Remove-SnipeitModel
#>

function Remove-SnipeitModel ()
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
        foreach($model_id in $id){
            $Parameters = @{
                Uri    = "$url/api/v1/models/$model_id"
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
