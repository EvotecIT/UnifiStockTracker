Import-Module .\UnifiStockTracker.psd1 -Force

#Get-UnifiStock -Store USA -Collection Protect, ProtectAccessories, ProtectNVR | Sort-Object -Property Name | Format-Table
#Get-UnifiStock -Store Europe -Collection Protect, NetworkWifi | Sort-Object -Property Name | Format-Table
#Get-UnifiStock -Store Europe | Sort-Object -Property Name | Format-Table

#Get-UnifiStock -Store USA -Collection UnifiAccessories | Sort-Object -Property Name | Format-Table
#Get-UnifiStock -Store Brazil -Collection UnifiAccessories | Sort-Object -Property Name | Format-Table
#Get-UnifiStock -Store Europe -Collection UnifiAccessories | Sort-Object -Property Name | Format-Table
#Get-UnifiStock -Store Europe -Collection EarlyAccess | Sort-Object -Property Name | Format-Table
Get-UnifiStock -Store USA -Collection EarlyAccessConnect,EarlyAccessDoorAccess | Sort-Object -Property Name | Format-Table