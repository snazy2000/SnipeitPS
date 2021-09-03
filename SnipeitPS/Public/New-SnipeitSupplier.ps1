<#
    .SYNOPSIS
    Creates a supplier

    .DESCRIPTION
    Creates a new supplier on Snipe-It system

    .PARAMETER name
    Department Name

    .PARAMETER address
    Address line 1 of supplier

    .PARAMETER address2
    Address line 1 of supplier

    .PARAMETER city
    City

    .PARAMETER state
    State

    .PARAMETER country
    Country

    .PARAMETER zip
    Zip code

    .PARAMETER phone
    Phone number

    .PARAMETER fax
    Fax number

    .PARAMETER email
    Email address

    .PARAMETER contact
    Contact person

    .PARAMETER notes
    Email address

     .PARAMETER image
    Image file name and path for item

    .PARAMETER url
    Deprecated parameter, please use Connect-SnipeitPS instead. URL of Snipeit system.

    .PARAMETER apiKey
    Deprecated parameter, please use Connect-SnipeitPS instead. Users API Key for Snipeit.

    .EXAMPLE
    New-SnipeitDepartment -name "Department1" -company_id 1 -localtion_id 1 -manager_id 3

#>

function New-SnipeitSupplier() {
    [CmdletBinding(
        SupportsShouldProcess = $true,
        ConfirmImpact = "Low"
    )]

    Param(
        [parameter(mandatory = $true)]
        [string]$name,

        [string]$address,

        [string]$address2,

        [string]$city,

        [string]$state,

        [string]$country,

        [string]$zip,

        [string]$phone,

        [string]$fax,

        [string]$email,

        [string]$contact,

        [string]$notes,

        [ValidateScript({Test-Path $_})]
        [string]$image,

        [parameter(mandatory = $false)]
        [string]$url,

        [parameter(mandatory = $false)]
        [string]$apiKey
    )
    begin {
        Test-SnipeitAlias -invocationName $MyInvocation.InvocationName -commandName $MyInvocation.MyCommand.Name

        $Values = . Get-ParameterValue -Parameters $MyInvocation.MyCommand.Parameters -BoundParameters $PSBoundParameters

        $Parameters = @{
            Api    = "/api/v1/suppilers"
            Method = 'POST'
            Body   = $Values
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
        if ($PSCmdlet.ShouldProcess("ShouldProcess?")) {
            $result = Invoke-SnipeitMethod @Parameters
        }

        $result
    }

    end {
        # reset legacy sessions
        if ($PSBoundParameters.ContainsKey('url') -and '' -ne [string]$url -or $PSBoundParameters.ContainsKey('apiKey') -and '' -ne [string]$apiKey) {
            Reset-SnipeitPSLegacyApi
        }
    }
}

