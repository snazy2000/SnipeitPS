<#
    .SYNOPSIS
    Update a specific Asset in the Snipe-it asset system

    .DESCRIPTION
    Long description

    .PARAMETER id
    ID of the Asset or array of IDs

    .PARAMETER Name
    Asset name

    .PARAMETER Status_id
    Status ID of the asset, this can be got using Get-Status

    .PARAMETER Model_id
    Model ID of the asset, this can be got using Get-Model

    .PARAMETER last_checkout
    Date the asset was last checked out

    .PARAMETER assigned_to
    The id of the user the asset is currently checked out to

    .PARAMETER company_id
    The id of an associated company id

    .PARAMETER serial
    Serial number of the asset

    .PARAMETER order_number
    Order number for the asset

    .PARAMETER warranty_months
    Number of months for the asset warranty

    .PARAMETER purchase_cost
    Purchase cost of the asset, without a currency symbol

    .PARAMETER purchase_date
    Date of asset purchase

    .PARAMETER requestable
    Whether or not the asset can be requested by users with the permission to request assets

    .PARAMETER archived
    Whether or not the asset is archived. Archived assets cannot be checked out and do not show up in the deployable asset screens

    .PARAMETER rtd_location_id
    The id that corresponds to the location where the asset is usually located when not checked out

    .PARAMETER notes
    Notes about asset

    .PARAMETER RequestType
    Http request type to send Snipe IT system. Defaults to Put youc use Patch if needed

    .PARAMETER url
    URL of Snipeit system, can be set using Set-SnipeitInfoeItInfo command

    .PARAMETER apiKey
    Users API Key for Snipeit, can be set using Set-SnipeitInfoeItInfo command

    .PARAMETER customfields
    Hastable of custom fields and extra fields that need passing through to Snipeit

    .EXAMPLE
    Set-SnipeitAsset -id 1 -status_id 1 -model_id 1 -name "Machine1"

    .EXAMPLE
    Set-SnipeitAsset -id 1 -name "Machine1" -customfields =  @{ "_snipeit_os_5" = "Windows 10 Pro" ; "_snipeit_os_version" = "1909" }

    .EXAMPLE
    Get-SnipeitAsset -serial 12345678 | Set-SnipeitAsset -notes 'Just updated'
#>

function Set-SnipeitAsset()
{
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Medium"
    )]

    Param(
        [parameter(mandatory = $true,ValueFromPipelineByPropertyName)]
        [int[]]$id,


        [string]$name,

        [int]$status_id,

        [int]$model_id,

        [DateTime]$last_checkout,

        [int]$assigned_to,

        [int]$company_id,

        [string]$serial,

        [string]$order_number,

        [int]$warranty_months,

        [double]$purchase_cost,

        [datetime]$purchase_date,

        [bool]$requestable,

        [bool]$archived,

        [int]$rtd_location_id,

        [string]$notes,

        [ValidateSet("Put","Patch")]
        [string]$RequestType = "Patch",

        [parameter(mandatory = $true)]
        [string]$url,

        [parameter(mandatory = $true)]
        [string]$apiKey,

        [Alias('CustomValues')]
        [hashtable] $customfields
    )
    begin{
        Test-SnipeitAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

        $Values = . Get-ParameterValue -Parameters $MyInvocation.MyCommand.Parameters -BoundParameters $PSBoundParameters

        if ($Values['purchase_date']) {
            $Values['purchase_date'] = $Values['purchase_date'].ToString("yyyy-MM-dd")
        }

        if ($customfields)
        {
            $Values += $customfields
        }

    }

    process {
        foreach($asset_id in $id){
            $Parameters = @{
                Uri    = "$url/api/v1/hardware/$asset_id"
                Method = $RequestType
                Body   = $Values
                Token  = $apiKey
            }

            If ($PSCmdlet.ShouldProcess("ShouldProcess?"))
            {
                $result = Invoke-SnipeitMethod @Parameters
            }

            $result
        }
    }
}
