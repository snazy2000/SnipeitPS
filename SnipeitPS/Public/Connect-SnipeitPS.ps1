<#
    .SYNOPSIS
    Sets authetication information

    .DESCRIPTION
    Sets apikey and url to connect Snipe-It system.
    Based on Set-SnipeitInfo command, what is now just compatibility wrapper
    and calls Connect-SnipeitPS

    .PARAMETER url
    URL of Snipeit system.

    .PARAMETER apiKey
    User's API Key for Snipeit.

    .PARAMETER secureApiKey
    Snipe it Api key as securestring

    .PARAMETER siteCred
    PSCredential where username shoul be snipe it url and password should be
    snipe it apikey.

    .PARAMETER throttleLimit
    Throttle request rate to nro of requests per throttlePeriod. Defaults to 0 that means no requests are not throttled.

    .PARAMETER throttlePeriod
    Throttle period time span in milliseconds defaults to 60 milliseconds.

    .PARAMETER throttleThreshold
    Threshold percentage of used request on period after request are throttled.

    .PARAMETER throttleMode
    RequestThrottling type. "Burst" allows all requests to be used in ThrottlePeriod without delays and then waits
    until there's new requests avalable. With "Contant" mode there always delay between requests. Delay is calculated
    by dividing throttlePeriod with throttleLimit. "Adaptive" mode allows throttleThreshold percentage of request to be
    used with out delay, after threshold limit is reached next requests are delayded by dividing available requests
    over throttlePeriod.

    .EXAMPLE
    Connect-SnipeitPS -Url $url -apiKey $myapikey
    Connect to  Snipe it  api.

    .EXAMPLE
    Connect-SnipeitPS -Url $url -SecureApiKey $myapikey
    Connects to Snipe it api with apikey stored to securestring

    .EXAMPLE
    Connect-SnipeitPS -siteCred (Get-Credential -message "Use site url as username and apikey as password")
    Connect to Snipe It with PSCredential object.
    To use saved creadentials yu can use export-clixml and import-clixml commandlets.

    .EXAMPLE
    Build credential with apikey value from secret vault (Microsoft.PowerShell.SecretManagement)
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
        [PSCredential]$siteCred,

        [Parameter(ParameterSetName='Connect with url and apikey',Mandatory=$false)]
        [Parameter(ParameterSetName='Connect with url and secure apikey',Mandatory=$false)]
        [Parameter(ParameterSetName='Connect with credential',Mandatory=$false)]
        [int]$throttleLimit,

        [Parameter(ParameterSetName='Connect with url and apikey',Mandatory=$false)]
        [Parameter(ParameterSetName='Connect with url and secure apikey',Mandatory=$false)]
        [Parameter(ParameterSetName='Connect with credential',Mandatory=$false)]
        [int]$throttlePeriod,

        [Parameter(ParameterSetName='Connect with url and apikey',Mandatory=$false)]
        [Parameter(ParameterSetName='Connect with url and secure apikey',Mandatory=$false)]
        [Parameter(ParameterSetName='Connect with credential',Mandatory=$false)]
        [int]$throttleThreshold,

        [Parameter(ParameterSetName='Connect with url and apikey',Mandatory=$false)]
        [Parameter(ParameterSetName='Connect with url and secure apikey',Mandatory=$false)]
        [Parameter(ParameterSetName='Connect with credential',Mandatory=$false)]
        [ValidateSet("Burst","Constant","Adaptive")]
        [string]$throttleMode
    )


    PROCESS {
        switch ($PsCmdlet.ParameterSetName) {
            'Connect with url and apikey' {
                $SnipeitPSSession.url = $url.AbsoluteUri.TrimEnd('/')
                if($PSVersionTable.PSVersion -ge '7.0'){
                    $SnipeitPSSession.apiKey = ConvertTo-SecureString -AsPlainText -String $apiKey
                } else {
                    $SnipeitPSSession.apiKey = ConvertTo-SecureString -String $apiKey -AsPlainText -Force
                }
            }

            'Connect with url and secure apikey' {
                $SnipeitPSSession.url = $url.AbsoluteUri.TrimEnd('/')
                $SnipeitPSSession.apiKey = $secureApiKey
            }

            'Connect with credential' {
                $SnipeitPSSession.url = ($siteCred.GetNetworkCredential().UserName).TrimEnd('/')
                $SnipeitPSSession.apiKey = $siteCred.GetNetworkCredential().SecurePassword
            }
        }
        if($null -eq $throttleLimit) { $throttleLimit = 0}
        $SnipeitPSSession.throttleLimit = $throttleLimit

        if($throttleThreshold -lt 1) { $throttleThreshold = 90}
        $SnipeitPSSession.throttleThreshold = $throttleThreshold

        if('' -eq $throttleMode) { $throttleMode = "Burst"}
        $SnipeitPSSession.throttleMode = $throttleMode

        if ($SnipeitPSSession.throttleLimit -gt 0) {
            if($null -eq $throttlePeriod) { $throttlePeriod = 60000}
            $SnipeitPSSession.throttlePeriod = $throttlePeriod

            $SnipeitPSSession.throttledRequests = [System.Collections.ArrayList]::new()
        }

        Write-Debug "Site-url $($SnipeitPSSession.url)"
        Write-Debug "Site apikey: $($SnipeitPSSession.apiKey)"

        if (-not (Test-SnipeitPSConnection)) {
            throw "Cannot verify connection to snipe it. For the start try to check url and provided apikey or credential parameters"
        }
    }
}
