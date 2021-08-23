---
external help file: SnipeitPS-help.xml
Module Name: snipeitps
online version:
schema: 2.0.0
---

# Update-SnipeitAlias

## SYNOPSIS
Replaces old SnipeitPS commands with new ones

## SYNTAX

```
Update-SnipeitAlias [-String] <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Replaces old SnipeitPS commands with new ones

## EXAMPLES

### EXAMPLE 1
```
Get-Content [your-script.ps1] | Update-SnipeitAlias | Out-File [new-script-name.ps1]
```

Replaces old command from file "your-script.ps1" and creates new script "new-script-name.ps1"
After testing new file you can replace old file with new.

## PARAMETERS

### -String
Input string

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
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
