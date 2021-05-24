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
        Write-Verbose "..replacing done 1 "
    }



}
