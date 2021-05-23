<#
    .SYNOPSIS
    Add a new Model to Snipe-it asset system

    .DESCRIPTION
    Long description

    .PARAMETER name
    Name of the Asset Model

    .PARAMETER model_number
    Model number of the Asset Model

    .PARAMETER category_id
    Category ID that the asset belongs to this can be got using Get-Category

    .PARAMETER manufacturer_id
    Manufacturer ID that the asset belongs to this can be got using Get-Manufacturer

    .PARAMETER fieldset_id
    Fieldset ID that the asset uses (Custom fields)

    .PARAMETER url
    URL of Snipeit system, can be set using Set-SnipeItInfo command

    .PARAMETER apiKey
    Users API Key for Snipeit, can be set using Set-SnipeItInfo command

    .EXAMPLE
    New-SnipeItModel -name "DL380" -manufacturer_id 2 -fieldset_id 2 -category_id 1
#>

function New-SnipeItModel()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]

    Param(
        [parameter(mandatory = $true)]
        [string]$name,

        [string]$model_number,

        [parameter(mandatory = $true)]
        [int]$category_id,

        [parameter(mandatory = $true)]
        [int]$manufacturer_id,

        [int]$eol,

        [parameter(mandatory = $true)]
        [int]$fieldset_id,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    Test-SnipeItAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

    $Values = @{
        name            = $name
        category_id     = $category_id
        manufacturer_id = $manufacturer_id
        fieldset_id     = $fieldset_id
    }

    if ($PSBoundParameters.ContainsKey('model_number')) { $Values.Add("model_number", $model_number) }
    if ($PSBoundParameters.ContainsKey('eol')) { $Values.Add("eol", $eol) }

    $Body = $Values | ConvertTo-Json;

    $Parameters = @{
        Uri    = "$url/api/v1/models"
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
