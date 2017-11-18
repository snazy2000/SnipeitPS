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
elseif ($env:releasePath) {
    $releasePath = $env:releasePath
}
else {
    $releasePath = "$($pwd.Path)\Release"
}
$env:PSModulePath = "$($env:PSModulePath);$releasePath"

Import-Module BuildHelpers

# Ensure Invoke-Build works in the most strict mode.
Set-StrictMode -Version Latest

# region debug information
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

# Synopsis: Install pandoc to .\Tools\
task InstallPandoc -If (-not (Test-Path Tools\pandoc.exe)) {
    # Setup
    if (-not (Test-Path "$BuildRoot\Tools")) {
        $null = New-Item -Path "$BuildRoot\Tools" -ItemType Directory
    }

    # Get latest bits
    $latestRelease = "https://github.com/jgm/pandoc/releases/download/1.19.2.1/pandoc-1.19.2.1-windows.msi"
    Invoke-WebRequest -Uri $latestRelease -OutFile "$($env:temp)\pandoc.msi"

    # Extract bits
    $null = New-Item -Path $env:temp\pandoc -ItemType Directory -Force
    Start-Process -Wait -FilePath msiexec.exe -ArgumentList " /qn /a `"$($env:temp)\pandoc.msi`" targetdir=`"$($env:temp)\pandoc\`""

    # Move to Tools folder
    Copy-Item -Path "$($env:temp)\pandoc\Pandoc\pandoc.exe" -Destination "$BuildRoot\Tools\"
    Copy-Item -Path "$($env:temp)\pandoc\Pandoc\pandoc-citeproc.exe" -Destination "$BuildRoot\Tools\"

    # Clean
    Remove-Item -Path "$($env:temp)\pandoc" -Recurse -Force
}
# endregion

# region test
task Test RapidTest

# Synopsis: Using the "Fast" Test Suit
task RapidTest PesterTests
# Synopsis: Using the complete Test Suit, which includes all supported Powershell versions
task FullTest TestVersions

# Synopsis: Warn about not empty git status if .git exists.
task GitStatus -If (Test-Path .git) {
    $status = exec { git status -s }
    if ($status) {
        Write-Warning "Git status: $($status -join ', ')"
    }
}

task TestVersions TestPS3, TestPS4, TestPS4, TestPS5
task TestPS3 {
    exec {powershell.exe -Version 3 -NoProfile Invoke-Build PesterTests}
}
task TestPS4 {
    exec {powershell.exe -Version 4 -NoProfile Invoke-Build PesterTests}
}
task TestPS5 {
    exec {powershell.exe -Version 5 -NoProfile Invoke-Build PesterTests}
}

# Synopsis: Invoke Pester Tests
task PesterTests CreateHelp, {
    try {
        $result = Invoke-Pester -PassThru -OutputFile "$BuildRoot\TestResult.xml" -OutputFormat "NUnitXml"
        if ($env:APPVEYOR_PROJECT_NAME) {
            Add-TestResultToAppveyor -TestFile "$BuildRoot\TestResult.xml"
            Remove-Item "$BuildRoot\TestResult.xml" -Force
        }
        assert ($result.FailedCount -eq 0) "$($result.FailedCount) Pester test(s) failed."
    }
    catch {
        throw
    }
}
# endregion

# region build
# Synopsis: Build shippable release
task Build GenerateRelease, ConvertMarkdown, UpdateManifest

task CreateHelp {
    Import-Module platyPS -Force
    New-ExternalHelp -Path "$BuildRoot\docs" -OutputPath "$BuildRoot\SnipeitPS\en-US" -Force
    Remove-Module SnipeitPS, platyPS
}

# Synopsis: Generate .\Release structure
task GenerateRelease CreateHelp, {
    # Setup
    if (-not (Test-Path "$releasePath\SnipeitPS")) {
        $null = New-Item -Path "$releasePath\SnipeitPS" -ItemType Directory
    }

    # Copy module
    Copy-Item -Path "$BuildRoot\SnipeitPS\*" -Destination "$releasePath\SnipeitPS" -Recurse -Force
    # Copy additional files
    #$additionalFiles = @(
    #    "$BuildRoot\CHANGELOG.md"
        #"$BuildRoot\LICENSE"
        #"$BuildRoot\README.md"
    #)
    #Copy-Item -Path $additionalFiles -Destination "$releasePath\SnipeitPS" -Force
}

# Synopsis: Update the manifest of the module
task UpdateManifest GetVersion, {
    Update-Metadata -Path "$releasePath\SnipeitPS\SnipeitPS.psd1" -PropertyName ModuleVersion -Value $script:Version
    $functionsToExport = Get-ChildItem "$BuildRoot\SnipeitPS\Public" | ForEach-Object {$_.BaseName}
    Set-ModuleFunctions -Name "$releasePath\SnipeitPS\SnipeitPS.psd1" -FunctionsToExport $functionsToExport
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

# Synopsis: Convert markdown files to HTML.
# <http://johnmacfarlane.net/pandoc/>
$ConvertMarkdown = @{
    Inputs  = { Get-ChildItem "$releasePath\SnipeitPS\*.md" -Recurse }
    Outputs = {process {
            [System.IO.Path]::ChangeExtension($_, 'htm')
        }
    }
}
# Synopsis: Converts *.md and *.markdown files to *.htm
task ConvertMarkdown -Partial @ConvertMarkdown InstallPandoc, {process {
        exec { Tools\pandoc.exe $_ --standalone --from=markdown_github "--output=$2" }
    }
}, RemoveMarkdownFiles
# endregion

#region Cleaning tasks
task Clean RemoveGeneratedFiles

# Synopsis: Remove generated and temp files.
task RemoveGeneratedFiles {
    $itemsToRemove = @(
        'Release'
        '*.htm'
        'TestResult.xml'
        'SnipeitPS\en-US\*'
    )
    Remove-Item $itemsToRemove -Force -Recurse -ErrorAction 0
}

task RemoveMarkdownFiles {
    Remove-Item "$releasePath\SnipeitPS\*.md" -Force -ErrorAction 0
}
# endregion

task . ShowDebug, Clean, Test, Build, Deploy