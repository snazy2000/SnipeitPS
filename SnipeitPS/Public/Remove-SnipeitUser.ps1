<#
    .SYNOPSIS
    Removes User from Snipe-it asset system
    .DESCRIPTION
    Removes Uuser or users from Snipe-it asset system
    .PARAMETER ID
    Unique ID For User to be removed

    .PARAMETER url
    URL of Snipeit system, can be set using Set-SnipeitInfo command

    .PARAMETER apiKey
    User's API Key for Snipeit, can be set using Set-SnipeitInfo command

    .EXAMPLE
    Remove-SnipeitUser -ID 44 -url $url -apiKey $secret -Verbose
#>

function Remove-SnipeitUser ()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]

    Param(
    [parameter(mandatory = $true,ValueFromPipelineByPropertyName)]
        [int]$id,
    [parameter(mandatory = $true)]
        [string]$URL,
    [parameter(mandatory = $true)]
        [string]$APIKey

    )
    begin{
        Test-SnipeitAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name
    }

    process {
        foreach($user_id in $id) {
            $Parameters = @{
                Uri    = "$url/api/v1/users/$user_id"
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
