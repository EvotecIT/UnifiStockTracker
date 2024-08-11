function Get-UnifiStock {
    <#
    .SYNOPSIS
    Get the stock status of Ubiquiti products from their online store.

    .DESCRIPTION
    Get the stock status of Ubiquiti products from their online store.

    .PARAMETER Store
    The store to check for stock. Valid values are: Europe, USA, UK
    If you want to use a different store you can use Get-UnifiStockLegacy for other countries.
    This is because the legacy store has a different format for the JSON data, and are not yet migrated to new "look"

    .PARAMETER Collection
    Which collection to list.

    .EXAMPLE
    Get-UnifiStock -Store USA -Collection AccessoriesCabling, CableBox | Sort-Object -Property Name | Format-Table

        .EXAMPLE
    Get-UnifiStock -Store Europe -Collection HostingAndGatewaysCloud,DreamMachine, DreamRouter | Sort-Object -Property Name | Format-Table

    .EXAMPLE
    Get-UnifiStock -Store Europe | Sort-Object -Property Name | Format-Table

    .NOTES
    General notes
    #>
    [cmdletbinding()]
    param(
        [ValidateSet('Europe', 'USA', 'UK')]
        [Parameter(Mandatory)][string] $Store,
        [ValidateSet(
            'AccessoriesCabling',
            'AccessPointMounting',
            'AccessPointSkins',
            'CableBox',
            'CablePatch',
            'CableSFP',
            'CameraEnhancers',
            'CameraSecurityBulletDSLR',
            'CameraSecurityBulletHighPerformance',
            'CameraSecurityBulletStandard',
            'CameraSecurityCompactPoEWired',
            'CameraSecurityCompactWiFiConnected',
            'CameraSecurityDome360',
            'CameraSecurityDomeSlim',
            'CameraSecurityDoorAccessAccessories',
            'CameraSecurityDoorAccessReaders',
            'CameraSecurityDoorAccessStarterKit',
            'CameraSecurityInteriorDesign',
            'CameraSecurityNVRLargeScale',
            'CameraSecurityNVRMidScale',
            'CameraSecurityPTZ',
            'CameraSecuritySpecialChime',
            'CameraSecuritySpecialSensor',
            'CameraSecuritySpecialViewport',
            'CameraSecuritySpecialWiFiDoorbell',
            'CameraSkins',
            'DesktopStands',
            'DeviceMounting',
            'DreamMachine',
            'DreamRouter',
            'HDDStorage',
            'HostingAndGatewaysCloud',
            'HostingAndGatewaysLargeScale',
            'HostingAndGatewaysSmallScale',
            'InstallationsRackmount',
            'InternetBackup',
            'NewIntegrationsAVDisplayMounting',
            'NewIntegrationsAVGiantPoETouchscreens',
            'NewIntegrationsPhoneATA',
            'NewIntegrationsPhoneCompact',
            'NewIntegrationsPhoneExecutive',
            'PoEAndPower',
            'PoEPower',
            'PowerTechPowerRedundancy',
            'PowerTechUninterruptiblePoE',
            'SwitchingEnterpriseAggregation',
            'SwitchingEnterprisePoE',
            'SwitchingProEthernet',
            'SwitchingProPoE',
            'SwitchingStandardEthernet',
            'SwitchingStandardPoE',
            'SwitchingUtility10GbpsEthernet',
            'SwitchingUtilityMini',
            'SwitchingUtilityPoE',
            'WiFiBuildingBridge10Gigabit',
            'WiFiFlagshipCompact',
            'WiFiFlagshipHighCapacity',
            'WiFiInWallOutletMesh',
            'WiFiMan',
            'WiFiOutdoorFlexible',
            'WiFiFlagshipLongRange',
            'WiFiOutdoorLongRange',
            "NewIntegrationsMobileRouting",
            "CameraSecurityDoorAccessHub",
            "NewIntegrationsAVDigitalSignage",
            "SwitchingUtilityIndustrial",
            "SwitchingUtilityIndoorOutdoor",
            "SwitchingEnterprise10GbpsEthernet",
            "SwitchingUtilityHiPowerPoE",
            "WiFiMegaCapacity",
            "PowerTechUninterruptiblePower",
            "PowerTechPowerDistribution",
            "CameraSecuritySpecialFloodlight",
            "DreamWall",
            "NewIntegrationsEVCharging",
            "CloudKeyRackMount",
            "AmpliFiMesh",
            "AmpliFiAlien",
            "WiFiInWallCompact",
            "WiFiInWallHighCapacity",
            "AccessPointAntennas",
            "CameraSecurityBulletEnhancedAI",
            "WiFiBuildingBridgeGigabit",
            # organizational collections
            "Cabling", "AccessPointMounting", "AccessPointSkins",
            "CableSFP", "CameraEnhancers", "CameraSkins", "DeviceMounting", "DisplayMounting",
            "HostingAndGatewaysCloud", "HostingAndGatewaysLargeScale", "HostingAndGatewaysSmallScale",
            "PoEAndPower", "PoEPower", "WiFiManager", "InternetBackup", "PowerRedundancy",
            "ProEthernetSwitching", "StandardEthernetSwitching", "StandardPoESwitching",
            "10GbpsEthernetSwitching", "PoESwitching",
            "FlagshipCompactWiFi", "FlagshipHighCapacityWiFi", "InWallHighCapacityWiFi", "OutdoorFlexibleWiFi", "UICare"
        )][string[]] $Collection
    )

    $Stores = @{
        Europe = 'eu'
        USA    = 'us'
        UK     = 'uk'
    }

    $StoreLinks = @{
        Europe = 'https://eu.store.ui.com/eu/en'
        USA    = 'https://store.ui.com/us/en'
        UK     = 'https://uk.store.ui.com/uk/en'
    }

    $Accessories = @{
        # direct collections
        "uisp-accessories-cabling"                              = "AccessoriesCabling"
        "unifi-accessory-tech-access-point-mounting"            = "AccessPointMounting"
        "unifi-accessory-tech-access-point-skins"               = "AccessPointSkins"
        "unifi-accessory-tech-cable-box"                        = "CableBox"
        "unifi-accessory-tech-cable-patch"                      = "CablePatch"
        "unifi-accessory-tech-cable-sfp"                        = "CableSFP"
        "unifi-accessory-tech-camera-enhancers"                 = "CameraEnhancers"
        "unifi-accessory-tech-camera-skins"                     = "CameraSkins"
        "unifi-accessory-tech-desktop-stands"                   = "DesktopStands"
        "unifi-accessory-tech-device-mounting"                  = "DeviceMounting"
        "unifi-accessory-tech-hdd-storage"                      = "HDDStorage"
        "unifi-accessory-tech-hosting-and-gateways-cloud"       = "HostingAndGatewaysCloud"
        "unifi-accessory-tech-hosting-and-gateways-large-scale" = "HostingAndGatewaysLargeScale"
        "unifi-accessory-tech-hosting-and-gateways-small-scale" = "HostingAndGatewaysSmallScale"
        "unifi-accessory-tech-installations-rackmount"          = "InstallationsRackmount"
        "unifi-accessory-tech-poe-and-power"                    = "PoEAndPower"
        "unifi-accessory-tech-poe-power"                        = "PoEPower"
        "unifi-accessory-tech-wifiman"                          = "WiFiMan"
        "unifi-camera-security-bullet-dslr"                     = "CameraSecurityBulletDSLR"
        "unifi-camera-security-bullet-high-performance"         = "CameraSecurityBulletHighPerformance"
        "unifi-camera-security-bullet-standard"                 = "CameraSecurityBulletStandard"
        "unifi-camera-security-compact-poe-wired"               = "CameraSecurityCompactPoEWired"
        "unifi-camera-security-compact-wifi-connected"          = "CameraSecurityCompactWiFiConnected"
        "unifi-camera-security-dome-360"                        = "CameraSecurityDome360"
        "unifi-camera-security-dome-slim"                       = "CameraSecurityDomeSlim"
        "unifi-camera-security-door-access-accessories"         = "CameraSecurityDoorAccessAccessories"
        "unifi-camera-security-door-access-readers"             = "CameraSecurityDoorAccessReaders"
        "unifi-camera-security-door-access-starter-kit"         = "CameraSecurityDoorAccessStarterKit"
        "unifi-camera-security-interior-design"                 = "CameraSecurityInteriorDesign"
        "unifi-camera-security-nvr-large-scale"                 = "CameraSecurityNVRLargeScale"
        "unifi-camera-security-nvr-mid-scale"                   = "CameraSecurityNVRMidScale"
        "unifi-camera-security-ptz"                             = "CameraSecurityPTZ"
        "unifi-camera-security-special-chime"                   = "CameraSecuritySpecialChime"
        "unifi-camera-security-special-sensor"                  = "CameraSecuritySpecialSensor"
        "unifi-camera-security-special-viewport"                = "CameraSecuritySpecialViewport"
        "unifi-camera-security-special-wifi-doorbell"           = "CameraSecuritySpecialWiFiDoorbell"
        "unifi-dream-machine"                                   = "DreamMachine"
        "unifi-dream-router"                                    = "DreamRouter"
        "unifi-internet-backup"                                 = "InternetBackup"
        "unifi-new-integrations-av-display-mounting"            = "NewIntegrationsAVDisplayMounting"
        "unifi-new-integrations-av-giant-poe-touchscreens"      = "NewIntegrationsAVGiantPoETouchscreens"
        "unifi-new-integrations-phone-ata"                      = "NewIntegrationsPhoneATA"
        "unifi-new-integrations-phone-compact"                  = "NewIntegrationsPhoneCompact"
        "unifi-new-integrations-phone-executive"                = "NewIntegrationsPhoneExecutive"
        "unifi-power-tech-power-redundancy"                     = "PowerTechPowerRedundancy"
        "unifi-power-tech-uninterruptible-poe"                  = "PowerTechUninterruptiblePoE"
        "unifi-switching-enterprise-aggregation"                = "SwitchingEnterpriseAggregation"
        "unifi-switching-enterprise-power-over-ethernet"        = "SwitchingEnterprisePoE"
        "unifi-switching-pro-ethernet"                          = "SwitchingProEthernet"
        "unifi-switching-pro-power-over-ethernet"               = "SwitchingProPoE"
        "unifi-switching-standard-ethernet"                     = "SwitchingStandardEthernet"
        "unifi-switching-standard-power-over-ethernet"          = "SwitchingStandardPoE"
        "unifi-switching-utility-10-gbps-ethernet"              = "SwitchingUtility10GbpsEthernet"
        "unifi-switching-utility-mini"                          = "SwitchingUtilityMini"
        "unifi-switching-utility-poe"                           = "SwitchingUtilityPoE"
        "unifi-wifi-building-bridge-10-gigabit"                 = "WiFiBuildingBridge10Gigabit"
        "unifi-wifi-flagship-compact"                           = "WiFiFlagshipCompact"
        "unifi-wifi-flagship-high-capacity"                     = "WiFiFlagshipHighCapacity"
        "unifi-wifi-inwall-outlet-mesh"                         = "WiFiInWallOutletMesh"
        "unifi-wifi-outdoor-flexible"                           = "WiFiOutdoorFlexible"
        "unifi-wifi-flagship-long-range"                        = "WiFiFlagshipLongRange"
        "unifi-wifi-outdoor-long-range"                         = "WiFiOutdoorLongRange"

        "unifi-new-integrations-mobile-routing"                 = "NewIntegrationsMobileRouting"
        "unifi-camera-security-door-access-hub"                 = "CameraSecurityDoorAccessHub"
        "unifi-new-integrations-av-digital-signage"             = "NewIntegrationsAVDigitalSignage"
        "unifi-switching-utility-industrial"                    = "SwitchingUtilityIndustrial"
        "unifi-switching-utility-indoor-outdoor"                = "SwitchingUtilityIndoorOutdoor"
        "unifi-switching-enterprise-10-gbps-ethernet"           = "SwitchingEnterprise10GbpsEthernet"
        "unifi-switching-utility-hi-power-poe"                  = "SwitchingUtilityHiPowerPoE"
        "unifi-wifi-mega-capacity"                              = "WiFiMegaCapacity"
        "unifi-power-tech-uninterruptible-power"                = "PowerTechUninterruptiblePower"
        "unifi-power-tech-power-distribution"                   = "PowerTechPowerDistribution"
        "unifi-camera-security-special-floodlight"              = "CameraSecuritySpecialFloodlight"
        "unifi-dream-wall"                                      = "DreamWall"
        "unifi-new-integrations-ev-charging"                    = "NewIntegrationsEVCharging"
        "cloud-key-rack-mount"                                  = "CloudKeyRackMount"
        "amplifi-mesh"                                          = "AmpliFiMesh"
        "amplifi-alien"                                         = "AmpliFiAlien"
        "unifi-wifi-inwall-compact"                             = "WiFiInWallCompact"
        "unifi-wifi-inwall-high-capacity"                       = "WiFiInWallHighCapacity"
        "unifi-accessory-tech-access-point-antennas"            = "AccessPointAntennas"
        "unifi-camera-security-bullet-enhanced-ai"              = "CameraSecurityBulletEnhancedAI"
        "unifi-wifi-building-bridge-gigabit"                    = "WiFiBuildingBridgeGigabit"

        # organizational collection
        "accessories-cabling"                                   = "Cabling"
        "accessory-tech-access-point-mounting"                  = "AccessPointMounting"
        "accessory-tech-access-point-skins"                     = "AccessPointSkins"
        "accessory-tech-cable-sfp"                              = "CableSFP"
        "accessory-tech-camera-enhancers"                       = "CameraEnhancers"
        "accessory-tech-camera-skins"                           = "CameraSkins"
        "accessory-tech-device-mounting"                        = "DeviceMounting"
        "accessory-tech-display-mounting"                       = "DisplayMounting"
        "accessory-tech-hosting-and-gateways-cloud"             = "HostingAndGatewaysCloud"
        "accessory-tech-hosting-and-gateways-large-scale"       = "HostingAndGatewaysLargeScale"
        "accessory-tech-hosting-and-gateways-small-scale"       = "HostingAndGatewaysSmallScale"
        "accessory-tech-poe-and-power"                          = "PoEAndPower"
        "accessory-tech-poe-power"                              = "PoEPower"
        "accessory-tech-wifiman"                                = "WiFiManager"
        "internet-backup"                                       = "InternetBackup"
        "power-tech-power-redundancy"                           = "PowerRedundancy"
        "switching-pro-ethernet"                                = "ProEthernetSwitching"
        "switching-standard-ethernet"                           = "StandardEthernetSwitching"
        "switching-standard-power-over-ethernet"                = "StandardPoESwitching"
        "switching-utility-10-gbps-ethernet"                    = "10GbpsEthernetSwitching"
        "switching-utility-poe"                                 = "PoESwitching"
        "wifi-flagship-compact"                                 = "FlagshipCompactWiFi"
        "wifi-flagship-high-capacity"                           = "FlagshipHighCapacityWiFi"
        "wifi-inwall-high-capacity"                             = "InWallHighCapacityWiFi"
        "wifi-outdoor-flexible"                                 = "OutdoorFlexibleWiFi"

        "ui-care"                                               = "UICare"
    }

    $UrlStore = $Stores[$Store]
    $UrlStoreLink = $StoreLinks[$Store]

    $ProgressPreference = 'SilentlyContinue'
    try {
        Write-Verbose -Message "Get-UnifiStock - Getting Unifi products"

        $invokeRestMethodSplat = @{
            UseBasicParsing = $true
            Uri             = "https://ecomm.svc.ui.com/graphql"
            Method          = 'Post'
            ContentType     = "application/json"
        }

        $Limit = 250
        $Offset = 0
        $Total = 1

        $Products = while ($offset -lt $total) {

            $Body = [ordered] @{
                operationName = "GetProductsForLandingPagePro"
                variables     = @{
                    input = @{
                        limit  = $Limit
                        offset = $Offset
                        filter = @{
                            storeId  = "$UrlStore"
                            language = "en"
                            line     = "Unifi"
                        }
                    }
                }
                query         = @"
query GetProductsForLandingPagePro(`$input: StorefrontProductListInput!) {
  storefrontProducts(input: `$input) {
    pagination {
      limit
      offset
      total
      __typename
    }
    items {
      ...LandingProProductFragment
      __typename
    }
    __typename
  }
}

fragment LandingProProductFragment on StorefrontProduct {
  id
  title
  shortTitle
  name
  slug
  collectionSlug
  organizationalCollectionSlug
  shortDescription
  tags {
    name
    __typename
  }
  gallery {
    ...ImageOnlyGalleryFragment
    __typename
  }
  options {
    id
    title
    values {
      id
      title
      __typename
    }
    __typename
  }
  variants {
    id
    sku
    status
    title
    galleryItemIds
    isEarlyAccess
    optionValueIds
    displayPrice {
      ...MoneyFragment
      __typename
    }
    hasPurchaseHistory
    __typename
  }
  __typename
}

fragment ImageOnlyGalleryFragment on Gallery {
  id
  items {
    id
    data {
      __typename
      ... on Asset {
        id
        mimeType
        url
        height
        width
        __typename
      }
    }
    __typename
  }
  type
  __typename
}

fragment MoneyFragment on Money {
  amount
  currency
  __typename
}
"@
            }
            $invokeRestMethodSplat.Body = $Body | ConvertTo-Json -Depth 10
            $Output = Invoke-RestMethod @invokeRestMethodSplat
            $CurrentProducts = $Output.data.storefrontProducts.items
            $CurrentProducts
            $Pagination = $Output.data.storefrontProducts.pagination
            $total = $pagination.total
            $offset += $limit
        }
    } catch {
        Write-Color -Text "Unable to get Unifi products. Error: $($_.Exception.Message)" -Color Red
        return
    }
    if ($Products) {
        Write-Verbose -Message "Get-UnifiStock - Got $($Products.Count) products"
        $UnifiProducts = foreach ($Product in $Products) {
            foreach ($Variant in $Product.variants) {
                if ($Product.collectionSlug) {
                    $Category = $Accessories[$Product.collectionSlug]
                } elseif ($Product.organizationalCollectionSlug) {
                    $Category = $Accessories[$Product.organizationalCollectionSlug]
                } else {
                    $Category = 'Unknown'
                }
                if ($Collection) {
                    if ($Category -notin $Collection) {
                        continue
                    }
                }
                [PSCustomObject] @{
                    Name                         = $Product.title
                    ShortName                    = $Product.shortTitle
                    Available                    = $Variant.status -eq 'AVAILABLE'
                    Category                     = $Category
                    Collection                   = $Product.collectionSlug
                    OrganizationalCollectionSlug = $Product.organizationalCollectionSlug
                    SKU                          = $Variant.sku
                    SKUName                      = $Variant.title
                    EarlyAccess                  = $Variant.isEarlyAccess
                    ProductUrl                   = "$UrlStoreLink/collections/$($Product.collectionSlug)/products/$($Product.slug)"
                    #Tags                         = $Product.tags
                }
            }
        }
        $UnifiProducts
    }
}