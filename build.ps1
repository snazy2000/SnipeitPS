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

function Run-Tests
{
    param(
        [string]$Path = "$PSScriptRoot\SnipeitPS"
    )

    $results = Invoke-Pester -PassThru
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
        "test" {
            Install-Dependency -Name "PSScriptAnalyzer"
            Install-Dependency -Name "Pester"
            Write-Output "Running Pester Tests..."
            Run-Tests
        }
        "release" {
            Register-PSRepository  -Name InternalPowerShellModules `
            -SourceLocation  http://192.168.1.155:81/nuget/DIPowerShell `
            -PackageManagementProvider NuGet  `
            -PublishLocation http://192.168.1.155:81/nuget/DIPowerShell  `
            -InstallationPolicy Trusted

            Write-Output "Registerting Module"

            Import-Module $env:CI_PROJECT_PATH\SnipeitPS\SnipeitPS.psd1 -ErrorAction Stop
            Publish-Module -Name SnipeitPS -Repository InternalPowerShellModules -NuGetApiKey 123456789
        }
    }
}
