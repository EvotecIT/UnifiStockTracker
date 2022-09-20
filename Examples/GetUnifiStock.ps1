Import-Module .\UnifiStockTracker.psd1 -Force

Get-UnifiStock -Store Europe -Collection Protect, ProtectAccessories, ProtectNVR | Sort-Object -Property Name | Format-Table
Get-UnifiStock -Store USA -Collection Protect, ProtectAccessories, ProtectNVR | Sort-Object -Property Name | Format-Table