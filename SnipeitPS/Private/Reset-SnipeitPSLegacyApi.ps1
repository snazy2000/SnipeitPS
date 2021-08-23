function Reset-SnipeitPSLegacyApi {
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]
    param(
    )
    process {
        Write-Verbose 'Reset-SnipeitPSLegacyApi'
        if ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
            $SnipeitPSSession.legacyUrl = $null
            $SnipeitPSSession.legacyApiKey = $null

        }
    }
}
