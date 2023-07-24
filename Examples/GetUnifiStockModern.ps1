Import-Module .\UnifiStockTracker.psd1 -Force

Get-UnifiStock -Store UK | Sort-Object -Property Name | Format-Table
Get-UnifiStock -Store USA -Verbose | Sort-Object -Property Name | Format-Table

Get-UnifiStock -Store USA -Collection AccessoriesCabling, CableBox | Sort-Object -Property Name | Format-Table
Get-UnifiStock -Store Europe -Collection CameraSecurityDome360, CameraSecurityCompactPoEWired | Sort-Object -Property Name | Format-Table
Get-UnifiStock -Store USA -Collection HostingAndGatewaysCloud,DreamMachine, DreamRouter | Sort-Object -Property Name | Format-Table
Get-UnifiStock -Store Europe -Collection InternetBackup | Sort-Object -Property Name | Format-Table
Get-UnifiStock -Store Europe -Collection SwitchingProEthernet | Sort-Object -Property Name | Format-Table
Get-UnifiStock -Verbose -Store Europe -Collection NewIntegrationsPhoneATA, NewIntegrationsPhoneCompact, NewIntegrationsPhoneExecutive | Sort-Object -Property Name | Format-Table