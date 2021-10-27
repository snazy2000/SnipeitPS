---
external help file: SnipeitPS-help.xml
Module Name: SnipeitPS
online version:
schema: 2.0.0
---

# Connect-SnipeitPS

## SYNOPSIS
Sets authetication information

## SYNTAX

### Connect with url and apikey (Default)
```
Connect-SnipeitPS -url <Uri> -apiKey <String> [<CommonParameters>]
```

### Connect with url and secure apikey
```
Connect-SnipeitPS -url <Uri> -secureApiKey <SecureString> [<CommonParameters>]
```

### Connect with credential
```
Connect-SnipeitPS -siteCred <PSCredential> [<CommonParameters>]
```

## DESCRIPTION
Sets apikey and url to connect Snipe-It system.
Based on Set-SnipeitInfo command, what is now just compatibility wrapper
and calls Connect-SnipeitPS

## EXAMPLES

### EXAMPLE 1
```
Connect-SnipeitPS -Url $url -apiKey $myapikey
Connect to  Snipe it  api.
```

### EXAMPLE 2
```
Connect-SnipeitPS -Url $url -SecureApiKey $myapikey
Connects to Snipe it api with apikey stored to securestring
```

### EXAMPLE 3
```
Connect-SnipeitPS -siteCred (Get-Credential -message "Use site url as username and apikey as password")
Connect to Snipe It with PSCredential object.
To use saved creadentials yu can use export-clixml and import-clixml commandlets.
```

### EXAMPLE 4
```
Build credential with apikey value from secret vault (Microsoft.PowerShell.SecretManagement)
$siteurl = "https://mysnipeitsite.url"
$apikey = Get-SecretInfo -Name SnipeItApiKey
$siteCred = New-Object -Type PSCredential -Argumentlist $siteurl,$spikey
Connect-SnipeitPS -siteCred $siteCred
```

## PARAMETERS

### -apiKey
User's API Key for Snipeit.

```yaml
Type: String
Parameter Sets: Connect with url and apikey
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -secureApiKey
Snipe it Api key as securestring

```yaml
Type: SecureString
Parameter Sets: Connect with url and secure apikey
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -siteCred
PSCredential where username shoul be snipe it url and password should be
snipe it apikey.

```yaml
Type: PSCredential
Parameter Sets: Connect with credential
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -url
URL of Snipeit system.

```yaml
Type: Uri
Parameter Sets: Connect with url and apikey, Connect with url and secure apikey
Aliases:

Required: True
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
