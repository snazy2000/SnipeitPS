---
external help file: SnipeItPS-help.xml
Module Name: SnipeItPS
online version: http://go.microsoft.com/fwlink/?LinkId=821589
schema: 2.0.0
---

# New-Asset

## SYNOPSIS
Add a new Asset to Snipe-it asset system

## SYNTAX

```
New-Asset [[-tag] <String>] [-Name] <String> [-Status_id] <Int32> [-Model_id] <Int32> [-url] <String>
 [-apiKey] <String> [[-customfields] <Hashtable>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Long description

## EXAMPLES

### -------------------------- EXAMPLE 1 --------------------------
```
New-Asset -status_id 1 -model_id 1 -name "Machine1"
```

### -------------------------- EXAMPLE 2 --------------------------
```
New-Asset -status_id 1 -model_id 1 -name "Machine1" -CustomValues = @{ "_snipeit_os_5 = "Windows 10 Pro" }
```

## PARAMETERS

### -tag
Asset Tag for the Asset

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

### -Name
Name of the Asset

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

### -Status_id
Status ID of the asset, this can be got using Get-Status

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: True
Position: 3
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Model_id
Model ID of the asset, this can be got using Get-Model

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: 

Required: True
Position: 4
Default value: 0
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
Position: 5
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
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -customfields
Hastable of custom fields and extra fields that need passing through to Snipeit

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases: 

Required: False
Position: 7
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

