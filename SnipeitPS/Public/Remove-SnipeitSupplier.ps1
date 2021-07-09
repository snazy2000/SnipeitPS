<#
    .SYNOPSIS
    Removes supplier from Snipe-it asset system
    .DESCRIPTION
    Removes supplier or multiple manufacturers from Snipe-it asset system
    .PARAMETER ID
    Unique ID For supplier to be removed
    .PARAMETER url
    URL of Snipeit system, can be set using Set-SnipeitInfo command

    .PARAMETER apiKey
    User's API Key for Snipeit, can be set using Set-SnipeitInfo command

    .EXAMPLE
    Remove-SnipeitSupplier -ID 44

    .EXAMPLE
    Get-SnipeitSupplier | Where-object {$_.name -like '*something*'}  | Remove-SnipeitSupplier
#>

function Remove-SnipeitSupplier ()
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
        foreach($suppliers_id in $id){
            $Parameters = @{
                Uri    = "$url/api/v1/suppliers/$supplier_id"
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
