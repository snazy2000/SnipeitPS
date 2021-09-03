<#
.SYNOPSIS
Gets and search Snipe-it Activity history

.DESCRIPTION
Gets a list of Snipe-it activity history

.PARAMETER search
A text string to search the Activity history

.PARAMETER target_type
Type of target. One from following list 'Accessory','Asset','AssetMaintenance','AssetModel','Category','Company','Component','Consumable','CustomField','Depreciable','Depreciation','Group','Licence','LicenseSeat','Location','Manufacturer','Statuslabel','Supplier','User'

.PARAMETER target_id
Needed if target_type is specified

.PARAMETER item_type
Type of target. One from following list 'Accessory','Asset','AssetMaintenance','AssetModel','Category','Company','Component','Consumable','CustomField','Depreciable','Depreciation','Group','Licence','LicenseSeat','Location','Manufacturer','Statuslabel','Supplier','User'

.PARAMETER item_id
Needed if target_type is specified

.PARAMETER action_type
Type of action. One from following list "add seats", "checkin from", 'checkout' or 'update'

.PARAMETER offset
Result offset to use

.PARAMETER all
A return all results, works with -offset and other parameters

.PARAMETER url
Deprecated parameter, please use Connect-SnipeitPS instead. URL of Snipeit system.

.PARAMETER apiKey
Deprecated parameter, please use Connect-SnipeitPS instead. Users API Key for Snipeit.

.EXAMPLE
Get-SnipeitAccessory -search Keyboard

.EXAMPLE
Get-SnipeitAccessory -id 1

#>

function Get-SnipeitActivity() {
    Param(

        [string]$search,

        [Parameter(Mandatory=$false)]
        [ValidateSet('Accessory','Asset','AssetMaintenance','AssetModel','Category','Company','Component','Consumable','CustomField','Depreciable','Depreciation','Group','Licence','LicenseSeat','Location','Manufacturer','Statuslabel','Supplier','User')]
        [string]$target_type,

        [Parameter(Mandatory=$false)]
        [int]$target_id,

        [Parameter(Mandatory=$false)]
        [ValidateSet('Accessory','Asset','AssetMaintenance','AssetModel','Category','Company','Component','Consumable','CustomField','Depreciable','Depreciation','Group','Licence','LicenseSeat','Location','Manufacturer','Statuslabel','Supplier','User')]
        [string]$item_type,

        [Parameter(Mandatory=$false)]
        [int]$item_id,

        [ValidateSet("add seats", "checkin from", 'checkout','update')]
        [string]$action_type ,

        [int]$limit = 50,

        [int]$offset,

        [switch]$all = $false,

        [parameter(mandatory = $false)]
        [string]$url,

        [parameter(mandatory = $false)]
        [string]$apiKey
    )
    begin {
        if (($target_type -and -not $target_id) -or
            ($target_id -and -not $target_type)) {
            throw "Please specify both target_type and target_id"
        }

        if (($item_type -and -not $item_id) -or
            ($item_id -and -not $item_type)) {
            throw "Please specify both item_type and item_id"
        }

        $SearchParameter = . Get-ParameterValue -Parameters $MyInvocation.MyCommand.Parameters -BoundParameters $PSBoundParameters


        $Parameters = @{
            Api           = "/api/v1/reports/activity"
            Method        = 'Get'
            GetParameters = $SearchParameter
        }

        if ($PSBoundParameters.ContainsKey('apiKey') -and '' -ne [string]$apiKey) {
            Write-Warning "-apiKey parameter is deprecated, please use Connect-SnipeitPS instead."
            Set-SnipeitPSLegacyApiKey -apiKey $apikey
        }

        if ($PSBoundParameters.ContainsKey('url') -and '' -ne [string]$url) {
            Write-Warning "-url parameter is deprecated, please use Connect-SnipeitPS instead."
            Set-SnipeitPSLegacyUrl -url $url
        }
    }

    process {
        if ($all) {
            $offstart = $(if ($offset) {$offset} Else {0})
            $callargs = $SearchParameter
            $callargs.Remove('all')

            while ($true) {
                $callargs['offset'] = $offstart
                $callargs['limit'] = $limit
                $res=Get-SnipeitActivity @callargs
                $res
                if ($res.count -lt $limit) {
                    break
                }
                $offstart = $offstart + $limit
            }
        } else {
            $result = Invoke-SnipeitMethod @Parameters
            $result
        }
    }

    end {
        # reset legacy sessions
        if ($PSBoundParameters.ContainsKey('url') -and '' -ne [string]$url -or $PSBoundParameters.ContainsKey('apiKey') -and '' -ne [string]$apiKey) {
            Reset-SnipeitPSLegacyApi
        }
    }
}






