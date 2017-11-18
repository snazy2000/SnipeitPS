---
external help file: SnipeItPS-help.xml
Module Name: SnipeItPS
online version: 
schema: 2.0.0
---

# Get-Asset

## SYNOPSIS
# Gets a list of Snipe-it Assets

## SYNTAX

```
Get-Asset [-url] <String> [-apiKey] <String>
```

## DESCRIPTION
{{Fill in the Description}}

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
Get-Asset -url "https://assets.dip.co.uk" -token "token..."
```

### -------------------------- EXAMPLE 2 --------------------------
```
Get-Asset -url "https://assets.dip.co.uk" -token "token..." | Where-Object {$_.name -eq "SUPPORT23" }
```

## PARAMETERS

### -url
URL of Snipeit system, can be set using Set-Info command

```yaml
Type: String
Parameter Sets: (All)
Aliases: 

Required: True
Position: 1
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
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

