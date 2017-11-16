[CmdletBinding()]
param()

$DebugPreference = "SilentlyContinue"
$WarningPreference = "Continue"
if ($PSBoundParameters.ContainsKey('Verbose')) {
    $VerbosePreference = "Continue"
}

if (!($env:releasePath)) {
    $releasePath = "$BuildRoot\Release"
}
else {
    $releasePath = $env:releasePath
}
$env:PSModulePath = "$($env:PSModulePath);$releasePath"


# Ensure Invoke-Build works in the most strict mode.
Set-StrictMode -Version Latest


# region build
# Synopsis: Build shippable release
task Build GenerateRelease, UpdateManifest

# Synopsis: Generate .\Release structure
task GenerateRelease {
    # Setup
    if (-not (Test-Path "$releasePath\SnipeitPS")) {
        $null = New-Item -Path "$releasePath\SnipeitPS" -ItemType Directory
    }

    # Copy module
    Copy-Item -Path "$BuildRoot\SnipeitPS\*" -Destination "$releasePath\SnipeitPS" -Recurse -Force
    # Copy additional files
    <#$additionalFiles = @(
        "$BuildRoot\CHANGELOG.md"
        "$BuildRoot\LICENSE"
        "$BuildRoot\README.md"
    )
    Copy-Item -Path $additionalFiles -Destination "$releasePath\SnipeitPS" -Force#>
}

# Synopsis: Update the manifest of the module
task UpdateManifest GetVersion, {
    $ModuleAlias = (Get-Alias | Where source -eq JiraPS)

    Remove-Module JiraPS -ErrorAction SilentlyContinue
    Import-Module "$releasePath\SnipeitPS\SnipeitPS.psd1"
    Update-Metadata -Path "$releasePath\SnipeitPS\SnipeitPS.psd1" -PropertyName ModuleVersion -Value $script:Version
    # Update-Metadata -Path "$releasePath\SnipeitPS\SnipeitPS.psd1" -PropertyName FileList -Value (Get-ChildItem $releasePath\SnipeitPS -Recurse).Name
    if ($ModuleAlias) {
        Update-Metadata -Path "$releasePath\SnipeitPS\SnipeitPS.psd1" -PropertyName AliasesToExport -Value @($ModuleAlias.Name)
    }
    Set-ModuleFunctions -Name "$releasePath\SnipeitPS\SnipeitPS.psd1" -FunctionsToExport ([string[]](Get-ChildItem "$releasePath\SnipeitPS\public\*.ps1").BaseName)
}

task GetVersion {
    $manifestContent = Get-Content -Path "$releasePath\SnipeitPS\SnipeitPS.psd1" -Raw
    if ($manifestContent -notmatch '(?<=ModuleVersion\s+=\s+'')(?<ModuleVersion>.*)(?='')') {
        throw "Module version was not found in manifest file,"
    }

    $currentVersion = [Version] $Matches.ModuleVersion
    if ($env:APPVEYOR_BUILD_NUMBER) {
        $newRevision = $env:APPVEYOR_BUILD_NUMBER
    }
    else {
        $newRevision = 0
    }
    $script:Version = New-Object -TypeName System.Version -ArgumentList $currentVersion.Major,
    $currentVersion.Minor,
    $newRevision
}


# endregion


#region Cleaning tasks
task Clean RemoveGeneratedFiles
# Synopsis: Remove generated and temp files.
task RemoveGeneratedFiles {
    $itemsToRemove = @(
        'Release'
        '*.htm'
        'TestResult.xml'
    )
    Remove-Item $itemsToRemove -Force -Recurse -ErrorAction 0
}



task . Build, Clean