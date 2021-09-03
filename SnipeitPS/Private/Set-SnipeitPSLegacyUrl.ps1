function Set-SnipeitPSLegacyUrl {
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]
    param(
        $url
    )
    process {
        if ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
            $SnipeitPSSession.legacyUrl = $url.TrimEnd('/')
        }
    }
}
