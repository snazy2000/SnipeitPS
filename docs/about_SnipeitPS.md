# About SnipeitPS
## about_SnipeitPS

# SHORT DESCRIPTION
Powershell API Wrapper for Snipe-it.

# LONG DESCRIPTION
Collection of tools that makes interacting with Snipe-it api more pleasant.

# EXAMPLES
Prepare connection Snipe-It with:

Connect-SnipeitPS -url https://your.site -apikey YourVeryLongApiKey....

For secure ways to pass apikey to script, see Get-Help Connect-SnipeitPS -full

To search assets use:

Get-SnipeitAsset -search needle

Piping get and new commands results to set commands is supported. Followirg will
set notes for every asset that have model_id 123.

Get-SnipeitAsset -model_id 123 -all | Set-SnipeitAsset

You can get specific items with -id prameter like

Get-SnipeitModel -id 123

# NOTE
Most of commands are using same parameters as in Snipe It api,
but it's always good idea  check syntax with Get-Help

# TROUBLESHOOTING NOTE
Check your api key and certificate on server first.

# SEE ALSO

Report any issues to:
[GitHub project page](https://github.com/snazy2000/SnipeitPS/issues)

# KEYWORDS

- Snipe-It
- asset management
