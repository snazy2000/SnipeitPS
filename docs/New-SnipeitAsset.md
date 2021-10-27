---
external help file: SnipeitPS-help.xml
Module Name: SnipeitPS
online version:
schema: 2.0.0
---

# New-SnipeitAsset

## SYNOPSIS
Add a new Asset to Snipe-it asset system

## SYNTAX

### Create asset (Default)
```
New-SnipeitAsset -status_id <Int32> -model_id <Int32> [-name <String>] [-asset_tag <String>] [-serial <String>]
 [-company_id <Int32>] [-order_number <String>] [-notes <String>] [-warranty_months <Int32>]
 [-purchase_cost <String>] [-purchase_date <DateTime>] [-supplier_id <Int32>] [-rtd_location_id <Int32>]
 [-image <String>] [-url <String>] [-apiKey <String>] [-customfields <Hashtable>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### Checkout asset when creating
```
New-SnipeitAsset -status_id <Int32> -model_id <Int32> [-name <String>] [-asset_tag <String>] [-serial <String>]
 [-company_id <Int32>] [-order_number <String>] [-notes <String>] [-warranty_months <Int32>]
 [-purchase_cost <String>] [-purchase_date <DateTime>] [-supplier_id <Int32>] [-rtd_location_id <Int32>]
 [-image <String>] -assigned_id <Int32> -checkout_to_type <String> [-url <String>] [-apiKey <String>]
 [-customfields <Hashtable>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Long description

## EXAMPLES

### EXAMPLE 1
```
New-SnipeitAsset -status_id 1 -model_id 1 -name "Machine1"
Create asset with automatic tag if tag genaration is enabled on snipe-it, other wise without tag
```

### EXAMPLE 2
```
New-SnipeitAsset -status_id 1 -model_id 1 -name "Machine1" -asset_tag "DEV123"
Specifying asset tag when creating asset
```

### EXAMPLE 3
```
New-SnipeitAsset -status_id 1 -model_id 1 -name "Machine1" -customfields = @{ "_snipeit_os_5" = "Windows 10 Pro" }
Using customfields when creating asset.
```

## PARAMETERS

### -apiKey
Deprecated parameter, please use Connect-SnipeitPS instead.
Users API Key for Snipeit.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -asset_tag
Asset Tag for the Asset, not required when snipe asset_tag autogeneration is on.

```yaml
Type: String
Parameter Sets: (All)
Aliases: tag

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -assigned_id
Id of target user , location or asset

```yaml
Type: Int32
Parameter Sets: Checkout asset when creating
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -checkout_to_type
Checkout asset when creating to one of following types user, location or asset.

```yaml
Type: String
Parameter Sets: Checkout asset when creating
Aliases:

Required: True
Position: Named
Default value: User
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
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -customfields
Hastable of custom fields and extra fields that need passing through to Snipeit.
Use internal field names from snipeit .You can use Get-CustomField to get internal field names.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases: CustomValues

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -image
Asset image filename and path

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -model_id
Required Model ID of the asset, this can be got using Get-Model

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -name
Optional Name of the Asset

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -notes
Optional Notes

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -purchase_cost
Optional Purchase cost of the Asset

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -purchase_date
Optional Purchase cost of the Asset

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -rtd_location_id
Optional Default location id for the asset

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -serial
Optional Serial number of the Asset

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -status_id
Required Status ID of the asset, this can be got using Get-Status

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
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
Position: Named
Default value: 0
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
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -warranty_months
{{ Fill warranty_months Description }}

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 0
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
