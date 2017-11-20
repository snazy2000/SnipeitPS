function Set-Component()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "High"
    )]

    Param(
        [parameter(mandatory = $true)]
        [string]$id,

        [parameter(mandatory = $true)]
        [string]$qty,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    $Values = @{
        "qty" = $qty
    }

    $Body = $Values | ConvertTo-Json;

    $Parameters = @{
        Uri    = "$url/api/v1/components/$component_id"
        Method = 'Patch'
        Body   = $Body
        Token  = $apiKey
    }

    If ($PSCmdlet.ShouldProcess("ShouldProcess?"))
    {
        $result = Invoke-Method @Parameters
    }

    $result
}
