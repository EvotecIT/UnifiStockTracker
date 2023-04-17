function Get-UnifiStock {
    <#
    .SYNOPSIS
    Get the stock status of Ubiquiti products from their online store.

    .DESCRIPTION
    Get the stock status of Ubiquiti products from their online store.

    .PARAMETER Store
    The store to check for stock. Valid values are: Europe, USA, Brazil, India, Japan, Taiwan, Signapore, Mexico, China

    .PARAMETER Collection
    Which collection to list. Valid values are: 'Protect', 'ProtectNVR', 'ProtectAccessories', 'NetworkOS', 'NetworkSwitching', 'NetworkSmartPower', 'NetworkRoutingOffload', 'NetworkWifi'

    .EXAMPLE
    Get-UnifiStock -Store USA -Collection Protect, ProtectAccessories, ProtectNVR | Sort-Object -Property Name | Format-Table

    .EXAMPLE
    Get-UnifiStock -Store Europe -Collection Protect, NetworkWifi | Sort-Object -Property Name | Format-Table

    .EXAMPLE
    Get-UnifiStock -Store Europe | Sort-Object -Property Name | Format-Table

    .NOTES
    General notes
    #>
    [cmdletbinding()]
    param(
        [ValidateSet('Europe', 'USA', 'Brazil', 'India', 'Japan', 'Taiwan', 'Signapore', 'Mexico', 'China')]
        [Parameter(Mandatory)]
        [string] $Store,
        [ValidateSet(
            'EarlyAccess',
            'EarlyAccessConnect',
            'EarlyAccessDoorAccess',
            'EarlyAccessSmartpower',
            'EarlyAccessUispFiber',
            'EarlyAccessUispWired',
            'EarlyAccessUispWireless',
            'EarlyAccessUnifiNetworkHost',
            'NetworkHost',
            'NetworkOS',
            'NetworkRoutingOffload',
            'NetworkRoutingSwitching',
            'NetworkSmartPower',
            'NetworkSwitching',
            'NetworkWifi',
            'OperatorAirmaxAndLtu',
            'OperatorIspInfrastructure',
            'Protect',
            'ProtectAccessories',
            'ProtectNVR',
            'UnifiAccessories',
            'UnifiConnect',
            'UnifiDoorAccess',
            'UnifiPhoneSystem'
        )]
        [string[]] $Collection
    )

    $Stores = @{
        Europe    = 'https://eu.store.ui.com'
        USA       = 'https://store.ui.com'
        Brazil    = 'https://br.store.ui.com'
        India     = 'https://store-ui.in'
        Japan     = 'https://jp.store.ui.com'
        Taiwan    = 'https://tw.store.ui.com'
        Singapore = 'https://sg.store.ui.com'
        Mexico    = 'https://mx.store.ui.com'
        China     = 'https://store.ui.com.cn'
    }

    $Collections = @{
        Protect                     = 'unifi-protect'
        ProtectNVR                  = 'unifi-protect-nvr'
        ProtectAccessories          = 'unifi-protect-accessories'
        NetworkOS                   = 'unifi-network-unifi-os-consoles'
        NetworkRoutingSwitching     = 'unifi-network-routing-switching'
        NetworkSmartPower           = 'unifi-network-smartpower'
        NetworkRoutingOffload       = 'unifi-network-routing-offload'
        NetworkHost                 = 'unifi-network-host'
        NetworkSwitching            = 'unifi-network-switching'
        NetworkWifi                 = 'unifi-network-wireless'
        UnifiAccessories            = 'unifi-accessories'
        EarlyAccess                 = 'early-access'
        EarlyAccessDoorAccess       = 'early-access-door-access'
        EarlyAccessConnect          = 'early-access-connect'
        EarlyAccessSmartpower       = 'early-access-smartpower'
        EarlyAccessUispFiber        = 'early-access-uisp-fiber'
        EarlyAccessUispWired        = 'early-access-uisp-wired'
        EarlyAccessUispWireless     = 'early-access-uisp-wireless'
        EarlyAccessUnifiNetworkHost = 'early-access-unifi-network-host'
        UnifiConnect                = 'unifi-connect'
        UnifiDoorAccess             = 'unifi-door-access'
        OperatorAirmaxAndLtu        = 'operator-airmax -and -ltu'
        OperatorIspInfrastructure   = 'operator-isp-infrastructure'
        UnifiPhoneSystem            = 'unifi-phone-system'
    }

    $UrlStore = $Stores[$Store]

    if (-not $Collection) {
        $Collection = $Collections.Keys
    }

    foreach ($Category in $Collection) {
        $UrlCollection = $Collections[$Category]
        $Url = "$UrlStore/collections/$UrlCollection"
        $UrlProducts = "$Url/products.json"
        $ProgressPreference = 'SilentlyContinue'
        try {
            Write-Verbose -Message "Get-UnifiStock - Getting $UrlProducts"
            $Output = Invoke-WebRequest -Uri $UrlProducts -ErrorAction Stop -Verbose:$false
        } catch {
            Write-Color -Text "Unable to get $UrlProducts. Error: $($_.Exception.Message)" -Color Red
            return
        }
        if ($Output) {
            $OutputJSON = $Output.Content | ConvertFrom-Json
            $UnifiProducts = foreach ($Product in $OutputJSON.products) {
                foreach ($Variant in $Product.variants) {
                    try {
                        $DateCreated = [DateTime]::Parse($Variant.created_at)
                        #$DateCreated = [DateTime]::ParseExact($Variant.created_at, 'yyyy-MM-ddTHH:mm:sszzz', $null)
                    } catch {
                        Write-Verbose -Message "Unable to parse date: $($Variant.created_at). Skipping"
                        $DateCreated = $null
                    }
                    try {
                        $DateUpdated = [DateTime]::Parse($Variant.updated_at)
                        #$DateUpdated = [DateTime]::ParseExact($Variant.updated_at, 'yyyy-MM-ddTHH:mm:sszzz', $null)
                    } catch {
                        Write-Verbose -Message "Unable to parse date: $($Variant.updated_at). Skipping"
                        $DateUpdated = $null
                    }
                    [PSCustomObject] @{
                        Name       = $Product.title
                        Available  = $Variant.available
                        Category   = $Category
                        Price      = $Variant.price
                        SKU        = $Variant.sku
                        SKUName    = $Variant.title
                        #Inventory  = $Variant.inventory_quantity
                        Created    = $DateCreated
                        Updated    = $DateUpdated
                        ProductUrl = "$Url/products/$($Product.handle)"
                        Tags       = $Product.tags
                    }
                }
            }
            $UnifiProducts
        }
    }
}