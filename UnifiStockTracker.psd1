@{
    AliasesToExport      = @()
    Author               = 'Przemyslaw Klys'
    CmdletsToExport      = @()
    CompanyName          = 'Evotec'
    CompatiblePSEditions = @('Desktop', 'Core')
    Copyright            = '(c) 2011 - 2024 Przemyslaw Klys @ Evotec. All rights reserved.'
    Description          = 'PowerShell module to get current stock in Ubiquiti Unifi store'
    FunctionsToExport    = @('Get-UnifiStock', 'Get-UnifiStockLegacy', 'Wait-UnifiStock', 'Wait-UnifiStockLegacy')
    GUID                 = 'e3d09753-16be-4535-b74f-d9a4c6927a54'
    ModuleVersion        = '2.2.0'
    PowerShellVersion    = '5.1'
    PrivateData          = @{
        PSData = @{
            ExternalModuleDependencies = @('Microsoft.PowerShell.Management', 'Microsoft.PowerShell.Utility')
            IconUri                    = 'https://help.ui.com/hc/article_attachments/360010605813/ubiquiti_logo.png'
            ProjectUri                 = 'https://github.com/EvotecIT/UnifiStockTracker'
            Tags                       = @('Windows', 'macOS', 'Linux', 'Ubiquiti', 'Unifi', 'Stock', 'Tracker')
        }
    }
    RequiredModules      = @(@{
            Guid          = '0b0ba5c5-ec85-4c2b-a718-874e55a8bc3f'
            ModuleName    = 'PSWriteColor'
            ModuleVersion = '1.0.1'
        }, 'Microsoft.PowerShell.Management', 'Microsoft.PowerShell.Utility')
    RootModule           = 'UnifiStockTracker.psm1'
}