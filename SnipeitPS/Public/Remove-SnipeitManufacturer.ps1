<#
    .SYNOPSIS
    Removes manufacturer from Snipe-it asset system
    .DESCRIPTION
    Removes manufacturer or multiple manufacturers from Snipe-it asset system
    .PARAMETER ID
    Unique ID For manufacturer to be removed
    .PARAMETER url
    URL of Snipeit system, can be set using Set-SnipeitInfo command

    .PARAMETER apiKey
    User's API Key for Snipeit, can be set using Set-SnipeitInfo command

    .EXAMPLE
    Remove-SnipeitManufacturer -ID 44 -Verbose

    .EXAMPLE
    Get-SnipeitManufacturer | Where-object {$_.name -like '*something*'}  | Remove-SnipeitManufacturer
#>

function Remove-SnipeitManufacturer ()
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
    }

    process {
        foreach($manufacturer_id in $id){
            $Parameters = @{
                Uri    = "$url/api/v1/manufacturers/$manufacturer_id"
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
