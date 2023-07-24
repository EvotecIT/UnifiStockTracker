function Wait-UnifiStock {
    <#
    .SYNOPSIS
    When run waits for the specified SKU or Product to be in stock in Ubiquiti's online store.

    .DESCRIPTION
    When run waits for the specified SKU or Product to be in stock in Ubiquiti's online store.
    Once the product is in stock the function will play a beep, read which product is in stock and open a browser to specific product page.

    .PARAMETER ProductName
    One or more products to wait for to be in stock with search by it's Name

    .PARAMETER ProductSKU
    One or more products to wait for to be in stock with search by it's SKU

    .PARAMETER Store
    The store to check for stock. Valid values are Europe, USA and UK.
    If you want to use a different store you can use Wait-UnifiStockLegacy for other countries.
    This is because the legacy store has a different format for the JSON data, and are not yet migrated to new "look"

    .PARAMETER Seconds
    The number of seconds to wait between checks. Default is 60 seconds.

    .PARAMETER DoNotOpenWebsite
    If specified the website will not be opened when the product is in stock.

    .PARAMETER DoNotPlaySound
    If specified the sound will not be played when the product is in stock.

    .PARAMETER DoNotUseBeep
    If specified the beep will not be played when the product is in stock.

    .EXAMPLE
    Wait-UnifiStock -ProductSKU 'UDR-EU' -ProductName 'Switch Flex XG' -Seconds 60 -Store Europe

    .EXAMPLE
    Wait-UnifiStock -ProductName 'UniFi6 Mesh', 'G4 Doorbell Pro', 'Camera G4 Pro', 'Test' -Seconds 60 -Store Europe

    .EXAMPLE
    Wait-UnifiStock -ProductName 'UniFi6 Mesh', 'G4 Doorbell Pro', 'Camera G4 Pro', 'Test' -Seconds 60 -DoNotUseBeep -Store Europe

    .NOTES
    General notes
    #>
    [cmdletBinding()]
    param(
        [string[]] $ProductName,
        [string[]] $ProductSKU,
        [parameter(Mandatory)][ValidateSet('Europe', 'USA', 'UK')][string] $Store,
        [int] $Seconds = 60,
        [switch] $DoNotOpenWebsite,
        [switch] $DoNotPlaySound,
        [switch] $DoNotUseBeep
    )
    $Cache = [ordered] @{}
    $CurrentStock = Get-UnifiStock -Store $Store
    foreach ($Product in $CurrentStock) {
        $Cache[$Product.Name] = $Product
        $Cache[$Product.SKU] = $Product
    }

    [Array] $ApplicableProducts = @(
        foreach ($Name in $ProductName) {
            $Found = $false
            foreach ($StockName in $CurrentStock.Name) {
                if ($StockName -like "$Name") {
                    $StockName
                    $found = $true
                }
            }
            if (-not $Found) {
                Write-Color -Text "Product Name '$Name' not found in stock. Ignoring" -Color Red
            }
        }
        foreach ($Name in $ProductSKU) {
            if ($Name -in $CurrentStock.SKU) {
                $Name
            } else {
                Write-Color -Text "Product SKU '$Name' not found in stock. Ignoring" -Color Red
            }
        }
    )
    $ApplicableProducts = $ApplicableProducts | Sort-Object -Unique
    if ($ApplicableProducts.Count -eq 0) {
        Write-Color -Text "No products requested by user not found on list of available products. Exiting" -Color Red
        return
    }

    # $Collections = @(
    #     foreach ($Product in $ApplicableProducts) {
    #         $Cache[$Product].Category
    #     }
    # ) | Select-Object -Unique

    Write-Color -Text "Setting up monitoring for ", ($ApplicableProducts -join ", ") -Color Yellow, Green
    $Count = 0
    Do {
        if ($Count -ne 0) {
            Start-Sleep -Seconds $Seconds
        }
        Write-Color -Text "Checking stock..." -Color Yellow
        $CurrentResults = Get-UnifiStock -Store $Store | Where-Object {
            $_.Name -in $ApplicableProducts -or $_.SKU -in $ApplicableProducts
        } | Sort-Object -Property Name
        Write-Color -Text "Checking stock... Done, sleeping for $Seconds seconds" -Color Green
        $Count++
    } While ($CurrentResults.Available -notcontains $true)

    foreach ($Product in $CurrentResults | Where-Object { $_.Available -eq $true }) {
        Write-Color -Text "Product ", $($Product.Name), " is in stock! ", "SKU: $($Product.SKU)" -Color Yellow, Green, Yellow, Green

        if (-not $DoNotOpenWebsite) {
            Start-Process $Product.ProductUrl
        }

        if (-not $DoNotPlaySound) {
            try {
                $Voice = New-Object -ComObject Sapi.spvoice -ErrorAction Stop
            } catch {
                Write-Color -Text "Failed to create voice object. Error: $($_.Exception.Message)" -Color Red
            }
            if ($Voice) {
                # Set the speed - positive numbers are faster, negative numbers, slower
                $voice.rate = 0

                # Say something
                try {
                    $null = $voice.speak("Hey,there is stock available for $($Product.Name)")
                } catch {
                    Write-Color -Text "Failed to speak. Error: $($_.Exception.Message)" -Color Red
                }
            }
        }
        if (-not $DoNotUseBeep) {
            [console]::beep(500, 300)
        }
    }
}