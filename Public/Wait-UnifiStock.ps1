function Wait-UnifiStock {
    [cmdletBinding()]
    param(
        [string[]] $ProductName,
        [string[]] $ProductSKU,
        [ValidateSet('Europe', 'USA', 'Brazil')][string] $Store = 'Europe',
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
            if ($Name -in $CurrentStock.Name) {
                $Name
            } else {
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
    if ($ApplicableProducts.Count -eq 0) {
        Write-Color -Text "No products requested by user not found on list of available products. Exiting" -Color Red
        return
    }

    $Collections = @(
        foreach ($Product in $ApplicableProducts) {
            $Cache[$Product].Category
        }
    ) | Select-Object -Unique

    Write-Color -Text "Setting up monitoring for ", ($ApplicableProducts -join ", ") -Color Yellow, Green
    $Count = 0
    Do {
        if ($Count -ne 0) {
            Start-Sleep -Seconds $Seconds
        }
        Write-Color -Text "Checking stock..." -Color Yellow
        $CurrentResults = Get-UnifiStock -Store $Store -Collection $Collections | Where-Object {
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
            $voice = New-Object -ComObject Sapi.spvoice

            # Set the speed - positive numbers are faster, negative numbers, slower
            $voice.rate = 0

            # Say something
            $null = $voice.speak("Hey,there is stock available for $($Product.Name)")
        }
        if (-not $DoNotUseBeep) {
            [console]::beep(500, 300)
        }
    }
}