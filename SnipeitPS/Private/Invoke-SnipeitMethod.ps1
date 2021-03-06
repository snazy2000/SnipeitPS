﻿function Invoke-SnipeitMethod {
    <#
    .SYNOPSIS
    Extracted invokation of the REST method to own function.
    #>
    [OutputType(
        [PSObject]
    )]
    param (
        # REST API to invoke
        [Parameter(Mandatory = $true)]
        [Uri]$URi,

        # Method of the invokation
        [ValidateSet("GET", "POST", "PUT", "PATCH", "DELETE")]
        [string]$Method = "GET",

        # Body of the request
        [ValidateNotNullOrEmpty()]
        [Hashtable]$Body,

        [string] $Token,

        # GET Parameters
        [Hashtable]$GetParameters

    )

    BEGIN {
        # Validation of parameters
        if (($Method -in ("POST", "PUT", "PATCH")) -and (!($Body))) {
            $message = "The following parameters are required when using the ${Method} parameter: Body."
            $exception = New-Object -TypeName System.ArgumentException -ArgumentList $message
            Throw $exception
        }

        #To support images "image" property have be handled before this

        $_headers = @{
            "Authorization" = "Bearer $($token)"
            'Content-Type'  = 'application/json; charset=utf-8'
            "Accept" = "application/json"
        }
    }

    Process {
        if ($GetParameters -and ($URi -notlike "*\?*"))
        {
            Write-Debug "Using `$GetParameters: $($GetParameters | Out-String)"
            [string]$URI += (ConvertTo-GetParameter $GetParameters)
            # Prevent recursive appends
            $GetParameters = $null
        }

        # set mandatory parameters
        $splatParameters = @{
            Uri             = $URi
            Method          = $Method
            Headers         = $_headers
            UseBasicParsing = $true
            ErrorAction     = 'SilentlyContinue'
        }

        # Place holder for intended image manipulation
        # if and when snipe it API gets support for images
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
            $splatParameters["Body"] = $Body | Convertto-Json
        }

        $script:PSDefaultParameterValues = $global:PSDefaultParameterValues

        Write-Debug "$($Body | ConvertTo-Json)"

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

                # API returned a Content: lets work wit it
                try{

                    if ($webResponse.status -eq "error") {
                        Write-Verbose "[$($MyInvocation.MyCommand.Name)] An error response was received from; resolving"
                        # This could be handled nicely in an function such as:
                        # ResolveError $response -WriteError
                        Write-Error $($webResponse.messages | Out-String)
                    }
                    else {
                        #update operations return payload
                        if ($webResponse.payload){
                            $result = $webResponse.payload
                        }
                        #Search operations return rows
                        elseif ($webResponse.rows) {
                            $result = $webResponse.rows
                        }
                        #Remove operations returns status and message
                        elseif ($webResponse.status -eq 'success'){
                            $result = $webResponse.payload
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
                Write-Error "[$($MyInvocation.MyCommand.Name)] You are not Authorized to access the resource, check your token is correct"
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
