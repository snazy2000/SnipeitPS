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
        # Pass $MyInvocation.MyCommand.Parameters to function, powershell 7 seems to only populate variables with dot sourcing
        [parameter(mandatory = $true)]
        $Parameters
        ,
        [parameter(mandatory = $true)]
        $BoundParameters,

        [string[]]$DefaultExcludeParameter = @("id", "url", "apiKey", 'Debug', 'Verbose','RequestType','customfields')
    )

    if ($MyInvocation.Line[($MyInvocation.OffsetInLine - 1)] -ne '.') {
        throw "Get-ParameterValue must be dot-sourced, like this: . Get-ParameterValues"
    }


    $ParameterValues = @{}
    foreach ($parameter in $Parameters.GetEnumerator()) {
        # gm -in $parameter.Value | Out-Default
        try {
            $key = $parameter.Key
            if ($key -notin $DefaultExcludeParameter) {
                #Fill in default parameters values
                if ($null -ne ($value = Get-Variable -Name $key -ValueOnly -ErrorAction Ignore )) {
                    if ($value -ne ($null -as $parameter.Value.ParameterType)) {
                        $ParameterValues[$key] = $value
                    }
                }
                #Fill in all given parameters even empty
                if ($BoundParameters.ContainsKey($key)) {
                    $ParameterValues[$key] = $BoundParameters[$key]
                }

            }
        }
        finally {}
    }

    #Convert switch parameters to booleans so it converts nicely to json
    foreach ( $key in @($ParameterValues.Keys)) {
      if ($true -eq $ParameterValues[$key].IsPresent){
        $ParameterValues[$key]=$true;
      }
    }

    return $ParameterValues
}
