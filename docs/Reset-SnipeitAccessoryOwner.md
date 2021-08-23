---
external help file: SnipeitPS-help.xml
Module Name: snipeitps
online version:
schema: 2.0.0
---

# Reset-SnipeitAccessoryOwner

## SYNOPSIS
Checkin  accessories

## SYNTAX

```
Reset-SnipeitAccessoryOwner [-assigned_pivot_id] <Int32> [[-url] <String>] [[-apiKey] <String>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Checkin  accessories

## EXAMPLES

### EXAMPLE 1
```
To get the accessories_users table for specific accessory id number
```

Get-SnipeitAccessoryOwner -id 1

Thenselect  assigned_pivot_id for userid you like check in

Get-SnipeitAccessoryOwner -assigned_pivot_id xxx

## PARAMETERS

### -apiKey
Deprecated parameter, please use Connect-SnipeitPS instead.
User's API Key for Snipeit.

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

### -assigned_pivot_id
This is the assigned_pivot_id of the accessory+user relationships in the accessories_users table
Use Get-SnipeitAccessoryOwner to find out nooded value

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
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
Position: 2
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
