Import-Module .\UnifiStockTracker.psd1 -Force

Wait-UnifiStock -ProductName 'UniFi6 Mesh', 'G4 Doorbell Pro', 'Camera G4 Pro' -Seconds 60