function New-Asset()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "High"
    )]

    Param(
        [parameter(mandatory = $true)]
        [string]$Name,

        [parameter(mandatory = $true)]
        [string]$Status_id,

        [parameter(mandatory = $true)]
        [string]$Model_id,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey,

        [hashtable] $customfields
    )

    $Values = @{
        "name"      = $Name
        "status_id" = $status_id
        "model_id"  = $model_id
    }

    $Values += $customfields

    $Body = $Values | ConvertTo-Json;

    $Parameters = @{
        Uri    = "$url/api/v1/hardware"
        Method = 'Post'
        Body   = $Body
        Token  = $apiKey
    }

    If ($PSCmdlet.ShouldProcess())
    {
        $result = Invoke-Method @Parameters
    }

    $result
}
