# About SnipeitPS
## about_SnipeitPS

# SHORT DESCRIPTION
Powershell API Wrapper for Snipe-it.

# LONG DESCRIPTION
Collection of tools that makes interacting with Snipe-it api more pleasant.

# EXAMPLES
Prepare connection Snipe-It with

Set-SnipeitInfo -url https://your.site -apikey YourVeryLongApiKey....

To search assets use

Get-SnipeitAsset -search needle

Piping get and new commands results to set commands is supported. Followirg will
set notes for every asset that have model_id 123.

Get-SnipeitAsset -model_id 123 -all | Set-SnipeitAsset

# NOTE


# TROUBLESHOOTING NOTE
{{ Troubleshooting Placeholder - Warns users of bugs}}

{{ Explains behavior that is likely to change with fixes }}

# SEE ALSO
{{ See also placeholder }}

{{ You can also list related articles, blogs, and video URLs. }}

# KEYWORDS
{{List alternate names or titles for this topic that readers might use.}}

- {{ Keyword Placeholder }}
- {{ Keyword Placeholder }}
- {{ Keyword Placeholder }}
- {{ Keyword Placeholder }}
