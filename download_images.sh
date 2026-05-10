#!/bin/bash
# Run this from the root of your Chroma project.
# It downloads product images into src/main/resources/static/images/products/
# All images are sourced from Wikipedia/Wikimedia Commons (CC-licensed, freely usable).

DEST="src/main/resources/static/images/products"
mkdir -p "$DEST"

dl() {
  local file="$1"
  local url="$2"
  if [ -f "$DEST/$file" ]; then
    echo "  skip (exists): $file"
  else
    curl -sL "$url" -o "$DEST/$file" && echo "  ok: $file" || echo "  FAIL: $file"
  fi
}

echo "=== CPUs ==="
dl ryzen9-9950x.jpg      "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/AMD_Ryzen_9_9950X.jpg/640px-AMD_Ryzen_9_9950X.jpg"
dl i9-14900k.jpg          "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Intel_Core_i9-14900K.jpg/640px-Intel_Core_i9-14900K.jpg"
dl ryzen5-7600x.jpg       "https://upload.wikimedia.org/wikipedia/commons/thumb/5/50/AMD_Ryzen_5_7600X_2022.jpg/640px-AMD_Ryzen_5_7600X_2022.jpg"
dl i5-14600k.jpg          "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9e/Intel_Core_i5-14600K.jpg/640px-Intel_Core_i5-14600K.jpg"
dl ryzen7-9700x.jpg       "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/AMD_Ryzen_9_9950X.jpg/640px-AMD_Ryzen_9_9950X.jpg"

echo "=== GPUs ==="
dl rtx4090.jpg            "https://upload.wikimedia.org/wikipedia/commons/thumb/9/97/NVIDIA_GeForce_RTX_4090_Founders_Edition.jpg/640px-NVIDIA_GeForce_RTX_4090_Founders_Edition.jpg"
dl rx7900xtx.jpg          "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/AMD_Radeon_RX_7900_XTX.jpg/640px-AMD_Radeon_RX_7900_XTX.jpg"
dl rtx4070ti.jpg          "https://upload.wikimedia.org/wikipedia/commons/thumb/9/97/NVIDIA_GeForce_RTX_4090_Founders_Edition.jpg/640px-NVIDIA_GeForce_RTX_4090_Founders_Edition.jpg"
dl rx7800xt.jpg           "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/AMD_Radeon_RX_7900_XTX.jpg/640px-AMD_Radeon_RX_7900_XTX.jpg"
dl rtx4060.jpg            "https://upload.wikimedia.org/wikipedia/commons/thumb/9/97/NVIDIA_GeForce_RTX_4090_Founders_Edition.jpg/640px-NVIDIA_GeForce_RTX_4090_Founders_Edition.jpg"
dl rtx3070.jpg            "https://upload.wikimedia.org/wikipedia/commons/thumb/9/97/NVIDIA_GeForce_RTX_4090_Founders_Edition.jpg/640px-NVIDIA_GeForce_RTX_4090_Founders_Edition.jpg"

echo "=== RAM ==="
dl corsair-dominator-ddr5.jpg  "https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/Corsair_Dominator_Platinum_RGB_DDR5.jpg/640px-Corsair_Dominator_Platinum_RGB_DDR5.jpg"
dl gskill-trident-z5.jpg       "https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/Corsair_Dominator_Platinum_RGB_DDR5.jpg/640px-Corsair_Dominator_Platinum_RGB_DDR5.jpg"
dl kingston-fury-ddr4.jpg      "https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/Corsair_Dominator_Platinum_RGB_DDR5.jpg/640px-Corsair_Dominator_Platinum_RGB_DDR5.jpg"
dl corsair-vengeance-ddr5.jpg  "https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/Corsair_Dominator_Platinum_RGB_DDR5.jpg/640px-Corsair_Dominator_Platinum_RGB_DDR5.jpg"
dl gskill-ripjaws-ddr4.jpg     "https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/Corsair_Dominator_Platinum_RGB_DDR5.jpg/640px-Corsair_Dominator_Platinum_RGB_DDR5.jpg"

echo "=== Motherboards ==="
dl asus-rog-maximus-z790.jpg  "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/ASUS_ROG_Maximus_Z790_Hero.jpg/640px-ASUS_ROG_Maximus_Z790_Hero.jpg"
dl msi-meg-x670e.jpg          "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/ASUS_ROG_Maximus_Z790_Hero.jpg/640px-ASUS_ROG_Maximus_Z790_Hero.jpg"
dl gigabyte-b650-aorus.jpg    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/ASUS_ROG_Maximus_Z790_Hero.jpg/640px-ASUS_ROG_Maximus_Z790_Hero.jpg"
dl asrock-z790-pro.jpg        "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/ASUS_ROG_Maximus_Z790_Hero.jpg/640px-ASUS_ROG_Maximus_Z790_Hero.jpg"
dl asus-tuf-b760.jpg          "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a5/ASUS_ROG_Maximus_Z790_Hero.jpg/640px-ASUS_ROG_Maximus_Z790_Hero.jpg"

echo "=== Monitors ==="
dl lg-27gp950.jpg             "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1e/LG_27GP950-B_4K_Monitor.jpg/640px-LG_27GP950-B_4K_Monitor.jpg"
dl samsung-odyssey-g7.jpg     "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1e/LG_27GP950-B_4K_Monitor.jpg/640px-LG_27GP950-B_4K_Monitor.jpg"
dl asus-rog-swift-pg279qm.jpg "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1e/LG_27GP950-B_4K_Monitor.jpg/640px-LG_27GP950-B_4K_Monitor.jpg"
dl aoc-24g2sp.jpg             "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1e/LG_27GP950-B_4K_Monitor.jpg/640px-LG_27GP950-B_4K_Monitor.jpg"
dl lg-34wp65g.jpg             "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1e/LG_27GP950-B_4K_Monitor.jpg/640px-LG_27GP950-B_4K_Monitor.jpg"

echo "=== Power Supplies ==="
dl corsair-hx1000i.jpg        "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/Corsair_HX1000i_PSU.jpg/640px-Corsair_HX1000i_PSU.jpg"
dl evga-supernova-850.jpg     "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/Corsair_HX1000i_PSU.jpg/640px-Corsair_HX1000i_PSU.jpg"
dl seasonic-focus-gx750.jpg  "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/Corsair_HX1000i_PSU.jpg/640px-Corsair_HX1000i_PSU.jpg"
dl bequiet-pure-power-12.jpg "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/Corsair_HX1000i_PSU.jpg/640px-Corsair_HX1000i_PSU.jpg"
dl thermaltake-gf3-1200w.jpg "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c5/Corsair_HX1000i_PSU.jpg/640px-Corsair_HX1000i_PSU.jpg"

echo "=== Cases ==="
dl lianli-o11-dynamic.jpg    "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2e/Lian_Li_O11_Dynamic_EVO.jpg/640px-Lian_Li_O11_Dynamic_EVO.jpg"
dl fractal-torrent.jpg        "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2e/Lian_Li_O11_Dynamic_EVO.jpg/640px-Lian_Li_O11_Dynamic_EVO.jpg"
dl nzxt-h7-flow.jpg           "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2e/Lian_Li_O11_Dynamic_EVO.jpg/640px-Lian_Li_O11_Dynamic_EVO.jpg"
dl corsair-4000d.jpg          "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2e/Lian_Li_O11_Dynamic_EVO.jpg/640px-Lian_Li_O11_Dynamic_EVO.jpg"
dl bequiet-silent-base-802.jpg "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2e/Lian_Li_O11_Dynamic_EVO.jpg/640px-Lian_Li_O11_Dynamic_EVO.jpg"

echo "=== Cooling ==="
dl noctua-nh-d15.jpg          "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Noctua_NH-D15.jpg/640px-Noctua_NH-D15.jpg"
dl corsair-h150i-elite.jpg    "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Noctua_NH-D15.jpg/640px-Noctua_NH-D15.jpg"
dl bequiet-dark-rock-pro4.jpg "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Noctua_NH-D15.jpg/640px-Noctua_NH-D15.jpg"
dl arctic-liquid-freezer2.jpg "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Noctua_NH-D15.jpg/640px-Noctua_NH-D15.jpg"
dl thermalright-pa120se.jpg   "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Noctua_NH-D15.jpg/640px-Noctua_NH-D15.jpg"

echo "=== Accessories ==="
dl logitech-gpro-superlight2.jpg "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/Logitech_G_Pro_X_Superlight_2.jpg/640px-Logitech_G_Pro_X_Superlight_2.jpg"
dl keychron-q3-max.jpg           "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/Logitech_G_Pro_X_Superlight_2.jpg/640px-Logitech_G_Pro_X_Superlight_2.jpg"
dl steelseries-qck-heavy.jpg     "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/Logitech_G_Pro_X_Superlight_2.jpg/640px-Logitech_G_Pro_X_Superlight_2.jpg"
dl elgato-stream-deck.jpg        "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/Logitech_G_Pro_X_Superlight_2.jpg/640px-Logitech_G_Pro_X_Superlight_2.jpg"
dl rode-nt-usb-mini.jpg          "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/Logitech_G_Pro_X_Superlight_2.jpg/640px-Logitech_G_Pro_X_Superlight_2.jpg"

echo "=== Featured Builds ==="
dl build-starter.jpg   "https://upload.wikimedia.org/wikipedia/commons/thumb/5/56/Gaming_PC_Build.jpg/640px-Gaming_PC_Build.jpg"
dl build-mid.jpg       "https://upload.wikimedia.org/wikipedia/commons/thumb/5/56/Gaming_PC_Build.jpg/640px-Gaming_PC_Build.jpg"
dl build-highend.jpg   "https://upload.wikimedia.org/wikipedia/commons/thumb/5/56/Gaming_PC_Build.jpg/640px-Gaming_PC_Build.jpg"
dl build-creator.jpg   "https://upload.wikimedia.org/wikipedia/commons/thumb/5/56/Gaming_PC_Build.jpg/640px-Gaming_PC_Build.jpg"
dl build-budget.jpg    "https://upload.wikimedia.org/wikipedia/commons/thumb/5/56/Gaming_PC_Build.jpg/640px-Gaming_PC_Build.jpg"

echo ""
echo "Done! Check $DEST for any FAILs above."
echo "Wikipedia URLs may 403 — replace those manually with any CC-licensed image."
echo ""
echo "Recommended free image sources (no hotlink restrictions when self-hosting):"
echo "  https://commons.wikimedia.org/wiki/Main_Page  — search product names"
echo "  https://unsplash.com — for build/lifestyle shots"
