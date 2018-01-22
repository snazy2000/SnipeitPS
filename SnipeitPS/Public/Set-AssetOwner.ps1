function Set-AssetOwner()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Medium"
    )]

    Param(
        [parameter(mandatory = $true)]
        [int]$id,

        [parameter(mandatory = $true)]
        [int]$assigned_id,

        [ValidateSet("location","asset","user")]
        [string] $checkout_to_type = "user",

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    $Values = @{
        "id" = $assigned_id
        "checkout_to_type" = $checkout_to_type
    }

    switch ($checkout_to_type)
    {
        'location' { $Values += @{ "assigned_location" = $assigned_id } }
        'user' { $Values += @{ "assigned_user" = $assigned_id } }
        'asset' { $Values += @{ "assigned_asset" = $assigned_id } }
    }

    $Body = $Values | ConvertTo-Json;

    $Parameters = @{
        Uri    = "$url/api/v1/hardware/$id/checkout"
        Method = 'POST'
        Body   = $Body
        Token  = $apiKey
    }

    If ($PSCmdlet.ShouldProcess("ShouldProcess?"))
    {
        $result = Invoke-SnipeitMethod @Parameters
    }

    return $result
}
