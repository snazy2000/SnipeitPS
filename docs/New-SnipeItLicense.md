---
external help file: SnipeItPS-help.xml
Module Name: SnipeitPS
online version:
schema: 2.0.0
---

# New-SnipeItLicense

## SYNOPSIS
Creates a licence

## SYNTAX

```
New-SnipeItLicense [-name] <String> [-seats] <Int32> [[-category_id] <Int32>] [[-company_id] <Int32>]
 [[-expiration_date] <DateTime>] [[-license_email] <MailAddress>] [[-license_name] <String>]
 [[-maintained] <Boolean>] [[-manufacturer_id] <Int32>] [[-notes] <String>] [[-order_number] <String>]
 [[-purchase_cost] <Single>] [[-purchase_date] <DateTime>] [[-reassignable] <Boolean>] [[-serial] <String>]
 [[-supplier_id] <Int32>] [[-termination_date] <DateTime>] [-url] <String> [-apiKey] <String> [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Creates a new licence on Snipe-It system

## EXAMPLES

### EXAMPLE 1
```
New-Licence -name "License" -seats 3 -company_id 1
```

## PARAMETERS

### -apiKey
Users API Key for Snipeit, can be set using Set-Info command

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
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -company_id
Id number of company license belongs to

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

### -expiration_date
Date of license expiration

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -license_email
Email address associated with license

```yaml
Type: MailAddress
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -license_name
Name of license contact person

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

### -maintained
Maintained status of license

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -manufacturer_id
ID number of manufacturer of license.

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

### -name
Name of license being created

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -notes
License Notes

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

### -order_number
Order number of license purchase

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

### -purchase_cost
Cost of license

```yaml
Type: Single
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -purchase_date
Date of license purchase

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -reassignable
Is license reassignable?

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -seats
Number of license seats owned.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -serial
Serialnumber  of license

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -supplier_id
ID number of license supplier

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -termination_date
Termination date for license.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -url
URL of Snipeit system, can be set using Set-Info command

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
