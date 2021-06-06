---
external help file: SnipeItPS-help.xml
Module Name: SnipeitPS
online version:
schema: 2.0.0
---

# Get-SnipeItAsset

## SYNOPSIS
Gets a list of Snipe-it Assets or specific asset

## SYNTAX

```
Get-SnipeItAsset [[-search] <String>] [[-id] <Int32>] [[-asset_tag] <String>] [[-serial] <String>]
 [[-order_number] <String>] [[-model_id] <Int32>] [[-category_id] <Int32>] [[-manufacturer_id] <Int32>]
 [[-company_id] <Int32>] [[-location_id] <Int32>] [[-depreciation_id] <Int32>] [[-requestable] <Boolean>]
 [[-status] <String>] [[-status_id] <Int32>] [[-sort] <String>] [[-order] <String>] [[-limit] <Int32>]
 [[-offset] <Int32>] [-all] [-url] <String> [-apiKey] <String> [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```
Get-SnipeItAsset -url "https://assets.example.com"-token "token..."
```

### EXAMPLE 2
```
Get-SnipeItAsset -search "myMachine"-url "https://assets.example.com"-token "token..."
```

### EXAMPLE 3
```
Get-SnipeItAsset -search "myMachine"-url "https://assets.example.com"-token "token..."
```

### EXAMPLE 4
```
Get-SnipeItAsset -asset_tag "myAssetTag"-url "https://assets.example.com"-token "token..."
```

## PARAMETERS

### -all
A return all results, works with -offset and other parameters

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -apiKey
Users API Key for Snipeit, can be set using Set-SnipeItInfo command

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 20
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -asset_tag
Exact asset tag to query

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -category_id
Optionally restrict asset results to this category ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -company_id
Optionally restrict asset results to this company ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -depreciation_id
{{ Fill depreciation_id Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
ID number of excact snipeit asset

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
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
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: 50
Accept pipeline input: False
Accept wildcard characters: False
```

### -location_id
Optionally restrict asset results to this location ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -manufacturer_id
Optionally restrict asset results to this manufacturer ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -model_id
Optionally restrict asset results to this asset model ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -offset
Offset to use

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -order
Specify the order (asc or desc) you wish to order by on your sort column

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: Desc
Accept pipeline input: False
Accept wildcard characters: False
```

### -order_number
Optionally restrict asset results to this order number

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -requestable
{{ Fill requestable Description }}

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -search
A text string to search the assets data

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -serial
{{ Fill serial Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases: asset_serial

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -sort
Specify the column name you wish to sort by

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: Created_at
Accept pipeline input: False
Accept wildcard characters: False
```

### -status
Optionally restrict asset results to one of these status types: RTD, Deployed, Undeployable, Deleted, Archived, Requestable

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -status_id
Optionally restrict asset results to this status label ID

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -url
URL of Snipeit system, can be set using Set-SnipeItInfo command

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 19
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
