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

task ShowDebug {
    Write-Build Gray
    Write-Build Gray ('Project name:               {0}' -f $env:APPVEYOR_PROJECT_NAME)
    Write-Build Gray ('Project root:               {0}' -f $env:APPVEYOR_BUILD_FOLDER)
    Write-Build Gray ('Repo name:                  {0}' -f $env:APPVEYOR_REPO_NAME)
    Write-Build Gray ('Branch:                     {0}' -f $env:APPVEYOR_REPO_BRANCH)
    Write-Build Gray ('Commit:                     {0}' -f $env:APPVEYOR_REPO_COMMIT)
    Write-Build Gray ('  - Author:                 {0}' -f $env:APPVEYOR_REPO_COMMIT_AUTHOR)
    Write-Build Gray ('  - Time:                   {0}' -f $env:APPVEYOR_REPO_COMMIT_TIMESTAMP)
    Write-Build Gray ('  - Message:                {0}' -f $env:APPVEYOR_REPO_COMMIT_MESSAGE)
    Write-Build Gray ('  - Extended message:       {0}' -f $env:APPVEYOR_REPO_COMMIT_MESSAGE_EXTENDED)
    Write-Build Gray ('Pull request number:        {0}' -f $env:APPVEYOR_PULL_REQUEST_NUMBER)
    Write-Build Gray ('Pull request title:         {0}' -f $env:APPVEYOR_PULL_REQUEST_TITLE)
    Write-Build Gray ('AppVeyor build ID:          {0}' -f $env:APPVEYOR_BUILD_ID)
    Write-Build Gray ('AppVeyor build number:      {0}' -f $env:APPVEYOR_BUILD_NUMBER)
    Write-Build Gray ('AppVeyor build version:     {0}' -f $env:APPVEYOR_BUILD_VERSION)
    Write-Build Gray ('AppVeyor job ID:            {0}' -f $env:APPVEYOR_JOB_ID)
    Write-Build Gray ('Build triggered from tag?   {0}' -f $env:APPVEYOR_REPO_TAG)
    Write-Build Gray ('  - Tag name:               {0}' -f $env:APPVEYOR_REPO_TAG_NAME)
    Write-Build Gray ('PowerShell version:         {0}' -f $PSVersionTable.PSVersion.ToString())
    Write-Build Gray
}

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
    Set-ModuleFunctions -Name "$releasePath\SnipeitPS\SnipeitPS.psd1" -FunctionsToExport ([string[]](Get-ChildItem "SnipeitPS\public\*.psm1").BaseName)
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