---
external help file: SnipeitPS-help.xml
Module Name: SnipeitPS
online version:
schema: 2.0.0
---

# Get-SnipeitAsset

## SYNOPSIS
Gets a list of Snipe-it Assets or specific asset

## SYNTAX

### Search (Default)
```
Get-SnipeitAsset [-search <String>] [-order_number <String>] [-model_id <Int32>] [-category_id <Int32>]
 [-manufacturer_id <Int32>] [-company_id <Int32>] [-location_id <Int32>] [-depreciation_id <Int32>]
 [-requestable <Boolean>] [-status <String>] [-status_id <Int32>] [-sort <String>] [-order <String>]
 [-limit <Int32>] [-offset <Int32>] [-all] -url <String> -apiKey <String> [<CommonParameters>]
```

### Get with id
```
Get-SnipeitAsset [-id <Int32>] -url <String> -apiKey <String> [<CommonParameters>]
```

### Get with asset tag
```
Get-SnipeitAsset [-asset_tag <String>] -url <String> -apiKey <String> [<CommonParameters>]
```

### Get with serial
```
Get-SnipeitAsset [-serial <String>] -url <String> -apiKey <String> [<CommonParameters>]
```

### Assets due auditing soon
```
Get-SnipeitAsset [-audit_due] [-sort <String>] [-order <String>] [-limit <Int32>] [-offset <Int32>] [-all]
 -url <String> -apiKey <String> [<CommonParameters>]
```

### Assets overdue for auditing
```
Get-SnipeitAsset [-audit_overdue] [-sort <String>] [-order <String>] [-limit <Int32>] [-offset <Int32>] [-all]
 -url <String> -apiKey <String> [<CommonParameters>]
```

### Assets checked out to user id
```
Get-SnipeitAsset [-user_id <Int32>] [-sort <String>] [-order <String>] [-limit <Int32>] [-offset <Int32>]
 [-all] -url <String> -apiKey <String> [<CommonParameters>]
```

### Assets with component id
```
Get-SnipeitAsset [-component_id <Int32>] [-sort <String>] [-order <String>] [-limit <Int32>] [-offset <Int32>]
 [-all] -url <String> -apiKey <String> [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```
Get-SnipeitAsset -all -url "https://assets.example.com"-token "token..."
Returens all assets
```

### EXAMPLE 2
```
Get-SnipeitAsset -search "myMachine"
Search for specific asset
```

### EXAMPLE 3
```
Get-SnipeitAsset -id 3
Get asset with id number 3
```

### EXAMPLE 4
```
Get-SnipeitAsset -asset_tag snipe0003
Get asset with asset tag snipe00033
```

### EXAMPLE 5
```
Get-SnipeitAsset -serial 1234
Get asset with searial number 1234
```

### EXAMPLE 6
```
Get-SnipeitAsser -audit_due
Get Assets due auditing soon
```

### EXAMPLE 7
```
Get-SnipeitAsser -audit_overdue
Get Assets overdue for auditing
```

### EXAMPLE 8
```
Get-AnipeitAsset -user_id 4
Get Assets checked out to user id 4
```

### EXAMPLE 9
```
Get-SnipeitAsset -component_id 5
Get Assets with component id 5
```

## PARAMETERS

### -search
A text string to search the assets data

```yaml
Type: String
Parameter Sets: Search
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
ID number of excact snipeit asset

```yaml
Type: Int32
Parameter Sets: Get with id
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -asset_tag
Exact asset tag to query

```yaml
Type: String
Parameter Sets: Get with asset tag
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -serial
{{ Fill serial Description }}

```yaml
Type: String
Parameter Sets: Get with serial
Aliases: asset_serial

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -audit_due
Retrieve a list of assets that are due for auditing soon.

```yaml
Type: SwitchParameter
Parameter Sets: Assets due auditing soon
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -audit_overdue
Retrieve a list of assets that are overdue for auditing.

```yaml
Type: SwitchParameter
Parameter Sets: Assets overdue for auditing
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -user_id
{{ Fill user_id Description }}

```yaml
Type: Int32
Parameter Sets: Assets checked out to user id
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -component_id
{{ Fill component_id Description }}

```yaml
Type: Int32
Parameter Sets: Assets with component id
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -order_number
Optionally restrict asset results to this order number

```yaml
Type: String
Parameter Sets: Search
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -model_id
Optionally restrict asset results to this asset model ID

```yaml
Type: Int32
Parameter Sets: Search
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -category_id
Optionally restrict asset results to this category ID

```yaml
Type: Int32
Parameter Sets: Search
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -manufacturer_id
Optionally restrict asset results to this manufacturer ID

```yaml
Type: Int32
Parameter Sets: Search
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -company_id
Optionally restrict asset results to this company ID

```yaml
Type: Int32
Parameter Sets: Search
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -location_id
Optionally restrict asset results to this location ID

```yaml
Type: Int32
Parameter Sets: Search
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -depreciation_id
{{ Fill depreciation_id Description }}

```yaml
Type: Int32
Parameter Sets: Search
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -requestable
{{ Fill requestable Description }}

```yaml
Type: Boolean
Parameter Sets: Search
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -status
Optionally restrict asset results to one of these status types: RTD, Deployed, Undeployable, Deleted, Archived, Requestable

```yaml
Type: String
Parameter Sets: Search
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -status_id
Optionally restrict asset results to this status label ID

```yaml
Type: Int32
Parameter Sets: Search
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -sort
Specify the column name you wish to sort by

```yaml
Type: String
Parameter Sets: Search, Assets due auditing soon, Assets overdue for auditing, Assets checked out to user id, Assets with component id
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -order
Specify the order (asc or desc) you wish to order by on your sort column

```yaml
Type: String
Parameter Sets: Search, Assets due auditing soon, Assets overdue for auditing, Assets checked out to user id, Assets with component id
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -limit
Specify the number of results you wish to return.
Defaults to 50.
Defines batch size for -all

```yaml
Type: Int32
Parameter Sets: Search, Assets due auditing soon, Assets overdue for auditing, Assets checked out to user id, Assets with component id
Aliases:

Required: False
Position: Named
Default value: 50
Accept pipeline input: False
Accept wildcard characters: False
```

### -offset
Offset to use

```yaml
Type: Int32
Parameter Sets: Search, Assets due auditing soon, Assets overdue for auditing, Assets checked out to user id, Assets with component id
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -all
A return all results, works with -offset and other parameters

```yaml
Type: SwitchParameter
Parameter Sets: Search, Assets due auditing soon, Assets overdue for auditing, Assets checked out to user id, Assets with component id
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -url
URL of Snipeit system, can be set using Set-SnipeitInfo command

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -apiKey
Users API Key for Snipeit, can be set using Set-SnipeitInfo command

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
