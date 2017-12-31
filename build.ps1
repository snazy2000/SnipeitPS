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

function Release
{
    Write-Output "Setting Variables"
    $BuildRoot = $env:CI_PROJECT_DIR
    $releasePath = "$BuildRoot\Release"

    Write-Output "Build Root : $BuildRoot"
    Write-Output "Release Root : $releasePath"

    if (-not (Test-Path "$releasePath\SnipeitPS")) {
        $null = New-Item -Path "$releasePath\SnipeitPS" -ItemType Directory
    }

    # Copy module
    Copy-Item -Path "$BuildRoot\SnipeitPS\*" -Destination "$releasePath\SnipeitPS" -Recurse -Force
    # Copy additional files
    $additionalFiles = @(
        "$BuildRoot\CHANGELOG.md"
        "$BuildRoot\LICENSE"
        "$BuildRoot\README.md"
    )
    Copy-Item -Path $additionalFiles -Destination "$releasePath\SnipeitPS" -Force


    $manifestContent = Get-Content -Path "$releasePath\SnipeitPS\SnipeitPS.psd1" -Raw
    if ($manifestContent -notmatch '(?<=ModuleVersion\s+=\s+'')(?<ModuleVersion>.*)(?='')') {
        throw "Module version was not found in manifest file,"
    }

    $currentVersion = [Version] $Matches.ModuleVersion
    if ($env:CI_JOB_ID) {
        $newRevision = $env:CI_JOB_ID
    }
    else {
        $newRevision = 0
    }
    $version = New-Object -TypeName System.Version -ArgumentList $currentVersion.Major,
    $currentVersion.Minor,
    $newRevision

    Write-Output "New version : $version"

    Update-Metadata -Path "$releasePath\SnipeitPS\SnipeitPS.psd1" -PropertyName ModuleVersion -Value $version
    $functionsToExport = Get-ChildItem "$BuildRoot\SnipeitPS\SnipeitPS\Public" | ForEach-Object {$_.BaseName}
    Set-ModuleFunctions -Name "$releasePath\SnipeitPS\SnipeitPS.psd1" -FunctionsToExport $functionsToExport

    Remove-Module SnipeitPS
    Import-Module $env:CI_PROJECT_DIR\SnipeitPS\SnipeitPS.psd1 -ErrorAction Stop
    Publish-Module -Name SnipeitPS -Repository InternalPowerShellModules -NuGetApiKey 123456789
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
            Write-Output "Releasing..."
            Release
        }
    }
}
