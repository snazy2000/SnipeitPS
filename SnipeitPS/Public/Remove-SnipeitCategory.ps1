<#
    .SYNOPSIS
    Removes category from Snipe-it asset system
    .DESCRIPTION
    Removes category or multiple categories from Snipe-it asset system
    .PARAMETER ID
    Unique ID For categoryto be removed
    .PARAMETER url
    URL of Snipeit system, can be set using Set-SnipeitInfo command

    .PARAMETER apiKey
    User's API Key for Snipeit, can be set using Set-SnipeitInfo command

    .EXAMPLE
    Remove-SnipeitCategory -ID 44 -Verbose

    .EXAMPLE
    Get-SnipeitCategory -search something  | Remove-SnipeitCategory
#>

function Remove-SnipeitCategory ()
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
        foreach($category_id in $id){
            $Parameters = @{
                Uri    = "$url/api/v1/categories/$category_id"
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
