---
external help file: UnifiStockTracker-help.xml
Module Name: UnifiStockTracker
online version:
schema: 2.0.0
---

# Wait-UnifiStockLegacy

## SYNOPSIS
When run waits for the specified SKU or Product to be in stock in Ubiquiti's online store.

## SYNTAX

```
Wait-UnifiStockLegacy [[-ProductName] <String[]>] [[-ProductSKU] <String[]>] [-Store] <String>
 [[-Seconds] <Int32>] [-DoNotOpenWebsite] [-DoNotPlaySound] [-DoNotUseBeep] [<CommonParameters>]
```

## DESCRIPTION
When run waits for the specified SKU or Product to be in stock in Ubiquiti's online store.
Once the product is in stock the function will play a beep, read which product is in stock and open a browser to specific product page.

## EXAMPLES

### EXAMPLE 1
```
Wait-UnifiStockLegacy -ProductSKU 'UDR-EU' -ProductName 'Switch Flex XG' -Seconds 60 -Store Brazil
```

### EXAMPLE 2
```
Wait-UnifiStockLegacy -ProductName 'UniFi6 Mesh', 'G4 Doorbell Pro', 'Camera G4 Pro', 'Test' -Seconds 60 -Store Brazil
```

### EXAMPLE 3
```
Wait-UnifiStockLegacy -ProductName 'UniFi6 Mesh', 'G4 Doorbell Pro', 'Camera G4 Pro', 'Test' -Seconds 60 -DoNotUseBeep -Store Brazil
```

## PARAMETERS

### -ProductName
One or more products to wait for to be in stock with search by it's Name

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ProductSKU
One or more products to wait for to be in stock with search by it's SKU

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

### -Store
The store to check for stock.
Valid values are Brazil, India, Japan, Taiwan, Signapore, Mexico, China
If you want EU/USA store you can use Wait-UnifiStock for those.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Seconds
The number of seconds to wait between checks.
Default is 60 seconds.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 60
Accept pipeline input: False
Accept wildcard characters: False
```

### -DoNotOpenWebsite
If specified the website will not be opened when the product is in stock.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -DoNotPlaySound
If specified the sound will not be played when the product is in stock.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -DoNotUseBeep
If specified the beep will not be played when the product is in stock.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
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
