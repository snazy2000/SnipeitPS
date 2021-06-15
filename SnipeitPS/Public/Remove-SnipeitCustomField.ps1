<#
    .SYNOPSIS
    Removes custom field from Snipe-it asset system
    .DESCRIPTION
    Removes custom field or multiple fields from Snipe-it asset system
    .PARAMETER ID
    Unique ID For field to be removed
    .PARAMETER url
    URL of Snipeit system, can be set using Set-SnipeitInfo command

    .PARAMETER apiKey
    User's API Key for Snipeit, can be set using Set-SnipeitInfo command

    .EXAMPLE
    Remove-SnipeitCustomField -ID 44 -Verbose

    .EXAMPLE
    Get-SnipeitCustomField | Where-object {$_.name -like '*address*'}  | Remove-SnipeitCustomField
#>

function Remove-SnipeitCustomField ()
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
        foreach($field_id in $id){
            $Parameters = @{
                Uri    = "$url/api/v1/fields/$field_id"
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
