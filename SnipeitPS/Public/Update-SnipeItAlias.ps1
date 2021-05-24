<#
.SYNOPSIS
Replaces old SnipeItPS commands with new ones

.DESCRIPTION
Replaces old SnipeItPS commands with new ones

.PARAMETER String
Input string

.EXAMPLE
Get-Content [your-script.ps1] | Update-SnipeItAlias | Out-File [new-script-name.ps1]
Replaces old command from file "your-script.ps1" and creates new script "new-script-name.ps1"
After testing new file you can replace old file with new.

#>


function Update-SnipeItAlias()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]
    param(
        [Parameter(Mandatory = $true,
            ValueFromPipeline = $true)]
	    [string[]]
	    $String
    )
    begin{
        Write-Verbose "Replacing old SnipeIt fuctions with new ones.. "
        $SnipeItAliases = Get-SnipeItAlias

    }
    process {
        If ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
            ForEach ($st in $String){
                $result = $st
                ForEach ($key in $SnipeItAliases.Keys ) {
                    #Write-Verbose "Replacing $key with $($SnipeItAliases[$key])"
                    $result = $result -replace $key, $SnipeItAliases[$key]
                }
                $result
            }
        }
    }
    end{
        Write-Verbose "..replacing done"
    }



}
