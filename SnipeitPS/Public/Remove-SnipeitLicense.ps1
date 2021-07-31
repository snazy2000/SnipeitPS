<#
    .SYNOPSIS
    Removes licence from Snipe-it asset system
    .DESCRIPTION
    Removes licence or multiple licenses from Snipe-it asset system
    .PARAMETER ID
    Unique ID For licence to be removed
    .PARAMETER url
    URL of Snipeit system, can be set using Set-SnipeitInfo command

    .PARAMETER apiKey
    User's API Key for Snipeit, can be set using Set-SnipeitInfo command

    .EXAMPLE
    Remove-SnipeitLicence -ID 44 -Verbose

    .EXAMPLE
    Get-SnipeitLicence -product_key 123456789  | Remove-SnipeitLicense
#>

function Remove-SnipeitLicense ()
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
        foreach($license_id in $id){
            $Parameters = @{
                Uri    = "$url/api/v1/licenses/$license_id"
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
