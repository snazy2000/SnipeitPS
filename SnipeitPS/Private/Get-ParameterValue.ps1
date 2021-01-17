function Get-ParameterValue {
    #.Synopsis
    #  Get the actual values of parameters which have manually set (non-null) default values or values passed in the call
    #.Description
    #  Unlike $PSBoundParameters, the hashtable returned from Get-ParameterValues includes non-empty default parameter values.
    #  NOTE: Default values that are the same as the implied values are ignored (e.g.: empty strings, zero numbers, nulls).
    #.Example
    #  function Test-Parameters {
    #      [CmdletBinding()]
    #      param(
    #          $Name = $Env:UserName,
    #          $Age
    #      )
    #      $Parameters = . Get-ParameterValues
    #
    #      # This WILL ALWAYS have a value...
    #      Write-Host $Parameters["Name"]
    #
    #      # But this will NOT always have a value...
    #      Write-Host $PSBoundParameters["Name"]
    #  }
    [CmdletBinding()]
    param(
        # The $MyInvocation for the caller -- DO NOT pass this (dot-source Get-ParameterValues instead)
        $Invocation = $MyInvocation,
        # The $PSBoundParameters for the caller -- DO NOT pass this (dot-source Get-ParameterValues instead)
        $BoundParameters = $PSBoundParameters,

        [string[]]$DefaultExcludeParameter = @("id", "url", "apiKey", 'Debug', 'Verbose')
    )

    if ($MyInvocation.Line[($MyInvocation.OffsetInLine - 1)] -ne '.') {
        throw "Get-ParameterValues must be dot-sourced, like this: . Get-ParameterValues"
    }
    if ($PSBoundParameters.Count -gt 0) {
        throw "You should not pass parameters to Get-ParameterValues, just dot-source it like this: . Get-ParameterValues"
    }

    $ParameterValues = @{}
    foreach ($parameter in $Invocation.MyCommand.Parameters.GetEnumerator()) {
        # gm -in $parameter.Value | Out-Default
        try {
            $key = $parameter.Key
            if ($key -notin $DefaultExcludeParameter) {
                if ($null -ne ($value = Get-Variable -Name $key -ValueOnly -ErrorAction Ignore )) {
                    if ($value -ne ($null -as $parameter.Value.ParameterType)) {
                        $ParameterValues[$key] = $value
                    }
                }

                if ($BoundParameters.ContainsKey($key)) {
                    $ParameterValues[$key] = $BoundParameters[$key]
                }
            }
        }
        finally {}
    }
    return $ParameterValues
}
