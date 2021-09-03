<#
.SYNOPSIS
Replaces old SnipeitPS commands with new ones

.DESCRIPTION
Replaces old SnipeitPS commands with new ones

.PARAMETER String
Input string

.EXAMPLE
Get-Content [your-script.ps1] | Update-SnipeitAlias | Out-File [new-script-name.ps1]

Replaces old command from file "your-script.ps1" and creates new script "new-script-name.ps1"
After testing new file you can replace old file with new.

#>
function Update-SnipeitAlias() {
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
        Write-Verbose "Replacing old Snipeit fuctions with new ones.. "
        $SnipeitAliases = Get-SnipeitAlias

    }
    process {
        if ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
            ForEach ($st in $String) {
                $result = $st
                ForEach ($key in $SnipeitAliases.Keys ) {
                    #Write-Verbose "Replacing $key with $($SnipeitAliases[$key])"
                    $result = $result -replace $key, $SnipeitAliases[$key]
                }
                $result
            }
        }
    }
    end{
        Write-Verbose "..replacing done"
    }



}
