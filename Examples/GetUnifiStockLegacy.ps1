Import-Module .\UnifiStockTracker.psd1 -Force

# following examples will only work for non-eu, non-us shops that are not yet converted to the new shop
Get-UnifiStockLegacy -Store Brazil -Collection Protect, ProtectAccessories, ProtectNVR | Sort-Object -Property Name | Format-Table
Get-UnifiStockLegacy -Store Brazil -Collection Protect, NetworkWifi | Sort-Object -Property Name | Format-Table
Get-UnifiStockLegacy -Store Brazil | Sort-Object -Property Name | Format-Table
Get-UnifiStockLegacy -Store Brazil -Collection UnifiAccessories | Sort-Object -Property Name | Format-Table
Get-UnifiStockLegacy -Store Brazil -Collection UnifiAccessories | Sort-Object -Property Name | Format-Table
Get-UnifiStockLegacy -Store Brazil -Collection UnifiAccessories | Sort-Object -Property Name | Format-Table
Get-UnifiStockLegacy -Store Brazil -Collection EarlyAccess | Sort-Object -Property Name | Format-Table
Get-UnifiStockLegacy -Verbose -Store Brazil -Collection UnifiPhoneSystem, EarlyAccessConnect, EarlyAccessDoorAccess | Sort-Object -Property Name | Format-Table