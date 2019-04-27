
function New-License() {
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]

    Param(
        [parameter(mandatory = $true)]
        [ValidateLength(3, 255)]
        [string]$name,

        [parameter(mandatory = $true)]
        [int]$seats,

        [ValidateRange(1, [int]::MaxValue)]
        [int]$category_id,

        [ValidateRange(1, [int]::MaxValue)]
        [int]$company_id,

        [datetime]$expiration_date,

        [ValidateLength(1, 120)]
        [mailaddress]$license_email,

        [ValidateLength(1, 100)]
        [string]$license_name,

        [bool]$maintained,

        [ValidateRange(1, [int]::MaxValue)]
        [int]$manufacturer_id,

        [string]$notes,

        [string]$order_number,

        [float]$purchase_cost,

        [datetime]$purchase_date,

        [bool]$reassignable,

        [string]$serial,

        [ValidateRange(1, [int]::MaxValue)]
        [int]$supplier_id,

        [datetime]$termination_date,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    $Values = . Get-ParameterValue

    if ($values['expiration_date']) {
        $values['expiration_date'] = $values['expiration_date'].ToString("yyyy-MM-dd")
    }

    if ($values['purchase_date']) {
        $values['purchase_date'] = $values['purchase_date'].ToString("yyyy-MM-dd")
    }

    if ($values['termination_date']) {
        $values['termination_date'] = $values['termination_date'].ToString("yyyy-MM-dd")
    }

    $Body = $Values | ConvertTo-Json;

    $Parameters = @{
        Uri    = "$url/api/v1/licenses"
        Method = 'POST'
        Body   = $Body
        Token  = $apiKey
    }

    If ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
        $result = Invoke-SnipeitMethod @Parameters
    }

    $result
}

