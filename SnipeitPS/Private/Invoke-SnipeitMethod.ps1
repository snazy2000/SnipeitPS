<#
    .SYNOPSIS
    Make api request to Snipe it

    .PARAMETER Api
    Api part of url. prefix with slash ie. "/api/v1/hardware"

    .PARAMETER Method
    Method of the invokation, one of following "GET", "POST", "PUT", "PATCH" or "DELETE"

    .PARAMETER Body
    Request body as hashtable. Needed for post, put and patch

    .PARAMETER GetParameters
    Get-Parameters as hastable.
#>

function Invoke-SnipeitMethod {
    [OutputType(
        [PSObject]
    )]

    param (

        [Parameter(Mandatory = $true)]
        [string]$Api,

        [ValidateSet("GET", "POST", "PUT", "PATCH", "DELETE")]
        [string]$Method = "GET",

        [Hashtable]$Body,

        [Hashtable]$GetParameters
    )

    BEGIN {
        #use legacy per command based url and apikey
        if ( $null -ne $SnipeitPSSession.legacyUrl -and $null -ne $SnipeitPSSession.legacyApiKey ) {
            [string]$Url = $SnipeitPSSession.legacyUrl
            Write-Debug "Invoke-SnipeitMethod url: $Url"
            if($PSVersionTable.PSVersion -ge '7.0'){
                $Token =  ConvertFrom-SecureString -AsPlainText -SecureString $SnipeitPSSession.legacyApiKey
            } else {
                #convert to plaintext via credential
                $Token =  (New-Object PSCredential "user",$SnipeitPSSession.legacyApiKey).GetNetworkCredential().Password
            }
        } elseif ($null -ne $SnipeitPSSession.url -and $null -ne $SnipeitPSSession.apiKey) {
            [string]$Url = $SnipeitPSSession.url
            Write-Debug "Invoke-SnipeitMethod url: $Url"
            if($PSVersionTable.PSVersion -ge '7.0'){
                $Token =  ConvertFrom-SecureString -AsPlainText -SecureString $SnipeitPSSession.apiKey
            } else {
                #convert to plaintext via credential
                $Token =  (New-Object PSCredential "user",$SnipeitPSSession.apiKey).GetNetworkCredential().Password
            }
        } else {
            throw "Please use Connect-SnipeitPS to setup connection before any other commands."
        }

        # Validation of parameters
        if (($Method -in ("POST", "PUT", "PATCH")) -and (!($Body))) {
            $message = "The following parameters are required when using the ${Method} parameter: Body."
            $exception = New-Object -TypeName System.ArgumentException -ArgumentList $message
            Throw $exception
        }

        #Build request uri
        $apiUri = "$Url$Api"
        #To support images "image" property have be handled before this

        $_headers = @{
            "Authorization" = "Bearer $($Token)"
            'Content-Type'  = 'application/json; charset=utf-8'
            "Accept" = "application/json"
        }
    }

    Process {
        # This can be done using $Body, maybe some day - PetriAsi
        if ($GetParameters -and ($apiUri -notlike "*\?*")){
            Write-Debug "Using `$GetParameters: $($GetParameters | Out-String)"
            [string]$apiUri = $apiUri + (ConvertTo-GetParameter $GetParameters)
            # Prevent recursive appends
            $GetParameters = $null
        }

        # set mandatory parameters
        $splatParameters = @{
            Uri             = $apiUri
            Method          = $Method
            Headers         = $_headers
            UseBasicParsing = $true
            ErrorAction     = 'SilentlyContinue'
        }

        # Send image requests as multipart/form-data if supported
        if($null -ne $body -and $Body.Keys -contains 'image' ){
            if($PSVersionTable.PSVersion -ge '7.0'){
                $Body['image'] = get-item $body['image']
                # As multipart/form-data is always POST we need add
                # requested method for laravel named as '_method'
                $Body['_method'] = $Method
                $splatParameters["Method"] = 'POST'
                $splatParameters["Form"] = $Body
            } else {
                # use base64 encoded images for powershell  version < 7
                Add-Type -AssemblyName "System.Web"
                $mimetype = [System.Web.MimeMapping]::GetMimeMapping($body['image'])
                $Body['image'] = 'data:@'+$mimetype+';base64,'+[Convert]::ToBase64String([IO.File]::ReadAllBytes($Body['image']))
            }
        }

        if ($Body -and $splatParameters.Keys -notcontains 'Form') {
            $splatParameters["Body"] =  [System.Text.Encoding]::UTF8.GetBytes(($Body | Convertto-Json))
        }

        $script:PSDefaultParameterValues = $global:PSDefaultParameterValues

        Write-Debug "$($Body | ConvertTo-Json)"

        #Check throttle limit
        if ($SnipeitPSSession.throttleLimit -gt 0) {
            Write-Verbose "Check for request throttling"
            Write-debug "ThrottleMode: $($SnipeitPSSession.throttleMode)"
            Write-debug "ThrottleLimit: $($SnipeitPSSession.throttleLimit)"
            Write-debug "ThrottlePeriod: $($SnipeitPSSession.throttlePeriod)"
            Write-debug "ThrottleThreshold: $($SnipeitPSSession.throttleThreshold)"
            Write-debug "Current count: $($SnipeitPSSession.throttledRequests.count)"

            #current request timestamps in period
            $SnipeitPSSession.throttledRequests = ($SnipeitPSSession.throttledRequests).where({$_ -gt (get-date).AddMilliseconds( 0 - $SnipeitPSSession.throttlePeriod).ToFileTime()})

            #make sure that we alway have list here
            if($null -eq $SnipeitPSSession.throttledRequests) {
                $SnipeitPSSession.throttledRequests = [System.Collections.ArrayList]::new()
            }

            $naptime = 0
            switch ($SnipeitPSSession.throttleMode) {
                "Burst" {
                    if ($SnipeitPSSession.throttledRequests.count -ge $SnipeitPSSession.throttleLimit) {
                        $naptime =  [Math]::Round(((get-date).ToFileTime() - ($SnipeitPSSession.throttledRequests[0]))/10000)
                    }
                }

                "Constant" {
                    $prevrequesttime =[Math]::Round(((get-date).ToFileTime() - ($SnipeitPSSession.throttledRequests[$SnipeitPSSession.throttledRequests.count - 1]))/10000)
                    $naptime = [Math]::Round($SnipeitPSSession.throttlePeriod / $SnipeitPSSession.throttleLimit) - $prevrequesttime
                }

                "Adaptive" {
                  $unThrottledRequests = $SnipeitPSSession.throttleLimit * ($SnipeitPSSession.throttleThreshold / 100)
                  if($SnipeitPSSession.throttledRequests.count -ge $unThrottledRequests) {
                     #calculate time left in throttlePeriod and devide it for remaining requests
                     $remaining = $SnipeitPSSession.throttleLimit - $SnipeitPSSession.throttledRequests.count
                     if ($remaining -lt 1) {
                        $remaining = 1
                     }
                     $naptime =  [Math]::Round((((get-date).ToFileTime() - ($SnipeitPSSession.throttledRequests[0]))/ 10000) / $remaining)
                  }
                }
            }

            #Do we need a nap
            if ($naptime -gt 0) {
                Write-verbose "Throttling request for $naptime ms"
                Start-Sleep -Milliseconds $naptime
            }

            $SnipeitPSSession.throttledRequests.Add((Get-Date).ToFileTime())
        }

        # Invoke the API
        try {
            Write-Verbose "[$($MyInvocation.MyCommand.Name)] Invoking method $Method to URI $URi"
            Write-Debug "[$($MyInvocation.MyCommand.Name)] Invoke-WebRequest with: $($splatParameters | Out-String)"
            $webResponse = Invoke-RestMethod @splatParameters
        }
        catch {
            Write-Verbose "[$($MyInvocation.MyCommand.Name)] Failed to get an answer from the server"
            $webResponse = $_.Exception.Response
        }

        Write-Debug "[$($MyInvocation.MyCommand.Name)] Executed WebRequest. Access $webResponse to see details"

        if ($webResponse) {
            Write-Verbose "[$($MyInvocation.MyCommand.Name)] Status code: $($webResponse.StatusCode)"

            if ($webResponse) {
                 Write-Verbose $webResponse

                # API returned a Content: lets work with it
                try{
                    if ($webResponse.status -eq "error") {
                        Write-Verbose "[$($MyInvocation.MyCommand.Name)] An error response was received ... resolving"
                        # This could be handled nicely in an function such as:
                        # ResolveError $response -WriteError
                        Write-Error $($webResponse.messages | Out-String)
                    } elseif ( $webResponse.StatusCode -eq 'Unauthorized') {
                        Write-Verbose "[$($MyInvocation.MyCommand.Name)] An Unauthorized response was received"
                        Write-Error "Cannot connect to Snipe It: Unauthorized."
                        return $false
                    } else {
                        #update operations return payload
                        if ($webResponse.payload) {
                            $result = $webResponse.payload
                        }
                        #Search operations return rows
                        elseif ($webResponse.rows) {
                            $result = $webResponse.rows
                        }
                        #Remove operations returns status and message
                        elseif ($webResponse.status -eq 'success') {
                            $result = $webResponse.payload
                        }
                        #Search and query result with no results
                        elseif ($webResponse.total -eq 0){
                            $result = $null
                        }
                        #get operations with id returns just one object
                        else {
                            $result = $webResponse
                        }

                        Write-Verbose "Status: $($webResponse.status)"
                        Write-Verbose "Messages: $($webResponse.messages)"

                        $result
                    }
                }
                catch {
                    Write-Warning "Cannot parse server response. To debug try to add -Verbose with command."
                }

            }
            elseif ($webResponse.StatusCode -eq "Unauthorized") {
                Write-Error "[$($MyInvocation.MyCommand.Name)] You are not Authorized to access the resource, check your apiKey is correct"
            }
            else {
                # No content, although statusCode < 400
                # This could be wanted behavior of the API
                Write-Verbose "[$($MyInvocation.MyCommand.Name)] No content was returned from."
            }

        }
        else {
            Write-Verbose "[$($MyInvocation.MyCommand.Name)] No Web result object was returned from. This is unusual!"
        }
    }

    END {
        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Function ended"
    }
}

