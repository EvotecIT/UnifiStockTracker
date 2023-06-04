---
external help file: UnifiStockTracker-help.xml
Module Name: UnifiStockTracker
online version:
schema: 2.0.0
---

# Get-UnifiStockLegacy

## SYNOPSIS
Get the stock status of Ubiquiti products from their online store.

## SYNTAX

```
Get-UnifiStockLegacy [-Store] <String> [[-Collection] <String[]>] [<CommonParameters>]
```

## DESCRIPTION
Get the stock status of Ubiquiti products from their online store.

## EXAMPLES

### EXAMPLE 1
```
Get-UnifiStock -Store USA -Collection Protect, ProtectAccessories, ProtectNVR | Sort-Object -Property Name | Format-Table
```

### EXAMPLE 2
```
Get-UnifiStock -Store Europe -Collection Protect, NetworkWifi | Sort-Object -Property Name | Format-Table
```

### EXAMPLE 3
```
Get-UnifiStock -Store Europe | Sort-Object -Property Name | Format-Table
```

## PARAMETERS

### -Store
The store to check for stock.
Valid values are: Europe, USA, Brazil, India, Japan, Taiwan, Signapore, Mexico, China

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Collection
Which collection to list.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
General notes

## RELATED LINKS
