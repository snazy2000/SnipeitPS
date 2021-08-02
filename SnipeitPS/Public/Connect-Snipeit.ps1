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
    Connect to  Snipe it  api and stores connection information.

    .EXAMPLE
    Connect-SnipeitPS -Url $url -apiKey $myapikey -DontStore
    Just connects to Snipe it api, connection information is not stored.

    .EXAMPLE
    Connect-SnipeitPS -Url $url
    Connects existing Snipe It Url with stored apiKey

    .EXAMPLE
    Connect-SnipeitPS
    Connects last used Snipe It Url with stored apikey


#>
function Connect-SnipeitPS {
    [CmdletBinding(
        DefaultParameterSetName = 'Connect to existing connection'
    )]
    [System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseShouldProcessForStateChangingFunctions', '')]

    param (

        [Parameter(ParameterSetName='Setup new connection',Mandatory=$true)]
        [Parameter(ParameterSetName='Connect to existing connection',Mandatory=$false)]
        [Uri]$url,

        [Parameter(ParameterSetName='Setup new connection',Mandatory=$true)]
        [String]$apiKey,

        [Parameter(ParameterSetName='Setup new connection')]
        [switch]$DontStore
    )


    PROCESS {
        switch ($PsCmdlet.ParameterSetName) {
            'Setup new connection' {
                try {
                    $SnipeitPSSession.url = $url
                    $SnipeitPSSession.apiKey = $apiKey

                    #test connection
                    $Parameters = @{
                        Api           = '/api/v1/statuslabels'
                        Method        = 'Get'
                        GetParameters = @{'limit'=1}
                    }
                    Write-Verbose "Testin connection to $url."

                    $contest = Invoke-SnipeitMethod @Parameters
                    if ( $contest) {
                        Write-Verbose "Connection to $url tested succesfully."
                    }

                }
                catch {
                    throw "Cannot setup connection to $url. To start troubleshooting, check your url, certificates and apiKey"
                }
                # TODO: Save connection information safely on disk

            }

            'Connect to existing connection' {
                # TODO: everything
            }
        }
    }
}
