<#
    .SYNOPSIS
    Add a new Custom Field to Snipe-it asset system

    .DESCRIPTION
    Add a new Custom Field to Snipe-it asset system

    .PARAMETER name
    The field's name, which is also the form label

    .PARAMETER element
    Form field type that should be displayed.

    .PARAMETER field_values
    In the case of list boxes, etc, this should be a list of the options available

    .PARAMETER show_in_email
    Whether or not to show the custom field in email notifications

    .PARAMETER format
    How the field should be validated

    .PARAMETER custom_format
    In the case of format 'CUSTOM REGEX', this should be validation regex this field

    .PARAMETER field_encrypted
    Whether the field should be encrypted. (This can cause issues if you change it after the field was created.)

    .PARAMETER help_text
    Any additional text you wish to display under the new form field to make it clearer what the gauges should be.

    .PARAMETER url
    URL of Snipeit system, can be set using Set-SnipeitInfo command

    .PARAMETER apiKey
    Users API Key for Snipeit, can be set using Set-SnipeitInfo command

    .EXAMPLE
    New-SnipeitCustomField -Name "AntivirusInstalled" -Format "BOOLEAN" -HelpText "Is AntiVirus installed on Asset"
#>

function New-SnipeitCustomField()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]

    Param(
        [parameter(mandatory = $true)]
        [string]$name,

        [string]$help_text,

        [parameter(mandatory = $true)]
        [ValidateSet('text','textarea','listbox','checkbox','radio')]
        [string]$element ,

        [parameter(mandatory = $true)]
        [ValidateSet('ANY','CUSTOM REGEX','ALPHA','ALPHA-DASH','NUMERIC','ALPHA-NUMERIC','EMAIL','DATE','URL','IP','IPV4','IPV6','MAC','BOOLEAN')]
        [string]$format,

        [string]$field_values,

        [bool]$field_encrypted=$false,

        [bool]$show_in_email=$false,

        [string]$custom_format,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    begin {
        Test-SnipeitAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name
        if ($format -eq 'CUSTOM REGEX' -and (-not $custom_format)) {
            throw "Please specify regex validation with -custom_format when using -format 'CUSTOM REGEX'"
        }

        $Values = . Get-ParameterValue -Parameters $MyInvocation.MyCommand.Parameters -BoundParameters $PSBoundParameters

        $Parameters = @{
            Uri    = "$url/api/v1/fields"
            Method = 'post'
            Body   = $Values
            Token  = $apiKey
        }
    }

    process{
        If ($PSCmdlet.ShouldProcess("ShouldProcess?"))
        {
            $result = Invoke-SnipeitMethod @Parameters
        }

        $result
    }
}

