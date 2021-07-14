---
external help file: SnipeitPS-help.xml
Module Name: SnipeitPS
online version:
schema: 2.0.0
---

# Set-SnipeitConsumable

## SYNOPSIS
Add a new Consumable to Snipe-it asset system

## SYNTAX

```
Set-SnipeitConsumable [-id] <Int32[]> [[-name] <String>] [[-qty] <Int32>] [[-category_id] <Int32>]
 [[-min_amt] <Int32>] [[-company_id] <Int32>] [[-order_number] <String>] [[-manufacturer_id] <Int32>]
 [[-location_id] <Int32>] [[-requestable] <Boolean>] [[-purchase_date] <DateTime>] [[-purchase_cost] <String>]
 [[-model_number] <String>] [[-item_no] <String>] [[-image] <String>] [-image_delete] [[-RequestType] <String>]
 [-url] <String> [-apiKey] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Long description

## EXAMPLES

### EXAMPLE 1
```
New-Snipeitconsumable -name "Ink pack"  -qty 20 -category_id 3 -min_amt 5
Create consumable with stock count 20 , alert when stock is  5 or lower
```

## PARAMETERS

### -apiKey
Users API Key for Snipeit, can be set using Set-SnipeitInfo command

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

### -category_id
Required Category ID of the Consumable, this can be got using Get-SnipeitCategory

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

### -company_id
Optional Company id

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
Optional  id number of the Consumable

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
Position: 15
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

### -item_no
Item number for the consumable

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -location_id
Location id number of the consumable

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -manufacturer_id
Manufaturer id number of the consumable

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -min_amt
Optional minimum quantity of comsumable

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -model_number
Model number of the consumable in months

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

### -name
Optional  Name of the Consumable

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

### -order_number
Optional Order number

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

### -purchase_cost
Optional Purchase cost of the consumable

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -purchase_date
Optional Purchase cost of the consumable

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -qty
Optional Quantity of comsumable

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

### -requestable
Is consumable requestable?

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: False
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
Position: 16
Default value: Patch
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
Position: 17
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
