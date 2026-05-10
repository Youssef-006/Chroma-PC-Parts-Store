# Run this in PowerShell from your project root (where pom.xml is)
# Example: cd C:\Users\Youssef\OneDrive\Desktop\chroma
#          .\download_images.ps1

$dest = "src\main\resources\static\images\products"
New-Item -ItemType Directory -Force -Path $dest | Out-Null

$images = @{
    # CPUs
    "ryzen9-9950x.jpg"     = "https://www.amd.com/content/dam/amd/en/images/products/processors/ryzen/9000-series/2974003-amd-ryzen-9-9950x-pib-left-facing-1260x709.png"
    "i9-14900k.jpg"        = "https://www.bhphotovideo.com/images/images2500x2500/intel_bx8071514900k_core_i9_14900k_desktop_processor_1732278.jpg"
    "ryzen5-7600x.jpg"     = "https://www.amd.com/content/dam/amd/en/images/products/processors/ryzen/7000-series/2738791-amd-ryzen-5-7600x-pib-left-facing-1260x709.png"
    "i5-14600k.jpg"        = "https://www.bhphotovideo.com/images/images2500x2500/intel_bx8071514600k_core_i5_14600k_desktop_processor_1732273.jpg"
    "ryzen7-9700x.jpg"     = "https://www.amd.com/content/dam/amd/en/images/products/processors/ryzen/9000-series/2974002-amd-ryzen-7-9700x-pib-left-facing-1260x709.png"
    # GPUs
    "rtx4090.jpg"          = "https://www.bhphotovideo.com/images/images2500x2500/nvidia_900_1g133_2530_000_geforce_rtx_4090_founders_edition_1732671.jpg"
    "rx7900xtx.jpg"        = "https://www.amd.com/content/dam/amd/en/images/products/graphics/radeon/7000-series/2736393-amd-radeon-rx-7900-xtx-pib-left-facing-1260x709.png"
    "rtx4070ti.jpg"        = "https://www.bhphotovideo.com/images/images2500x2500/nvidia_900_1g141_2515_000_rtx_4070_ti_founders_edition_1738984.jpg"
    "rx7800xt.jpg"         = "https://www.amd.com/content/dam/amd/en/images/products/graphics/radeon/7000-series/2843063-amd-radeon-rx-7800-xt-pib-left-facing-1260x709.png"
    "rtx4060.jpg"          = "https://www.bhphotovideo.com/images/images2500x2500/nvidia_900_1g172_2544_000_rtx_4060_founders_edition_1749758.jpg"
    "rtx3070.jpg"          = "https://www.bhphotovideo.com/images/images2500x2500/nvidia_900_1g142_2540_000_rtx_3070_founders_edition_1613003.jpg"
    # RAM
    "corsair-dominator-ddr5.jpg"  = "https://www.bhphotovideo.com/images/images2500x2500/corsair_cmq32gx5m2b6000c30_dominator_platinum_rgb_32gb_1747699.jpg"
    "gskill-trident-z5.jpg"       = "https://www.bhphotovideo.com/images/images2500x2500/g_skill_f5_7200j3445g16gx2_tz5rk_trident_z5_rgb_series_32gb_1750098.jpg"
    "kingston-fury-ddr4.jpg"       = "https://www.bhphotovideo.com/images/images2500x2500/kingston_kf432c16bbk2_16_fury_beast_16gb_ddr4_1626439.jpg"
    "corsair-vengeance-ddr5.jpg"   = "https://www.bhphotovideo.com/images/images2500x2500/corsair_cmk64gx5m4b5600c40_vengeance_64gb_ddr5_5600_1747093.jpg"
    "gskill-ripjaws-ddr4.jpg"      = "https://www.bhphotovideo.com/images/images2500x2500/g_skill_f4_3600c16d_32gvk_ripjaws_v_series_32gb_1627568.jpg"
    # Motherboards
    "asus-rog-maximus-z790.jpg"    = "https://www.bhphotovideo.com/images/images2500x2500/asus_rog_maximus_z790_hero_rog_maximus_z790_hero_1752497.jpg"
    "msi-meg-x670e.jpg"            = "https://www.bhphotovideo.com/images/images2500x2500/msi_meg_x670e_ace_meg_x670e_ace_motherboard_1738044.jpg"
    "gigabyte-b650-aorus.jpg"      = "https://www.bhphotovideo.com/images/images2500x2500/gigabyte_b650_aorus_elite_ax_b650_aorus_elite_ax_atx_1738051.jpg"
    "asrock-z790-pro.jpg"          = "https://www.bhphotovideo.com/images/images2500x2500/asrock_z790_pro_rs_z790_pro_rs_atx_motherboard_1738019.jpg"
    "asus-tuf-b760.jpg"            = "https://www.bhphotovideo.com/images/images2500x2500/asus_tuf_gaming_b760_plus_wifi_tuf_gaming_b760_plus_wifi_1738058.jpg"
    # Monitors
    "lg-27gp950.jpg"               = "https://www.bhphotovideo.com/images/images2500x2500/lg_27gp950_b_27_ultragear_4k_nano_1613376.jpg"
    "samsung-odyssey-g7.jpg"       = "https://www.bhphotovideo.com/images/images2500x2500/samsung_lc32g75tqsnxza_32_odyssey_g7_gaming_1613383.jpg"
    "asus-rog-swift-pg279qm.jpg"   = "https://www.bhphotovideo.com/images/images2500x2500/asus_pg279qm_rog_swift_pg279qm_27_1626428.jpg"
    "aoc-24g2sp.jpg"               = "https://www.bhphotovideo.com/images/images2500x2500/aoc_24g2sp_bk_24g2sp_bk_24_frameless_gaming_1738099.jpg"
    "lg-34wp65g.jpg"               = "https://www.bhphotovideo.com/images/images2500x2500/lg_34wp65g_b_34_ultrawide_wfhd_ips_1613378.jpg"
    # PSUs
    "corsair-hx1000i.jpg"          = "https://www.bhphotovideo.com/images/images2500x2500/corsair_cp_9020214_na_hx1000i_1000w_80_platinum_1738075.jpg"
    "evga-supernova-850.jpg"       = "https://www.bhphotovideo.com/images/images2500x2500/evga_220_g6_0850_x1_supernova_850_g6_850w_1613367.jpg"
    "seasonic-focus-gx750.jpg"     = "https://www.bhphotovideo.com/images/images2500x2500/seasonic_focus_gx_750_focus_gx_750_750w_80_1613391.jpg"
    "bequiet-pure-power-12.jpg"    = "https://www.bhphotovideo.com/images/images2500x2500/be_quiet_bn342_pure_power_12_m_650w_1738063.jpg"
    "thermaltake-gf3-1200w.jpg"    = "https://www.bhphotovideo.com/images/images2500x2500/thermaltake_ps_tpd_1200fnfagu_3_toughpower_gf3_1200w_80_1738061.jpg"
    # Cases
    "lianli-o11-dynamic.jpg"       = "https://www.bhphotovideo.com/images/images2500x2500/lian_li_pc_o11dex_3_o11_dynamic_evo_tempered_1738045.jpg"
    "fractal-torrent.jpg"          = "https://www.bhphotovideo.com/images/images2500x2500/fractal_design_fd_c_tor1a_02_torrent_atx_mid_tower_case_1738048.jpg"
    "nzxt-h7-flow.jpg"             = "https://www.bhphotovideo.com/images/images2500x2500/nzxt_cc_h71fb_01_h7_flow_mid_tower_case_1738054.jpg"
    "corsair-4000d.jpg"            = "https://www.bhphotovideo.com/images/images2500x2500/corsair_cc_9011198_ww_4000d_airflow_tempered_glass_1613356.jpg"
    "bequiet-silent-base-802.jpg"  = "https://www.bhphotovideo.com/images/images2500x2500/be_quiet_bgw39_silent_base_802_black_mid_1738067.jpg"
    # Cooling
    "noctua-nh-d15.jpg"            = "https://www.bhphotovideo.com/images/images2500x2500/noctua_nh_d15_nh_d15_cpu_cooler_1037718.jpg"
    "corsair-h150i-elite.jpg"      = "https://www.bhphotovideo.com/images/images2500x2500/corsair_cw_9060064_ww_icue_h150i_elite_lcd_1738072.jpg"
    "bequiet-dark-rock-pro4.jpg"   = "https://www.bhphotovideo.com/images/images2500x2500/be_quiet_bk022_dark_rock_pro_4_cpu_1613350.jpg"
    "arctic-liquid-freezer2.jpg"   = "https://www.bhphotovideo.com/images/images2500x2500/arctic_acfre00093a_liquid_freezer_ii_240_multi_1626421.jpg"
    "thermalright-pa120se.jpg"     = "https://www.bhphotovideo.com/images/images2500x2500/thermalright_pa120_se_d_argb_peerless_assassin_120_se_1738081.jpg"
    # Accessories
    "logitech-gpro-superlight2.jpg" = "https://www.bhphotovideo.com/images/images2500x2500/logitech_910_006549_pro_x_superlight_2_1738089.jpg"
    "keychron-q3-max.jpg"           = "https://www.bhphotovideo.com/images/images2500x2500/keychron_q3_max_qmk_via_wireless_1738091.jpg"
    "steelseries-qck-heavy.jpg"     = "https://www.bhphotovideo.com/images/images2500x2500/steelseries_63008_qck_heavy_xl_gaming_mouse_1613396.jpg"
    "elgato-stream-deck.jpg"        = "https://www.bhphotovideo.com/images/images2500x2500/elgato_10gaa9901_stream_deck_mk_2_1626434.jpg"
    "rode-nt-usb-mini.jpg"          = "https://www.bhphotovideo.com/images/images2500x2500/rode_nt_usb_mini_nt_usb_mini_microphone_1613389.jpg"
    # Featured Builds (use a stylish PC build photo)
    "build-starter.jpg"   = "https://www.bhphotovideo.com/images/images2500x2500/corsair_cc_9011198_ww_4000d_airflow_tempered_glass_1613356.jpg"
    "build-mid.jpg"       = "https://www.bhphotovideo.com/images/images2500x2500/lian_li_pc_o11dex_3_o11_dynamic_evo_tempered_1738045.jpg"
    "build-highend.jpg"   = "https://www.bhphotovideo.com/images/images2500x2500/nzxt_cc_h71fb_01_h7_flow_mid_tower_case_1738054.jpg"
    "build-creator.jpg"   = "https://www.bhphotovideo.com/images/images2500x2500/fractal_design_fd_c_tor1a_02_torrent_atx_mid_tower_case_1738048.jpg"
    "build-budget.jpg"    = "https://www.bhphotovideo.com/images/images2500x2500/corsair_cc_9011198_ww_4000d_airflow_tempered_glass_1613356.jpg"
}

$total = $images.Count
$done = 0
foreach ($file in $images.Keys) {
    $url = $images[$file]
    $path = Join-Path $dest $file
    if (Test-Path $path) {
        Write-Host "  skip (exists): $file"
    } else {
        try {
            Invoke-WebRequest -Uri $url -OutFile $path -UseBasicParsing
            Write-Host "  ok: $file"
        } catch {
            Write-Host "  FAIL: $file - $($_.Exception.Message)"
        }
    }
    $done++
    Write-Progress -Activity "Downloading images" -Status "$done / $total" -PercentComplete (($done / $total) * 100)
}

Write-Host ""
Write-Host "Done! Images saved to: $dest"
