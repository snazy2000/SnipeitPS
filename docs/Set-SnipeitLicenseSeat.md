---
external help file: SnipeitPS-help.xml
Module Name: SnipeitPS
online version:
schema: 2.0.0
---

# Set-SnipeitLicenseSeat

## SYNOPSIS
Set license seat or checkout license seat

## SYNTAX

```
Set-SnipeitLicenseSeat [-id] <Int32[]> [-seat_id] <Int32> [[-assigned_to] <Int32>] [[-asset_id] <Int32>]
 [[-note] <String>] [-url] <String> [-apiKey] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Checkout specific license seat to user, asset or both

## EXAMPLES

### EXAMPLE 1
```
Set-SnipeitLicenceSeat -ID 1 -seat_id 1 -assigned_id 3
Checkout licence to user id 3
```

### EXAMPLE 2
```
Set-SnipeitLicenceSeat -ID 1 -seat_id 1 -asset_id 3
Checkout licence to asset id 3
```

### EXAMPLE 3
```
Set-SnipeitLicenceSeat -ID 1 -seat_id 1 -asset_id $null -assigned_id $null
Checkin licence seat id 1 of licence id 1
```

## PARAMETERS

### -apiKey
User's API Key for Snipeit, can be set using Set-SnipeitInfo command

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -asset_id
Id of target asset

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -assigned_to
Id of target user

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: assigned_id

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -id
Unique ID For license to checkout or array of IDs

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

### -seat_id
{{ Fill seat_id Description }}

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

### -url
URL of Snipeit system, can be set using Set-SnipeitInfo command

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 6
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
