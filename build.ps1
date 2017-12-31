param(
    [string[]]$Tasks
)

function Install-Dependency([string] $Name)
{
    $policy = Get-PSRepository -Name "PSGallery" | Select-Object -ExpandProperty "InstallationPolicy"
    if($policy -ne "Trusted") {
        Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
    }

    if (!(Get-Module -Name $Name -ListAvailable)) {
        Install-Module -Name $Name -Scope CurrentUser
    }
}

function Analyze-Scripts
{
    param(
        [string]$Path = "$PSScriptRoot\SnipeitPS\"
    )
    $result = Invoke-ScriptAnalyzer -Path $Path -Severity @('Error', 'Warning') -Recurse
    if ($result) {
       $result | Format-Table
       Write-Error -Message "$($result.SuggestedCorrections.Count) linting errors or warnings were found. The build cannot continue."
       EXIT 1
    }
}

function Run-Tests
{
    param(
        [string]$Path = "$PSScriptRoot\SnipeitPS"
    )

    $results = Invoke-Pester -Path $Path -PassThru
    if($results.FailedCount -gt 0) {
       Write-Output "  > $($results.FailedCount) tests failed. The build cannot continue."
       foreach($result in $($results.TestResult | Where {$_.Passed -eq $false} | Select-Object -Property Describe,Context,Name,Passed,Time)){
            Write-Output "    > $result"
       }

       EXIT 1
    }
}

foreach($task in $Tasks){
    switch($task)
    {
        "analyze" {
            Install-Dependency -Name "PSScriptAnalyzer"
            Write-Output "Analyzing Scripts..."
            Analyze-Scripts
        }
        "test" {
            Install-Dependency -Name "Pester"
            Write-Output "Running Pester Tests..."
            Run-Tests
        }
    }
}
