Import-Module .\UnifiStockTracker.psd1 -Force

Wait-UnifiStockLegacy -ProductName 'UniFi6 Mesh', 'G4 Doorbell Pro', 'Camera G4 Pro', 'Test' -Seconds 60 -Store Brazil
Wait-UnifiStockLegacy -ProductSKU 'UDR-EU' -ProductName 'Switch Flex XG' -Seconds 60 -Store Brazil
Wait-UnifiStockLegacy -ProductName 'Access Point AC Lite' -Seconds 60 -Store Brazil