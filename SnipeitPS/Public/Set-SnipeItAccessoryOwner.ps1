<#
    .SYNOPSIS
    Checkout accessory
    .DESCRIPTION
    Checkout accessory to user

    .PARAMETER id
    Unique ID  For accessory or array of IDs to checkout

    .PARAMETER assigned_id
    Id of target user

    .PARAMETER note
    Notes about checkout

    .PARAMETER url
    URL of Snipeit system, can be set using Set-SnipeItInfo command

    .PARAMETER apiKey
    User's API Key for Snipeit, can be set using Set-SnipeItInfo command

    .EXAMPLE
    Set-SnipeItAccessoryOwner -id 1 -assigned_id 1  -note "testing check out to user"
#>
function Set-SnipeItAccessoryOwner()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Medium"
    )]

    Param(
        [parameter(mandatory = $true,ValueFromPipelineByPropertyName)]
        [int[]]$id,

        [parameter(mandatory = $true)]
        [int]$assigned_to,

        [string] $note,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )
    begin{
        $Values = . Get-ParameterValue $MyInvocation.MyCommand.Parameters

        $Body = $Values | ConvertTo-Json;
    }

    process {
        foreach($accessory_id in $id){
            $Parameters = @{
                Uri    = "$url/api/v1/accessories/$accessory_id/checkout"
                Method = 'POST'
                Body   = $Body
                Token  = $apiKey
            }

            If ($PSCmdlet.ShouldProcess("ShouldProcess?"))
            {
                $result = Invoke-SnipeitMethod @Parameters
            }

            return $result
        }
    }
}
