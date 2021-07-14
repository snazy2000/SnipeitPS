<#
    .SYNOPSIS
    Removes component from Snipe-it asset system
    .DESCRIPTION
    Removes component or multiple components from Snipe-it asset system
    .PARAMETER IDs
    Unique ID For component to be removed
    .PARAMETER url
    URL of Snipeit system, can be set using Set-SnipeitInfo command

    .PARAMETER apiKey
    User's API Key for Snipeit, can be set using Set-SnipeitInfo command

    .EXAMPLE
    Remove-SnipeitComponent -ID 44 -Verbose

    .EXAMPLE
    Get-SnipeitComponent -search 123456789  | Remove-SnipeitComponent
#>

function Remove-SnipeitComponent ()
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
        foreach($component_id in $id){
            $Parameters = @{
                Uri    = "$url/api/v1/components/$component_id"
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
