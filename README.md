[![GitHub release](https://img.shields.io/github/release/snazy2000/SnipeitPS.svg)](https://github.com/snazy2000/snipeitps/releases/latest) [![Build status](https://ci.appveyor.com/api/projects/status/dvuw4ggx543nx3h7/branch/master?svg=true)](https://ci.appveyor.com/project/snazy2000/snipeitps/branch/master) [![PowerShell Gallery](https://img.shields.io/powershellgallery/dt/snipeitps.svg)](https://www.powershellgallery.com/packages/snipeitps) ![License](https://img.shields.io/badge/license-MIT-blue.svg)

---

## Instructions

### Installation

Install SnipeitPS from the PowerShell Gallery `Install-Module` requires PowerShellGet (included in PS v5, or download for v3/v4 via the gallery link)

```powershell
# One time only install: (requires an admin PowerShell window)
Install-Module SnipeitPS

# Check for updates occasionally:
Update-Module SnipeitPS

# To use each session:
Import-Module SnipeitPS
Set-Info -URL 'https://asset.example.com' -apiKey 'tokenKey'
```

### Usage

```powershell
# Review the help at any time!
Get-Help about_SnipeitPS
Get-Command -Module SnipeitPS
Get-Help Get-Asset -Full   # or any other command
```
