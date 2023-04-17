Import-Module .\UnifiStockTracker.psd1 -Force

Get-UnifiStock -Store USA -Collection Protect, ProtectAccessories, ProtectNVR -Verbose | Sort-Object -Property Name | Format-Table
Get-UnifiStock -Store Europe -Collection Protect, NetworkWifi -Verbose | Sort-Object -Property Name | Format-Table
Get-UnifiStock -Store Europe -Verbose | Sort-Object -Property Name | Format-Table