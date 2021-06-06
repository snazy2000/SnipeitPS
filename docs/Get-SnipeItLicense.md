---
external help file: SnipeItPS-help.xml
Module Name: SnipeitPS
online version:
schema: 2.0.0
---

# Get-SnipeItLicense

## SYNOPSIS
Gets a list of Snipe-it Licenses

## SYNTAX

```
Get-SnipeItLicense [[-search] <String>] [[-id] <Int32>] [[-name] <String>] [[-company_id] <Int32>]
 [[-product_key] <String>] [[-order_number] <String>] [[-purchase_order] <String>] [[-license_name] <String>]
 [[-license_email] <MailAddress>] [[-manufacturer_id] <Int32>] [[-supplier_id] <Int32>]
 [[-depreciation_id] <Int32>] [[-category_id] <Int32>] [[-order] <String>] [[-sort] <String>]
 [[-limit] <Int32>] [[-offset] <Int32>] [-all] [-url] <String> [-apiKey] <String> [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```
Get-SnipeItLicense -search SomeLicense
```

### EXAMPLE 2
```
Get-SnipeItLicense -id 1
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
Position: 19
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -category_id
{{ Fill category_id Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -company_id
{{ Fill company_id Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
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
Position: 12
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
A id of specific License

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

### -license_email
{{ Fill license_email Description }}

```yaml
Type: MailAddress
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -license_name
{{ Fill license_name Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
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
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: 50
Accept pipeline input: False
Accept wildcard characters: False
```

### -manufacturer_id
{{ Fill manufacturer_id Description }}

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

### -name
{{ Fill name Description }}

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

### -offset
Offset to use

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -order
{{ Fill order Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: Desc
Accept pipeline input: False
Accept wildcard characters: False
```

### -order_number
{{ Fill order_number Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -product_key
{{ Fill product_key Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -purchase_order
{{ Fill purchase_order Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -search
A text string to search the Licenses data

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

### -sort
{{ Fill sort Description }}

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

### -supplier_id
{{ Fill supplier_id Description }}

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

### -url
URL of Snipeit system, can be set using Set-SnipeItInfo command

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 18
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
