---
external help file: SnipeitPS-help.xml
Module Name: SnipeitPS
online version:
schema: 2.0.0
---

# Set-SnipeitAssetOwner

## SYNOPSIS
Checkout asset

## SYNTAX

```
Set-SnipeitAssetOwner [-id] <Int32[]> [-assigned_id] <Int32> [[-checkout_to_type] <String>] [[-name] <String>]
 [[-note] <String>] [[-expected_checkin] <DateTime>] [[-checkout_at] <DateTime>] [-url] <String>
 [-apiKey] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Checkout asset to user/localtion/asset

## EXAMPLES

### EXAMPLE 1
```
Set-SnipeitAssetOwner -id 1 -assigned_id 1 -checkout_to_type user -note "testing check out to user"
```

## PARAMETERS

### -apiKey
User's API Key for Snipeit, can be set using Set-SnipeitInfo command

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -assigned_id
Id of target user , location or asset

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

### -checkout_at
Optional date to override the checkout time of now

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -checkout_to_type
{{ Fill checkout_to_type Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: User
Accept pipeline input: False
Accept wildcard characters: False
```

### -expected_checkin
Optional date the asset is expected to be checked in

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
Unique IDs For assets to checkout

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -name
Optional new asset name.
This is useful for changing the asset's name on new checkout,
for example, an asset that was named "Anna's Macbook Pro" could be renamed on the fly
when it's checked out to Elizabeth, to "Beth's Macbook Pro"

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

### -note
Notes about checkout

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

### -url
URL of Snipeit system, can be set using Set-SnipeitInfo command

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 8
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
