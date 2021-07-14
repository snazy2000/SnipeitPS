<#
.SYNOPSIS
Creates a new Company

.DESCRIPTION
Creates new company on Snipe-It system

.PARAMETER name
Comapany name

.PARAMETER image
Company image filename and path

.PARAMETER url
URL of Snipeit system, can be set using Set-SnipeitInfo command

.PARAMETER apiKey
User's API Key for Snipeit, can be set using Set-SnipeitInfo command

.EXAMPLE
New-SnipeitCompany -name "Acme Company"

#>

function New-SnipeitCompany()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]

    Param(
        [parameter(mandatory = $true)]
        [string]$name,

        [ValidateScript({Test-Path $_})]
        [string]$image,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    Test-SnipeitAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

    $Values = . Get-ParameterValue -Parameters $MyInvocation.MyCommand.Parameters -BoundParameters $PSBoundParameters

    $Parameters = @{
        Uri    = "$url/api/v1/companies"
        Method = 'POST'
        Body   = $Values
        Token  = $apiKey
    }

    If ($PSCmdlet.ShouldProcess("ShouldProcess?"))
    {
        $result = Invoke-SnipeitMethod @Parameters
    }

    $result
}

