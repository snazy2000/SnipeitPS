---
external help file: SnipeitPS-help.xml
Module Name: SnipeitPS
online version:
schema: 2.0.0
---

# Set-SnipeitInfo

## SYNOPSIS
Sets authetication information.
Deprecated, use Connect-SnipeitPS instead.

## SYNTAX

```
Set-SnipeitInfo [-url] <Uri> [-apiKey] <String> [<CommonParameters>]
```

## DESCRIPTION
Deprecated combatibilty function that Set apikey and url user to connect Snipe-It system.
Please use Connect-SnipeitPS instead.

## EXAMPLES

### EXAMPLE 1
```
Set-SnipeitInfo -url $url -apiKey -Verbose
```

## PARAMETERS

### -apiKey
User's API Key for Snipeit.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -url
URL of Snipeit system.

```yaml
Type: Uri
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
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
