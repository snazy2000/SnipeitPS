<#
.SYNOPSIS
Updates company name

.DESCRIPTION
Updates companyt name on Snipe-It system

.PARAMETER id
ID number of company

.PARAMETER name
Company name

.PARAMETER url
URL of Snipeit system, can be set using Set-SnipeitInfo command

.PARAMETER apiKey
User's API Key for Snipeit, can be set using Set-SnipeitInfo command

.EXAMPLE
An example

.NOTES
General notes
#>
function Set-SnipeitCompany()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Medium"
    )]

    Param(
        [parameter(mandatory = $true,ValueFromPipelineByPropertyName)]
        [int[]]$id,

        [parameter(mandatory = $true)]
        [string]$name,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    begin{
        $values = . Get-ParameterValue -Parameters $MyInvocation.MyCommand.Parameters -BoundParameters $PSBoundParameters

        $Body = $values | ConvertTo-Json;
    }

    process{
        foreach($company_id in $id){
            $Parameters = @{
                Uri    = "$url/api/v1/companies/$company_id"
                Method = 'Patch'
                Body   = $Body
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
