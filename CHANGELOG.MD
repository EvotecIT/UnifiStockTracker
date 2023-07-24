### 2.1.0 - 2023.07.24
- Added UK store

### 2.0.0 - 2023.06.04
This Release resolves:
- https://github.com/EvotecIT/UnifiStockTracker/issues/2

It has breaking changes:
- New function `Get-UnifiStockLegacy/Wait-UnifiStockLegacy` work with non EU/US stores to provide backwards compatibility
- `Get-UnifiStock/WaitUnifiStock` now support only EU/US stores until legacy stores will also be migrated (if it ever happens)

### 1.0.3 - 2023.04.17
- Add multiple new collections. Currently supported collections are:
    - EarlyAccess
    - EarlyAccessConnect
    - EarlyAccessDoorAccess
    - EarlyAccessSmartpower
    - EarlyAccessUispFiber
    - EarlyAccessUispWired
    - EarlyAccessUispWireless
    - EarlyAccessUnifiNetworkHost
    - NetworkHost
    - NetworkOS
    - NetworkRoutingOffload
    - NetworkRoutingSwitching
    - NetworkSmartPower
    - NetworkSwitching
    - NetworkWifi
    - OperatorAirmaxAndLtu
    - OperatorIspInfrastructure
    - Protect
    - ProtectAccessories
    - ProtectNVR
    - UnifiAccessories
    - UnifiConnect
    - UnifiDoorAccess
    - UnifiPhoneSystem
### 1.0.2 - 2023.04.17
- Adds error handling if date parsing fails

### 1.0.1 - 2023.04.15
- Small improvement in error handling
-
### 1.0.0 - 2023.04.15
- First release