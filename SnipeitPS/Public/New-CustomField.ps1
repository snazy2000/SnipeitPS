<#
    .SYNOPSIS
    Add a new Custom Field to Snipe-it asset system

    .DESCRIPTION
    Add a new Custom Field to Snipe-it asset system

    .PARAMETER Name
    Name of the Custom Field

    .PARAMETER url
    URL of Snipeit system, can be set using Set-Info command

    .PARAMETER apiKey
    Users API Key for Snipeit, can be set using Set-Info command

    .EXAMPLE
    New-Field -Name "AntivirusInstalled" -Format "BOOLEAN" -HelpText "Is AntiVirus installed on Asset"
#>

function New-CustomField()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]

    Param(
        [parameter(mandatory = $true)]
        [string]$Name,

        [string]$HelpText,

        [string]$Element = "text",

        [string]$Format = "ANY",

        [string]$CustomFormat,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )


    $Values = @{
        "name" = $Name
        "help_text" = $HelpText
        "element" = $Element
        "format" = $Format
        "custom_format" = $CustomFormat
    }

    #Convert Values to JSON format
    $Body = $Values | ConvertTo-Json;

    $Parameters = @{
        Uri    = "$url/api/v1/fields"
        Method = 'post'
        Body   = $Body
        Token  = $apiKey
    }

    If ($PSCmdlet.ShouldProcess("ShouldProcess?"))
    {
        $result = Invoke-SnipeitMethod @Parameters
    }

    $result
}
