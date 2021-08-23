---
external help file: SnipeitPS-help.xml
Module Name: snipeitps
online version:
schema: 2.0.0
---

# Set-SnipeitCategory

## SYNOPSIS
Create a new Snipe-IT Category

## SYNTAX

```
Set-SnipeitCategory [-id] <Int32[]> [[-name] <String>] [[-category_type] <String>] [[-eula_text] <String>]
 [[-use_default_eula] <Boolean>] [[-require_acceptance] <Boolean>] [[-checkin_email] <Boolean>]
 [[-image] <String>] [-image_delete] [[-RequestType] <String>] [[-url] <String>] [[-apiKey] <String>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```
Set-SnipeitCategory -id 4 -name "Laptops"
```

## PARAMETERS

### -apiKey
Deprecated parameter, please use Connect-SnipeitPS instead.
Users API Key API Key for Snipeit.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -category_type
{{ Fill category_type Description }}

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

### -checkin_email
Should the user be emailed the EULA and/or an acceptance confirmation email when this item is checked in?

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -eula_text
This allows you to customize your EULAs for specific types of assets

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
{{ Fill id Description }}

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -image
Image file name and path for item

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

### -image_delete
Remove current image

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

### -name
Name of new category to be created

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RequestType
Http request type to send Snipe IT system.
Defaults to Patch you could use Put if needed.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: Patch
Accept pipeline input: False
Accept wildcard characters: False
```

### -require_acceptance
If switch is present, require users to confirm acceptance of assets in this category

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -url
Deprecated parameter, please use Connect-SnipeitPS instead.
URL of Snipeit system.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -use_default_eula
If switch is present, use the primary default EULA

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
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
