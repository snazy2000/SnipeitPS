<#
    .SYNOPSIS
    Updates Model on Snipe-it asset system

    .DESCRIPTION
    Updates Model on Snipe-it asset system

    .PARAMETER id
    ID number of the Asset Model or array of IDs

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

    .PARAMETER image
    Image file name and path for item

    .PARAMETER image_delete
    Remove current image

    .PARAMETER url
    URL of Snipeit system, can be set using Set-SnipeitInfo command

    .PARAMETER apiKey
    Users API Key for Snipeit, can be set using Set-SnipeitInfo command

    .EXAMPLE
    New-SnipeitModel -name "DL380" -manufacturer_id 2 -fieldset_id 2 -category_id 1
#>

function Set-SnipeitModel() {
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Medium"
    )]

    Param(
        [parameter(mandatory = $true,ValueFromPipelineByPropertyName)]
        [int[]]$id,

        [ValidateLength(1, 255)]
        [string]$name,

        [string]$model_number,

        [int]$category_id,

        [int]$manufacturer_id,

        [Nullable[System.Int32]]$eol,

        [Alias("fieldset_id")]
        [Nullable[System.Int32]]$custom_fieldset_id,

        [ValidateScript({Test-Path $_})]
        [string]$image,

        [switch]$image_delete=$false,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    begin {
        Test-SnipeitAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

        $Values = . Get-ParameterValue -Parameters $MyInvocation.MyCommand.Parameters -BoundParameters $PSBoundParameters

    }
    process {
        foreach ($model_id in $id) {
            $Parameters = @{
                Uri    = "$url/api/v1/models/$model_id"
                Method = 'put'
                Body   = $Values
                Token  = $apiKey
            }

            If ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
                $result = Invoke-SnipeitMethod @Parameters
            }

            $result
        }
    }
}
