﻿Import-Module .\UnifiStockTracker.psd1 -Force

Wait-UnifiStock -ProductName 'UniFi6 Mesh', 'G4 Doorbell Pro', 'Camera G4 Pro', 'Test' -Seconds 60 -Store UK
Wait-UnifiStock -ProductSKU 'UDR-EU' -ProductName 'Switch Flex XG' -Seconds 60 -Store Europe
Wait-UnifiStock -ProductName 'Access Point AC Lite' -Seconds 60 -Store Europe