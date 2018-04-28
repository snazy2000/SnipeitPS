function Reset-AssetOwner() {
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Medium"
    )]

    Param(
        [parameter(mandatory = $true)]
        [int]$id,

        [int]$status_id,

        [int]$location_id,

        [string]$notes,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    $Values = @{
        "notes" = $notes
    }

    if ($PSBoundParameters.ContainsKey('location_id')) { $Values.Add("location_id", $location_id) }
    if ($PSBoundParameters.ContainsKey('status_id')) { $Values.Add("status_id", $status_id) }

    $Body = $Values | ConvertTo-Json;

    $Parameters = @{
        Uri    = "$url/api/v1/hardware/$id/checkin"
        Method = 'POST'
        Body   = $Body
        Token  = $apiKey
    }

    If ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
        $result = Invoke-SnipeitMethod @Parameters
    }

    return $result
}
