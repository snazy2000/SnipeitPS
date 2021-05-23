---
external help file: SnipeItPS-help.xml
Module Name: SnipeitPS
online version:
schema: 2.0.0
---

# Get-SnipeItCategory

## SYNOPSIS
Gets a list of Snipe-it Categories

## SYNTAX

```
Get-SnipeItCategory [[-search] <String>] [[-id] <Int32>] [[-order] <String>] [[-limit] <Int32>]
 [[-offset] <Int32>] [-all] [-url] <String> [-apiKey] <String> [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```
Get-Category -id 1
```

### EXAMPLE 2
```
Get-Category -search "Laptop"
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
Users API Key for Snipeit, can be set using Set-Info command

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

### -id
A id of specific Category

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

### -limit
Specify the number of results you wish to return.
Defaults to 50.
Defines batch size for -all

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 50
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
Position: 5
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
Position: 3
Default value: Desc
Accept pipeline input: False
Accept wildcard characters: False
```

### -search
A text string to search the Categories data

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

### -url
Url of Snipeit system, can be set using Set-Info command

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
