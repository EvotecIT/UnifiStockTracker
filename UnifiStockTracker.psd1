﻿@{
    AliasesToExport      = @()
    Author               = 'Przemyslaw Klys'
    CmdletsToExport      = @()
    CompanyName          = 'Evotec'
    CompatiblePSEditions = @('Desktop', 'Core')
    Copyright            = '(c) 2011 - 2023 Przemyslaw Klys @ Evotec. All rights reserved.'
    Description          = 'PowerShell module to get current stock in Ubiquiti Unifi store'
    FunctionsToExport    = @('Get-UnifiStock', 'Wait-UnifiStock')
    GUID                 = 'e3d09753-16be-4535-b74f-d9a4c6927a54'
    ModuleVersion        = '1.0.0'
    PowerShellVersion    = '5.1'
    PrivateData          = @{
        PSData = @{
            Tags                       = @('Windows', 'macOS', 'Linux', 'Ubiquiti', 'Unifi', 'Stock', 'Tracker')
            ProjectUri                 = 'https://github.com/EvotecIT/UnifiStockTracker'
            IconUri                    = 'https://help.ui.com/hc/article_attachments/360010605813/ubiquiti_logo.png'
            ExternalModuleDependencies = @('Microsoft.PowerShell.Management', 'Microsoft.PowerShell.Utility')
        }
    }
    RequiredModules      = @(@{
            ModuleName    = 'PSSharedGoods'
            ModuleVersion = '0.0.260'
            Guid          = 'ee272aa8-baaa-4edf-9f45-b6d6f7d844fe'
        }, @{
            ModuleName    = 'PSWriteColor'
            ModuleVersion = '0.87.3'
            Guid          = '0b0ba5c5-ec85-4c2b-a718-874e55a8bc3f'
        }, 'Microsoft.PowerShell.Management', 'Microsoft.PowerShell.Utility')
    RootModule           = 'UnifiStockTracker.psm1'
}