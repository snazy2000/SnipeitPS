function ConvertTo-GetParameter {

    <#
    .SYNOPSIS
    Generate the GET parameter string for an URL from a hashtable
    #>
    [CmdletBinding()]
    param (
        [Parameter( Position = 0, Mandatory = $true, ValueFromPipeline = $true )]
        [hashtable]$InputObject
    )

    BEGIN {
        [string]$parameters = "?"
    }

    PROCESS {
        Add-Type -AssemblyName System.Web

        Write-Verbose "[$($MyInvocation.MyCommand.Name)] Making HTTP get parameter string out of a hashtable"
        foreach ($key in $InputObject.Keys) {
            $parameters += "$key=$([System.Web.HttpUtility]::UrlEncode($InputObject[$key]))&"
        }
    }

    END {
        $parameters -replace ".$"
    }
}
