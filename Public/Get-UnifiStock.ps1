function Get-UnifiStock {
    [cmdletbinding()]
    param(
        [ValidateSet('Europe', 'USA', 'Brazil')]
        [Parameter(Mandatory)]
        [string] $Store,
        [ValidateSet('Protect', 'ProtectNVR', 'ProtectAccessories', 'NetworkOS', 'NetworkSwitching', 'NetworkSmartPower', 'NetworkRoutingOffload', 'NetworkWifi')]
        [string[]] $Collection
    )

    $Stores = @{
        Europe = 'https://eu.store.ui.com'
        USA    = 'https://store.ui.com'
        Brazil = 'https://br.store.ui.com'
    }

    $Collections = @{
        Protect               = 'unifi-protect'
        ProtectNVR            = 'unifi-protect-nvr'
        ProtectAccessories    = 'unifi-protect-accessories'
        NetworkOS             = 'unifi-network-unifi-os-consoles'
        NetworkSwitching      = 'unifi-network-routing-switching'
        NetworkSmartPower     = 'unifi-network-smartpower'
        NetworkRoutingOffload = 'unifi-network-routing-offload'
        NetworkWifi           = 'unifi-network-wireless'
    }

    $UrlStore = $Stores[$Store]

    foreach ($Category in $Collection) {
        $UrlCollection = $Collections[$Category]
        $Url = "$UrlStore/collections/$UrlCollection"
        $UrlProducts = "$Url/products.json"
        $ProgressPreference = 'SilentlyContinue'
        $Output = Invoke-WebRequest -Uri $UrlProducts
        $OutputJSON = $Output.Content | ConvertFrom-Json
        $UnifiProducts = foreach ($Product in $OutputJSON.products) {
            foreach ($Variant in $Product.variants) {
                [PSCustomObject] @{
                    Name       = $Product.title
                    Available  = $Variant.available
                    Price      = $Variant.price
                    SKU        = $Variant.sku
                    SKUName    = $Variant.title
                    #Inventory = $Variant.inventory_quantity
                    Created    = [DateTime]::ParseExact($Variant.created_at, 'yyyy-MM-ddTHH:mm:sszzz', $null)
                    Updated    = [DateTime]::ParseExact($Variant.updated_at, 'yyyy-MM-ddTHH:mm:sszzz', $null)
                    ProductUrl = "$Url/products/$($Product.handle)"
                    Tags       = $Product.tags
                    #Variants  = $Product.variants
                }
            }
        }
        $UnifiProducts
    }
}