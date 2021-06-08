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

### Search
```
<<<<<<< HEAD:docs/Get-SnipeitAsset.md
Get-SnipeitAsset [[-search] <String>] [[-id] <Int32>] [[-asset_tag] <String>] [[-serial] <String>]
 [[-order_number] <String>] [[-model_id] <Int32>] [[-category_id] <Int32>] [[-manufacturer_id] <Int32>]
 [[-company_id] <Int32>] [[-location_id] <Int32>] [[-depreciation_id] <Int32>] [[-requestable] <Boolean>]
 [[-status] <String>] [[-status_id] <Int32>] [[-sort] <String>] [[-order] <String>] [[-limit] <Int32>]
 [[-offset] <Int32>] [-all] [-url] <String> [-apiKey] <String> [<CommonParameters>]
=======
Get-SnipeItAsset [-search <String>] [-order_number <String>] [-model_id <Int32>] [-category_id <Int32>]
 [-manufacturer_id <Int32>] [-company_id <Int32>] [-location_id <Int32>] [-depreciation_id <Int32>]
 [-requestable <Boolean>] [-status <String>] [-status_id <Int32>] [-sort <String>] [-order <String>]
 [-limit <Int32>] [-offset <Int32>] [-all] -url <String> -apiKey <String> [<CommonParameters>]
```

### Get with id
```
Get-SnipeItAsset [-id <Int32>] -url <String> -apiKey <String> [<CommonParameters>]
```

### Get with asset tag
```
Get-SnipeItAsset [-asset_tag <String>] -url <String> -apiKey <String> [<CommonParameters>]
```

### Get with serial
```
Get-SnipeItAsset [-serial <String>] -url <String> -apiKey <String> [<CommonParameters>]
>>>>>>> 9f68e602e32566c28846ccb9572fa0b078d64696:docs/Get-SnipeItAsset.md
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```
Get-SnipeitAsset -url "https://assets.example.com"-token "token..."
```

### EXAMPLE 2
```
Get-SnipeitAsset -search "myMachine"-url "https://assets.example.com"-token "token..."
```

### EXAMPLE 3
```
Get-SnipeitAsset -search "myMachine"-url "https://assets.example.com"-token "token..."
```

### EXAMPLE 4
```
Get-SnipeitAsset -asset_tag "myAssetTag"-url "https://assets.example.com"-token "token..."
```

## PARAMETERS

### -all
A return all results, works with -offset and other parameters

```yaml
Type: SwitchParameter
Parameter Sets: Search
Aliases:

Required: False
Position: Named
Default value: False
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

### -limit
Specify the number of results you wish to return.
Defaults to 50.
Defines batch size for -all

```yaml
Type: Int32
Parameter Sets: Search
Aliases:

Required: False
Position: Named
Default value: 50
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

### -offset
Offset to use

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

### -order
Specify the order (asc or desc) you wish to order by on your sort column

```yaml
Type: String
Parameter Sets: Search
Aliases:

Required: False
Position: Named
Default value: Desc
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

### -sort
Specify the column name you wish to sort by

```yaml
Type: String
Parameter Sets: Search
Aliases:

Required: False
Position: Named
Default value: Created_at
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
