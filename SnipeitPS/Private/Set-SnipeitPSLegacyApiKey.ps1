function Set-SnipeitPSLegacyApiKey {
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]
    param(
        [string]$apiKey
    )
    process {
        if ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
            $SnipeitPSSession.legacyApiKey = ConvertTo-SecureString -AsPlainText -String $apiKey
        }
    }
}
