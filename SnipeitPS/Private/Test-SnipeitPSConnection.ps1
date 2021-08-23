function Test-SnipeitPSConnection {
    #test api connection
    $Parameters = @{
        Api           = '/api/v1/statuslabels'
        Method        = 'Get'
        GetParameters = @{'limit'=1}
    }
    Write-Verbose "Testing connection to $($SnipeitPSSession.url)."

    $contest = Invoke-SnipeitMethod @Parameters

    if ( $contest) {
        Write-Verbose "Connection to $($SnipeitPSSession.url) tested succesfully."
        return $true
    } else {
        return $false
    }
}
