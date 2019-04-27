function Set-Model() {
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Medium"
    )]

    Param(
        [parameter(mandatory = $true)]
        [int]$id,

        [ValidateLength(1, 255)]
        [string]$name,

        [ValidateLength(1, 255)]
        [string]$model_number,

        [int]$category_id,

        [int]$manufacturer_id,

        [ValidateRange(1, 240)]
        [int]$eol,

        [Alias("fieldset_id")]
        [int]$custom_fieldset_id,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    $Values = Copy-Parameters -InputObject $PSBoundParameters

    $Body = $Values | ConvertTo-Json;

    $Parameters = @{
        Uri    = "$url/api/v1/models/$id"
        Method = 'put'
        Body   = $Body
        Token  = $apiKey
    }

    If ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
        $result = Invoke-SnipeitMethod @Parameters
    }

    $result
}
