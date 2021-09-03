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
            if($PSVersionTable.PSVersion -ge '7.0'){
                $SnipeitPSSession.legacyApiKey = ConvertTo-SecureString -AsPlainText -String $apiKey
            } else {
                $SnipeitPSSession.legacyApiKey = ConvertTo-SecureString -Force -AsPlainText -String $apiKey
            }
        }
    }
}
