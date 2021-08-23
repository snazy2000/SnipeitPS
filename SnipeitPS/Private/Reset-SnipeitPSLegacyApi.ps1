function Reset-SnipeitPSLegacyApi {
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]
    param(
    )
    process {
        if ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
            $SnipeitPSSession.legacyUrl = $null
            $SnipeitPSSession.legacyApiKey = $null

        }
    }
}
