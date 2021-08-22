<#
    .SYNOPSIS
    Sets authetication information

    .DESCRIPTION
    Set and stores apikey and url user to connect Snipe-It system.
    Based on Set-SnipeitInfo command, that's now just combatipility wrapper
    and calls Connect-SnipeitPS

    .PARAMETER url
    URL of Snipeit system.

    .PARAMETER apiKey
    User's API Key for Snipeit.

    .PARAMETER DontStore
    Don't store connection information just connect to Url

    .EXAMPLE
    Connect-SnipeitPS -Url $url -apiKey $myapikey
    Connect to  Snipe it  api.

    .EXAMPLE
    Connect-SnipeitPS -Url $url -SecureApiKey $myapikey
    Connects to Snipe it api with apikey stored to securestring

    .EXAMPLE
    Connect-SnipeitPS -siteCred (Get-Credential -message "Use site url as username and apikey as password")
    Connect to Snipe It with PSCredential object

    .EXAMPLE
    Build credential with apiakay value from secret vault (Microsoft.PowerShell.SecretManagement)
    $siteurl = "https://mysnipeitsite.url"
    $apikey = Get-SecretInfo -Name SnipeItApiKey
    $siteCred = New-Object -Type PSCredential -Argumentlist $siteurl,$spikey
    Connect-SnipeitPS -siteCred $siteCred



#>
function Connect-SnipeitPS {
    [CmdletBinding(
        DefaultParameterSetName = 'Connect with url and apikey'
    )]
    [System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseShouldProcessForStateChangingFunctions', '')]

    param (
        [Parameter(ParameterSetName='Connect with url and apikey',Mandatory=$true)]
        [Parameter(ParameterSetName='Connect with url and secure apikey',Mandatory=$true)]
        [Uri]$url,

        [Parameter(ParameterSetName='Connect with url and apikey',Mandatory=$true)]
        [String]$apiKey,

        [Parameter(ParameterSetName='Connect with url and secure apikey',Mandatory=$true)]
        [SecureString]$secureApiKey,

        [Parameter(ParameterSetName='Connect with credential',Mandatory=$true)]
        [PSCredertial]$siteCred
    )


    PROCESS {
        switch ($PsCmdlet.ParameterSetName) {
            'Connect with url and apikey' {
                    $SnipeitPSSession.url = $url
                    $SnipeitPSSession.apiKey = $apiKey | ConvertTo-SecureString -AsPlainText
            }

            'Connect with url and secure apikey' {
                    $SnipeitPSSession.url = $url
                    $SnipeitPSSession.apiKey = $secureApiKey
            }

            'Connect with credential' {
                $SnipeitPSSession.url = $siteCred.Username
                $SnipeitPSSession.apiKey = $siteCred.GetNetworkCredential().SecurePassword
            }
        }

        if (-not (Test-SnipeitPSConnection)) {
            throw "Cannot verify connection to snipe it. For the start try to check url and provided apikey or credentials"
        }
    }
}
