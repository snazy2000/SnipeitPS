<#
    .SYNOPSIS
    Checkout asset
    .DESCRIPTION
    Checkout asset to user/localtion/asset

    .PARAMETER ID
    Unique IDs For assets to checkout

    .PARAMETER assigned_id
    Id of target user , location or asset

    .PARAMETER note
    Notes about checkout

    .PARAMETER name
    Optional new asset name. This is useful for changing the asset's name on new checkout,
    for example, an asset that was named "Anna's Macbook Pro" could be renamed on the fly
    when it's checked out to Elizabeth, to "Beth's Macbook Pro"

    .PARAMETER expected_checkin
    Optional date the asset is expected to be checked in

    .PARAMETER checkout_at
    Optional date to override the checkout time of now

    .PARAMETER url
    URL of Snipeit system, can be set using Set-SnipeitInfo command

    .PARAMETER apiKey
    User's API Key for Snipeit, can be set using Set-SnipeitInfo command

    .EXAMPLE
    Set-SnipeitAssetOwner -id 1 -assigned_id 1 -checkout_to_type user -note "testing check out to user"
#>
function Set-SnipeitAssetOwner()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Medium"
    )]

    Param(
        [parameter(mandatory = $true,ValueFromPipelineByPropertyName)]
        [int[]]$id,

        [parameter(mandatory = $true)]
        [int]$assigned_id,

        [ValidateSet("location","asset","user")]
        [string] $checkout_to_type = "user",

        [string] $name,

        [string] $note,

        [datetime] $expected_checkin,

        [datetime]$checkout_at,

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey
    )

    begin{
        Test-SnipeitAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

        $Values = . Get-ParameterValue -Parameters $MyInvocation.MyCommand.Parameters -BoundParameters $PSBoundParameters

        if ($Values['expected_checkin']) {
            $Values['expected_checkin'] = $Values['expected_checkin'].ToString("yyyy-MM-dd")
        }

        if ($Values['checkout_at']) {
            $Values['checkout_at'] = $Values['checkout_at'].ToString("yyyy-MM-dd")
        }

        switch ($checkout_to_type)
        {
            'location' { $Values += @{ "assigned_location" = $assigned_id } }
            'user' { $Values += @{ "assigned_user" = $assigned_id } }
            'asset' { $Values += @{ "assigned_asset" = $assigned_id } }
        }

        #This can be removed now
        if($Values.ContainsKey('assigned_id')){$Values.Remove('assigned_id')}

    }

    process{
        foreach($asset_id in $id){
            $Parameters = @{
                Uri    = "$url/api/v1/hardware/$asset_id/checkout"
                Method = 'POST'
                Body   = $Values
                Token  = $apiKey
            }

            If ($PSCmdlet.ShouldProcess("ShouldProcess?"))
            {
                $result = Invoke-SnipeitMethod @Parameters
            }

            return $result
        }
    }
}
