function Wait-UnifiStock {
    [cmdletBinding()]
    param(
        [string[]] $ProductName,
        [int] $Seconds = 60,
        [switch] $DoNotOpenWebsite,
        [switch] $DoNotPlaySound,
        [switch] $DoNotUseBeep
    )

    $Count = 0
    Do {
        if ($Count -ne 0) {
            Start-Sleep -Seconds $Seconds
        }
        Write-Color -Text "Checking stock..." -Color Yellow
        $CurrentResults = Get-UnifiStock -Store Europe -Collection Protect, NetworkWifi | Where-Object { $_.Name -in $ProductName } | Sort-Object -Property Name
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