function Test-SnipeitPSConnection {
    #test api connection
    $Parameters = @{
        Api           = '/api/v1/statuslabels'
        Method        = 'Get'
        GetParameters = @{'limit'=1}
    }
    Write-Verbose "Testing connection to $url."

    $contest = Invoke-SnipeitMethod @Parameters
    if ( $contest) {
        Write-Verbose "Connection to $url tested succesfully."
        return $true
    } else {
        return $false
    }
}
