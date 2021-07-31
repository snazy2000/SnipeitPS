<#
    .SYNOPSIS
    Removes department from Snipe-it asset system
    .DESCRIPTION
    Removes department or multiple departments from Snipe-it asset system
    .PARAMETER ID
    Unique ID For department to be removed
    .PARAMETER url
    URL of Snipeit system, can be set using Set-SnipeitInfo command

    .PARAMETER apiKey
    User's API Key for Snipeit, can be set using Set-SnipeitInfo command

    .EXAMPLE
    Remove-SnipeitDepartment -ID 44 -Verbose

    .EXAMPLE
    Get-SnipeitDepartment | Where-object {$_.name -like '*head*'} | Remove-SnipeitDepartment
#>

function Remove-SnipeitDepartment ()
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
        foreach($department_id in $id){
            $Parameters = @{
                Uri    = "$url/api/v1/departments/$department_id"
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
