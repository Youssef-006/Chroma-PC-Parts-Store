# Place this in your chroma project root and run:
# Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
# .\download_images_v2.ps1

$dest = "src\main\resources\static\images\products"
New-Item -ItemType Directory -Force -Path $dest | Out-Null

# Use a real browser session to bypass 403s
$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
$session.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36"

$headers = @{
    "Accept" = "image/avif,image/webp,image/apng,image/svg+xml,image/*,*/*;q=0.8"
    "Accept-Language" = "en-US,en;q=0.9"
    "Accept-Encoding" = "gzip, deflate, br"
    "Referer" = "https://www.google.com/"
    "sec-ch-ua" = '"Chromium";v="124", "Google Chrome";v="124"'
    "sec-fetch-dest" = "image"
    "sec-fetch-mode" = "no-cors"
    "sec-fetch-site" = "cross-site"
}

$images = @{
    # CPUs - using Newegg's image CDN with proper referer
    "ryzen9-9950x.jpg"    = "https://c1.neweggimages.com/ProductImageCompressAll1280/19-113-841-V01.jpg"
    "i9-14900k.jpg"       = "https://c1.neweggimages.com/ProductImageCompressAll1280/19-118-438-V01.jpg"
    "ryzen5-7600x.jpg"    = "https://c1.neweggimages.com/ProductImageCompressAll1280/19-113-793-V01.jpg"
    "i5-14600k.jpg"       = "https://c1.neweggimages.com/ProductImageCompressAll1280/19-118-435-V01.jpg"
    "ryzen7-9700x.jpg"    = "https://c1.neweggimages.com/ProductImageCompressAll1280/19-113-840-V01.jpg"
    # GPUs
    "rtx4090.jpg"         = "https://c1.neweggimages.com/ProductImageCompressAll1280/14-137-743-V01.jpg"
    "rx7900xtx.jpg"       = "https://c1.neweggimages.com/ProductImageCompressAll1280/14-131-060-V01.jpg"
    "rtx4070ti.jpg"       = "https://c1.neweggimages.com/ProductImageCompressAll1280/14-137-755-V01.jpg"
    "rx7800xt.jpg"        = "https://c1.neweggimages.com/ProductImageCompressAll1280/14-131-083-V01.jpg"
    "rtx4060.jpg"         = "https://c1.neweggimages.com/ProductImageCompressAll1280/14-137-762-V01.jpg"
    "rtx3070.jpg"         = "https://c1.neweggimages.com/ProductImageCompressAll1280/14-137-597-V01.jpg"
    # RAM
    "corsair-dominator-ddr5.jpg"  = "https://c1.neweggimages.com/ProductImageCompressAll1280/20-236-853-V01.jpg"
    "gskill-trident-z5.jpg"       = "https://c1.neweggimages.com/ProductImageCompressAll1280/20-374-383-V01.jpg"
    "kingston-fury-ddr4.jpg"      = "https://c1.neweggimages.com/ProductImageCompressAll1280/20-242-666-V01.jpg"
    "corsair-vengeance-ddr5.jpg"  = "https://c1.neweggimages.com/ProductImageCompressAll1280/20-236-851-V01.jpg"
    "gskill-ripjaws-ddr4.jpg"     = "https://c1.neweggimages.com/ProductImageCompressAll1280/20-374-245-V01.jpg"
    # Motherboards
    "asus-rog-maximus-z790.jpg"   = "https://c1.neweggimages.com/ProductImageCompressAll1280/13-119-464-V01.jpg"
    "msi-meg-x670e.jpg"           = "https://c1.neweggimages.com/ProductImageCompressAll1280/13-144-612-V01.jpg"
    "gigabyte-b650-aorus.jpg"     = "https://c1.neweggimages.com/ProductImageCompressAll1280/13-145-420-V01.jpg"
    "asrock-z790-pro.jpg"         = "https://c1.neweggimages.com/ProductImageCompressAll1280/13-162-359-V01.jpg"
    "asus-tuf-b760.jpg"           = "https://c1.neweggimages.com/ProductImageCompressAll1280/13-119-530-V01.jpg"
    # Monitors
    "lg-27gp950.jpg"              = "https://c1.neweggimages.com/ProductImageCompressAll1280/24-005-109-V01.jpg"
    "samsung-odyssey-g7.jpg"      = "https://c1.neweggimages.com/ProductImageCompressAll1280/24-022-016-V01.jpg"
    "asus-rog-swift-pg279qm.jpg"  = "https://c1.neweggimages.com/ProductImageCompressAll1280/24-236-850-V01.jpg"
    "aoc-24g2sp.jpg"              = "https://c1.neweggimages.com/ProductImageCompressAll1280/24-212-013-V01.jpg"
    "lg-34wp65g.jpg"              = "https://c1.neweggimages.com/ProductImageCompressAll1280/24-005-093-V01.jpg"
    # PSUs
    "corsair-hx1000i.jpg"         = "https://c1.neweggimages.com/ProductImageCompressAll1280/17-139-308-V01.jpg"
    "evga-supernova-850.jpg"      = "https://c1.neweggimages.com/ProductImageCompressAll1280/17-438-160-V01.jpg"
    "seasonic-focus-gx750.jpg"    = "https://c1.neweggimages.com/ProductImageCompressAll1280/17-151-240-V01.jpg"
    "bequiet-pure-power-12.jpg"   = "https://c1.neweggimages.com/ProductImageCompressAll1280/17-801-053-V01.jpg"
    "thermaltake-gf3-1200w.jpg"   = "https://c1.neweggimages.com/ProductImageCompressAll1280/17-153-416-V01.jpg"
    # Cases
    "lianli-o11-dynamic.jpg"      = "https://c1.neweggimages.com/ProductImageCompressAll1280/11-112-595-V01.jpg"
    "fractal-torrent.jpg"         = "https://c1.neweggimages.com/ProductImageCompressAll1280/11-854-104-V01.jpg"
    "nzxt-h7-flow.jpg"            = "https://c1.neweggimages.com/ProductImageCompressAll1280/11-146-360-V01.jpg"
    "corsair-4000d.jpg"           = "https://c1.neweggimages.com/ProductImageCompressAll1280/11-139-117-V01.jpg"
    "bequiet-silent-base-802.jpg" = "https://c1.neweggimages.com/ProductImageCompressAll1280/11-801-020-V01.jpg"
    # Cooling
    "noctua-nh-d15.jpg"           = "https://c1.neweggimages.com/ProductImageCompressAll1280/35-228-058-V01.jpg"
    "corsair-h150i-elite.jpg"     = "https://c1.neweggimages.com/ProductImageCompressAll1280/35-139-253-V01.jpg"
    "bequiet-dark-rock-pro4.jpg"  = "https://c1.neweggimages.com/ProductImageCompressAll1280/35-801-014-V01.jpg"
    "arctic-liquid-freezer2.jpg"  = "https://c1.neweggimages.com/ProductImageCompressAll1280/35-817-040-V01.jpg"
    "thermalright-pa120se.jpg"    = "https://c1.neweggimages.com/ProductImageCompressAll1280/35-233-122-V01.jpg"
    # Accessories
    "logitech-gpro-superlight2.jpg" = "https://c1.neweggimages.com/ProductImageCompressAll1280/26-197-825-V01.jpg"
    "keychron-q3-max.jpg"           = "https://c1.neweggimages.com/ProductImageCompressAll1280/23-410-004-V01.jpg"
    "steelseries-qck-heavy.jpg"     = "https://c1.neweggimages.com/ProductImageCompressAll1280/26-130-097-V01.jpg"
    "elgato-stream-deck.jpg"        = "https://c1.neweggimages.com/ProductImageCompressAll1280/26-908-003-V01.jpg"
    "rode-nt-usb-mini.jpg"          = "https://c1.neweggimages.com/ProductImageCompressAll1280/181-005-004-V01.jpg"
    # Builds - reuse case images
    "build-starter.jpg"   = "https://c1.neweggimages.com/ProductImageCompressAll1280/11-139-117-V01.jpg"
    "build-mid.jpg"       = "https://c1.neweggimages.com/ProductImageCompressAll1280/11-112-595-V01.jpg"
    "build-highend.jpg"   = "https://c1.neweggimages.com/ProductImageCompressAll1280/11-146-360-V01.jpg"
    "build-creator.jpg"   = "https://c1.neweggimages.com/ProductImageCompressAll1280/11-854-104-V01.jpg"
    "build-budget.jpg"    = "https://c1.neweggimages.com/ProductImageCompressAll1280/11-801-020-V01.jpg"
}

$total = $images.Count
$done = 0

foreach ($file in $images.Keys) {
    $url = $images[$file]
    $path = Join-Path $dest $file
    try {
        Invoke-WebRequest -Uri $url -OutFile $path -WebSession $session -Headers $headers -UseBasicParsing
        $size = (Get-Item $path).Length
        if ($size -lt 1000) {
            Remove-Item $path
            Write-Host "  FAIL (too small): $file"
        } else {
            Write-Host "  ok: $file ($([math]::Round($size/1KB, 1)) KB)"
        }
    } catch {
        Write-Host "  FAIL: $file"
    }
    $done++
    Write-Progress -Activity "Downloading images" -Status "$done / $total" -PercentComplete (($done/$total)*100)
}

Write-Host "`nDone! Check above for any FAILs."
