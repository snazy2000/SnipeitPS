# Change Log

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/),
and this project adheres to [Semantic Versioning](http://semver.org/).

# [v.1.9.x] - 2021-07-14

## Image uploads

## New features
Support for image upload and removes. Just specify filename for -image para-
meter when creating or updating item on snipe.
Remove image use -image_delete parameter.

*Snipe It version greater than 5.1.8 is needed to support image parameters.*

Most of set-commands have new -RequestType parameter that defaults to Patch.
If needed request method can be changed from default.

## New Functions
Following new commands have been added to SnipeitPS:
- New-Supplier
- Set-Supplier
- Remove-Supplier
- Set-Manufacturer


# [v.1.8.x] - 2021-06-17

## Support for new Snipe it endpoints

## New features

Get-SnipeitAccessories -user_id
returns accessories checked out to user id

Get-SnipeitAsset -user_id
Return Assets checked out to user id

Get-SnipeitAsset -component_id
Returns assets with specific component id

Get-SnipeitLicense -user_id
Get licenses checked out to user ID

Get-SnipeitLicense -asset_id
Get licenses checked out to asset ID

Get-SnipeitUser -accessory_id
Get users that have specific accessory id checked out

# [v.1.7.x] - 2021-06-14

## Consumables

## New features
Added support for consumables

## New functions
- New-SnipeitConsumable
- Get-SnipeitConsumable
- Set-SnipeitConsumable
- Remove-SnipeitConsumable


# [v.1.6.x] - 2021-06-14

## Remove more things ja set some more

### New features
Added some set and remove functions. Pipelineinput supported
for all remove functions.

### New functions
 - Remove-SnipeitAccessory
 - Remove-SnipeitCategory
 - Remove-SnipeitCompany
 - Remove-SnipeitComponent
 - Remove-SnipeitCustomField
 - Remove-SnipeitDepartment
 - Remove-SnipeitLicense
 - Remove-SnipeitLocation
 - Remove-SnipeitManufacturer
 - Remove-SnipeitModel
 - Set-SnipeitCategory
 - Set-SnipeitCompany
 - Set-SnipeitCustomField
 - Set-SnipeitDepartment
 - Set-SnipeitStatus


# [v1.5.x] - 2021-06-08

## Piping input

### New features
Most of "Set" command accepts piped input. Piped objects "id" attribute
is used to select asset set values. Like
Get-SnipeitAsset -model_id 213 | Set-SnipeitAsset -notes 'This is nice!'

Set command accept id parameter as array, so its easier to set multiple items
in one run.

Parameter sets. Get commands have now parameters sets.This will make syntax more
clear between search and get by ID use. Use get-help to

### Fixes
-Empty strings are accepted as input so it's possible to wipe field values if
needed

# [v1.4.x] - 2021-05-27

## More Activity

### New features
Snipeit activity history is now searchable. So finding out checked out the
assest its easy. Api support many different target or item types that can
be uses as filter. Searchable types are 'Accessory','Asset','AssetMaintenance'
,'AssetModel','Category','Company','Component','Consumable','CustomField',
,'Group','Licence','LicenseSeat','Location','Manufacturer','Statuslabel',
'Supplier','User'


### New Functions
- Get-SnipeitActivity Get and search Snipe-It change history.


# [v1.3.x] - 2021-05-27

## Checking out accessories

### New features
You can specify Put or Patch for  Set-SnipeitAsset when updating assets.
Set-SnipeitLocation new -city parameter

### New Functions
- Set-SnipeitAccessoryOwner checkout accessory
- Get-SnipeitAccessoryOwner list checkedout accessories
- Reset-SnipeitAccessoryOwner checkin accessory

### Fixes
- Set-SnipeitAsset fixed datetime and name inputs #126,128
-

# [v1.2.x] - 2021-05-24

## Prefixing SnipeitPS

### New Features
All commands are now prefixed like Set-Info -> Set-SnipeitInfo.
To keep compatibility all old commands are available as aliases.
To update existing scripts theres Update-SnipeitAlias command.

### New fuctions
- Update-SnipeitAlias Tool to update existing scripts
- Get-SnipeitLicenceSeat lists license seats
- Set-SnipeitLicenseSeat Set and checkouts/in license seats
Licenseseat api is supported from Snipe-It release => v5.1.5

### New fixes
Added -id parameter support to support Get-SnipeitCustomField and
Get-SnipeitFieldSet commands

# [v1.1.x] - 2021-05-18

## Pull request rollup release. Lots of new features including:

### New features
- Powershell 7 compatibility. So you can use SnipeitPS on macos or linux .
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
