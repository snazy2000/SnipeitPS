<#
    .SYNOPSIS
    Add a new Manufacturer to Snipe-it asset system

    .DESCRIPTION
    Long description

    .PARAMETER Name
    Name of the Manufacturer

    .PARAMETER image
    Manufacturer Image filename and path

    .PARAMETER image_delete
    Remove current image

    .PARAMETER url
    URL of Snipeit system, can be set using Set-SnipeitInfo command

    .PARAMETER apiKey
    Users API Key for Snipeit, can be set using Set-SnipeitInfo command

    .EXAMPLE
    New-SnipeitManufacturer -name "HP"
#>

function New-SnipeitManufacturer()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]

    Param(
        [parameter(mandatory = $true)]
        [string]$Name,

        [ValidateScript({Test-Path $_})]
        [string]$image,

        [switch]$image_delete=$false,

        [parameter(mandatory = $false)]
        [string]$url,

        [parameter(mandatory = $false)]
        [string]$apiKey
    )

    Test-SnipeitAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

    $Values = @{
        "name" = $Name
    }

    $Parameters = @{
        Uri    = "$url/api/v1/manufacturers"
        Method = 'post'
        Body   = $Values
        Token  = $apiKey
    }

    If ($PSCmdlet.ShouldProcess("ShouldProcess?"))
    {
        $result = Invoke-SnipeitMethod @Parameters
    }

    $result
}
