function Set-Info {
    [CmdletBinding()]
    [System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseShouldProcessForStateChangingFunctions', '')]
    param (
        [Uri]$url,

        [String]$apiKey
    )

    BEGIN {

        function Add-DefaultParameter {
            param(
                [Parameter(Mandatory = $true)]
                [string]$Command,

                [Parameter(Mandatory = $true)]
                [string]$Parameter,

                [Parameter(Mandatory = $true)]
                $Value
            )

            PROCESS {
                #Write-Verbose "[$($MyInvocation.MyCommand.Name)] Setting [$command : $parameter] = $value"

                # Needs to set both global and module scope for the private functions:
                # http://stackoverflow.com/questions/30427110/set-psdefaultparametersvalues-for-use-within-module-scope
                $PSDefaultParameterValues["${command}:${parameter}"] = $Value
                $global:PSDefaultParameterValues["${command}:${parameter}"] = $Value
            }
        }

        $moduleCommands = Get-Command -Module SnipeitPS
    }

    PROCESS {
        foreach ($command in $moduleCommands) {
            $parameter = "url"
            if ($url -and ($command.Parameters.Keys -contains $parameter)) {
                Add-DefaultParameter -Command $command -Parameter $parameter -Value ($url.AbsoluteUri.TrimEnd('/'))
            }

            $parameter = "apiKey"
            if ($apiKey -and ($command.Parameters.Keys -contains $parameter)) {
                Add-DefaultParameter -Command $command -Parameter $parameter -Value $apiKey
            }
        }
    }
}
