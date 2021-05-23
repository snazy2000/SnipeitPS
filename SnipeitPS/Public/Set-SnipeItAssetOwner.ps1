<#
    .SYNOPSIS
    Checkout asset
    .DESCRIPTION
    Checkout asset to user/localtion/asset

    .PARAMETER ID
    Unique ID For asset to checkout

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
    URL of Snipeit system, can be set using Set-SnipeItInfo command

    .PARAMETER apiKey
    User's API Key for Snipeit, can be set using Set-SnipeItInfo command

    .EXAMPLE
    Remove-User -ID 44 -url $url -apiKey $secret -Verbose
#>
function Set-SnipeItAssetOwner()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Medium"
    )]

    Param(
        [parameter(mandatory = $true)]
        [int]$id,

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

    Test-SnipeItAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

    $Values = . Get-ParameterValue $MyInvocation.MyCommand.Parameters

    if ($Values['expected_checkin']) {
        $Values['expected_checkin'] = $values['expected_checkin'].ToString("yyyy-MM-dd")
    }

    if ($Values['checkout_at']) {
        $Values['checkout_at'] = $values['checkout_at'].ToString("yyyy-MM-dd")
    }

    switch ($checkout_to_type)
    {
        'location' { $Values += @{ "assigned_location" = $assigned_id } }
        'user' { $Values += @{ "assigned_user" = $assigned_id } }
        'asset' { $Values += @{ "assigned_asset" = $assigned_id } }
    }

    #This can be removed now
    if($Values.ContainsKey('assigned_id')){$Values.Remove('assigned_id')}

    $Body = $Values | ConvertTo-Json;

    $Parameters = @{
        Uri    = "$url/api/v1/hardware/$id/checkout"
        Method = 'POST'
        Body   = $Body
        Token  = $apiKey
    }

    If ($PSCmdlet.ShouldProcess("ShouldProcess?"))
    {
        $result = Invoke-SnipeitMethod @Parameters
    }

    return $result
}
