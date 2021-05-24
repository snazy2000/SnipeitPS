---
external help file: SnipeItPS-help.xml
Module Name: SnipeitPS
online version:
schema: 2.0.0
---

# Get-SnipeItComponent

## SYNOPSIS
Gets a list of Snipe-it Components

## SYNTAX

```
Get-SnipeItComponent [[-search] <String>] [[-id] <Int32>] [[-category_id] <Int32>] [[-company_id] <Int32>]
 [[-location_id] <Int32>] [[-order] <String>] [[-sort] <String>] [[-limit] <Int32>] [[-offset] <Int32>] [-all]
 [-url] <String> [-apiKey] <String> [<CommonParameters>]
```

## DESCRIPTION
{{ Fill in the Description }}

## EXAMPLES

### EXAMPLE 1
```
Get-SnipeItComponent
```

Returns all components

### EXAMPLE 2
```
Get-SnipeItComponent -search display
```

Returns search results containeing string display

### EXAMPLE 3
```
Get-SnipeItComponent -id
```

Returns specific component

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
Users API Key for Snipeit, can be set using Set-SnipeItInfo command

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 11
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
{{ Fill company_id Description }}

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

### -id
A id of specific Component

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
Position: 8
Default value: 50
Accept pipeline input: False
Accept wildcard characters: False
```

### -location_id
{{ Fill location_id Description }}

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

### -offset
Offset to use

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

### -order
{{ Fill order Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: Desc
Accept pipeline input: False
Accept wildcard characters: False
```

### -search
A text string to search the Components data

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

### -sort
{{ Fill sort Description }}

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: Created_at
Accept pipeline input: False
Accept wildcard characters: False
```

### -url
URL of Snipeit system,can be set using Set-SnipeItInfo command

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 10
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
