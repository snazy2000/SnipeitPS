# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/),
and this project adheres to [Semantic Versioning](http://semver.org/).

# [v1.4.x] - 2021-05-27

## More Activity

### New features
SnipeIt activity history is now searchable. So finding out checked out the
assest its easy. Api support many different target or item types that can
be uses as filter. Searchable types are 'Accessory','Asset','AssetMaintenance'
,'AssetModel','Category','Company','Component','Consumable','CustomField',
,'Group','Licence','LicenseSeat','Location','Manufacturer','Statuslabel',
'Supplier','User'


### New Functions
- Get-SnipeItActivity Get and search Snipe-It change history.


# [v1.3.x] - 2021-05-27

## Checking out accessories

### New features
You can specify Put or Patch for  Set-SnipeItAsset when updating assets.
Set-SnipeItLocation new -city parameter

### New Functions
- Set-SnipeItAccessoryOwner checkout accessory
- Get-SnipeItAccessoryOwner list checkedout accessories
- Reset-SnipeItAccessoryOwner checkin accessory

### Fixes
- Set-SnipeItAsset fixed datetime and name inputs #126,128
-

# [v1.2.x] - 2021-05-24

## Prefixing SnipeItPS

### New Features
All commands are now prefixed like Set-Info -> Set-SnipeItInfo.
To keep compatibility all old commands are available as aliases.
To update existing scripts theres Update-SnipeItAlias command.

### New fuctions
- Update-SnipeitAlias Tool to update existing scripts
- Get-SnipeItLicenceSeat lists license seats
- Set-SnipeItLicenseSeat Set and checkouts/in license seats
Licenseseat api is supported from Snipe-It release => v5.1.5

### New fixes
Added -id parameter support to support Get-SnipeItCustomField and
Get-SnipeItFieldSet commands

# [v1.1.x] - 2021-05-18

## Pull request rollup release. Lots of new features including:

### New features
- Powershell 7 compatibility. So you can use SnipeItPS on macos or linux .
- Get every asset, model, licence with snipeit id by using -id parameter
- Get assets also by -asset_tag -or serialnumber
- Get functions also return all results from snipe when using -all parameter (by @PetriAsi)

### New functions
- Reset-AssetOwner by @lunchboxrts
- Remove-Asset by @sheppyh
- Added Remove-AssetMaintenance by @sheppyh
- Remove-User @gvoynov

### Fixes
- Fixed version number on powershell gallery
- Fixed Set-AssetOwner when checking asset out to an other asset.

## [v1.0] - 2017-11-18
