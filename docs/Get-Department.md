---
external help file: SnipeItPS-help.xml
Module Name: SnipeItPS
online version: 
schema: 2.0.0
---

# Get-Department

## SYNOPSIS
# Gets a list of Snipe-it Departments

## SYNTAX

```
Get-Department [[-search] <String>] [-url] <String> [-apiKey] <String>
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-Department -url "https://assets.example.com" -token "token..."
```

### -------------------------- EXAMPLE 2 --------------------------
```
Get-Department -url "https://assets.example.com" -token "token..." | Where-Object {$_.name -eq "Department1" }
```

## PARAMETERS

### -search
{{Fill search Description}}

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
URL of Snipeit system, can be set using Set-Info command

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

### -apiKey
Users API Key for Snipeit, can be set using Set-Info command

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

