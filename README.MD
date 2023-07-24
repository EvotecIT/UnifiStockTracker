# UnifiStockTracker - PowerShell Module

<p align="center">
  <a href="https://dev.azure.com/evotecpl/UnifiStockTracker/_build/results?buildId=latest"><img src="https://img.shields.io/azure-devops/build/evotecpl/39c74615-8f34-4af0-a835-68dc33f9214f/14?label=Azure%20Pipelines&style=flat-square"></a>
  <a href="https://www.powershellgallery.com/packages/UnifiStockTracker"><img src="https://img.shields.io/powershellgallery/v/UnifiStockTracker.svg?style=flat-square"></a>
  <a href="https://www.powershellgallery.com/packages/UnifiStockTracker"><img src="https://img.shields.io/powershellgallery/vpre/UnifiStockTracker.svg?label=powershell%20gallery%20preview&colorB=yellow&style=flat-square"></a>
  <a href="https://github.com/EvotecIT/UnifiStockTracker"><img src="https://img.shields.io/github/license/EvotecIT/UnifiStockTracker.svg?style=flat-square"></a>
</p>

<p align="center">
  <a href="https://www.powershellgallery.com/packages/UnifiStockTracker"><img src="https://img.shields.io/powershellgallery/p/UnifiStockTracker.svg?style=flat-square"></a>
  <a href="https://github.com/EvotecIT/UnifiStockTracker"><img src="https://img.shields.io/github/languages/top/evotecit/UnifiStockTracker.svg?style=flat-square"></a>
  <a href="https://github.com/EvotecIT/UnifiStockTracker"><img src="https://img.shields.io/github/languages/code-size/evotecit/UnifiStockTracker.svg?style=flat-square"></a>
  <a href="https://www.powershellgallery.com/packages/UnifiStockTracker"><img src="https://img.shields.io/powershellgallery/dt/UnifiStockTracker.svg?style=flat-square"></a>
</p>

<p align="center">
  <a href="https://twitter.com/PrzemyslawKlys"><img src="https://img.shields.io/twitter/follow/PrzemyslawKlys.svg?label=Twitter%20%40PrzemyslawKlys&style=flat-square&logo=twitter"></a>
  <a href="https://evotec.xyz/hub"><img src="https://img.shields.io/badge/Blog-evotec.xyz-2A6496.svg?style=flat-square"></a>
  <a href="https://www.linkedin.com/in/pklys"><img src="https://img.shields.io/badge/LinkedIn-pklys-0077B5.svg?logo=LinkedIn&style=flat-square"></a>
</p>

`UnifiStockTracker` is a PowerShell module to get current stock on Europe, Brazil or USA Ubiquiti stores.
Since I was constantly checking stock on Ubiquiti store waiting for specific products I decided to automate it.
I know there are places doing the same thing such as:

- [x] [Ubiquiti in-stock Spam Alerts](https://www.reddit.com/r/UbiquitiInStock/)

But there is one problem - they monitor for every single product so you get a lot of spam. I wanted to monitor only for specific products, in my own time. So I created this module.

You can find more about this module on my blog (this blog is outdated due to redesign of Ubiquiti store for US/EU, but still valid for all other shops), but provides some background information:
- [Track Ubiquiti Unifi Stock, and get notified of changes](https://evotec.xyz/simplify-notifications-about-ubiquiti-unifi-stock/)

## Installation

This module is available to install from PowerShellGallery which is enabled by default on Windows.

```powershell
Install-Module -Name UnifiStockTracker -Scope CurrentUser -Verbose
```

## Usage

Due to Unifi store changes this module now contains 4 commands:

- `Get-UnifiStock` - supporting only US/EU/UK stores
- `Get-UnifiStockLegacy` - supporting all other stores
- `Wait-UnifiStock` - supporting only US/EU/UK stores
- `Wait-UnifiStockLegacy` - supporting all other stores

Once redesign for all stores will be done I'll try to fix other stores and remove compatibility with old ones.

### Getting a list of products (non-EU, non-USA) stores

Get all products from 3 categories in Brazil store, sort them by name and display

```powershell
Get-UnifiStockLegacy -Store Brazil -Collection Protect, ProtectAccessories, ProtectNVR | Sort-Object -Property Name | Format-Table
```

Get all products from 2 categories in Brazil store, sort them by name and display

```powershell
Get-UnifiStockLegacy -Store Brazil -Collection Protect, NetworkWifi | Sort-Object -Property Name | Format-Table
```

Get all products from India store, sort them by name and display

```powershell
Get-UnifiStockLegacy -Store India | Sort-Object -Property Name | Format-Table
```

### Waiting for specific products (non-EU, non-USA)

Wait for 4 products of which one will be ignored because it doesn't exists and recheck store every 60 seconds (Europe store is default)

```powershell
Wait-UnifiStockLegacy -ProductName 'UniFi6 Mesh', 'G4 Doorbell Pro', 'Camera G4 Pro', 'Test' -Seconds 60
```

Wait for 1 product via specific SKU and recheck store every 60 seconds (Europe store is default)

```powershell
Wait-UnifiStockLegacy -ProductSKU 'UDR-EU' -ProductName 'Switch Flex XG' -Seconds 60
```

### Getting a list of products (EU, USA) stores

```powershell
Get-UnifiStock -Store Europe | Sort-Object -Property Name | Format-Table
Get-UnifiStock -Store USA -Verbose | Sort-Object -Property Name | Format-Table

Get-UnifiStock -Store USA -Collection AccessoriesCabling, CableBox | Sort-Object -Property Name | Format-Table
Get-UnifiStock -Store Europe -Collection CameraSecurityDome360, CameraSecurityCompactPoEWired | Sort-Object -Property Name | Format-Table
Get-UnifiStock -Store USA -Collection HostingAndGatewaysCloud,DreamMachine, DreamRouter | Sort-Object -Property Name | Format-Table
```

### Waiting for specific products (EU, USA)

```powershell
Wait-UnifiStock -ProductName 'UniFi6 Mesh', 'G4 Doorbell Pro', 'Camera G4 Pro', 'Test' -Seconds 60 -Store USA
Wait-UnifiStock -ProductSKU 'UDR-EU' -ProductName 'Switch Flex XG' -Seconds 60 -Store Europe
Wait-UnifiStock -ProductName 'Access Point AC Lite' -Seconds 60 -Store Europe
```
