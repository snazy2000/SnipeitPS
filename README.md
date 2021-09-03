[![GitHub release](https://img.shields.io/github/release/snazy2000/SnipeitPS.svg)](https://github.com/snazy2000/snipeitps/releases/latest) [![Build status](https://ci.appveyor.com/api/projects/status/dvuw4ggx543nx3h7/branch/master?svg=true)](https://ci.appveyor.com/project/snazy2000/snipeitps/branch/master) [![PowerShell Gallery](https://img.shields.io/powershellgallery/dt/snipeitps.svg)](https://www.powershellgallery.com/packages/snipeitps) ![License](https://img.shields.io/badge/license-MIT-blue.svg)

---

## Want to say thanks?

[![paypal](https://www.paypalobjects.com/en_US/GB/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=XP29MAD7P3WDN&source=url)

## Instructions

### Installation

Install SnipeitPS from the PowerShell Gallery `Install-Module` requires PowerShellGet (included in PS v5, or download for v3/v4 via the gallery link)

```powershell
# One time only install: (requires an admin PowerShell window)
Install-Module SnipeitPS

# Check for updates occasionally:
Update-Module SnipeitPS

# import module to session:
Import-Module SnipeitPS

# Set connection
Connect-SnipeitPS -URL 'https://asset.example.com' -apiKey 'tokenKey'

# Or set connection with safely saved credentials, first save credentials
$SnipeCred =Get-Credential -message "Use url as username and apikey as password"
$SnipeCred | Export-CliXml snipecred.xml

# ..then use your saved credentials like
Connect-SnipeitPS -siteCred (Import-CliXml snipecred.xml)

# OR use -secureApiKey that allow pass apiKey as SecureString
# if you are usin Microsoft.PowerShell.SecretManagement or like
Connect-SnipeitPS -URL 'https://asset.example.com' -secureApiKey 'tokenKey'

```

### Usage

```powershell
# Review the help at any time!
Get-Help about_SnipeitPS
Get-Command -Module SnipeitPS
Get-Help Get-SnipeitAsset -Full   # or any other command
```
### Reporting bugs and issues
Please use -Verbose switch with command you have problem with.
Then create ticket here with all -Verbose output
