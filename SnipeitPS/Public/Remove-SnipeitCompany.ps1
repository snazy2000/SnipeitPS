<#
    .SYNOPSIS
    Removes Company from Snipe-it asset system
    .DESCRIPTION
    Removes Company or multiple Companies from Snipe-it asset system
    .PARAMETER ID
    Unique ID For Company to be removed
    .PARAMETER url
    URL of Snipeit system, can be set using Set-SnipeitInfo command

    .PARAMETER apiKey
    User's API Key for Snipeit, can be set using Set-SnipeitInfo command

    .EXAMPLE
    Remove-SnipeitCompany -ID 44 -Verbose

    .EXAMPLE
    Get-SnipeitCompany | | Where-object {$_.name -like '*some*'} | Remove-SnipeitCompany
#>

function Remove-SnipeitCompany ()
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
        foreach($company_id in $id){
            $Parameters = @{
                Uri    = "$url/api/v1/companies/$company_id"
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
