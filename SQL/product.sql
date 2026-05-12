-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 11, 2026 at 10:05 PM
-- Server version: 8.0.44
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `chroma`
--

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `id` bigint NOT NULL,
  `name` varchar(255) NOT NULL,
  `category` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `price` double NOT NULL,
  `quantity` int NOT NULL DEFAULT '0',
  `image_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`id`, `name`, `category`, `description`, `price`, `quantity`, `image_url`) VALUES
(1, 'AMD Ryzen 9 9950X', 'CPU', '16-core, 32-thread Zen 5 flagship. 4.3 GHz base / 5.7 GHz boost. 170W TDP. PCIe 5.0 ready. Best-in-class multi-threaded performance.', 42999, 8, '/images/products/ryzen9-9950x.jpg'),
(2, 'Intel Core i9-14900K', 'CPU', '24-core Raptor Lake Refresh (8P+16E). Up to 6.0 GHz boost. Unlocked multiplier. Excellent for gaming and content creation.', 38500, 12, '/images/products/i9-14900k.jpg'),
(3, 'AMD Ryzen 5 7600X', 'CPU', '6-core Zen 4 mid-range powerhouse. 5.3 GHz boost, excellent IPC gains. AM5 socket. Great value for 1080p and 1440p gaming builds.', 14200, 20, '/images/products/ryzen5-7600x.jpg'),
(4, 'Intel Core i5-14600K', 'CPU', '14-core hybrid (6P+8E). 5.3 GHz max turbo. Unlocked. The sweet-spot for mid-range gaming and streaming. Z790 compatible.', 18750, 15, '/images/products/i5-14600k.jpg'),
(5, 'AMD Ryzen 7 9700X', 'CPU', '8-core Zen 5 efficiency monster. 65W TDP, runs cool without a beast cooler. AM5 socket. 5.5 GHz boost. Low-power high-performance.', 22300, 3, '/images/products/ryzen7-9700x.jpg'),
(6, 'NVIDIA RTX 4090', 'GPU', '24 GB GDDR6X. Ada Lovelace flagship. Unmatched 4K and ray-tracing performance. DLSS 3 frame generation. The enthusiast standard.', 119999, 5, '/images/products/rtx4090.jpg'),
(7, 'AMD RX 7900 XTX', 'GPU', '24 GB GDDR6. RDNA 3 architecture. Excellent 4K rasterization at a lower price than competition. FSR 3 support. DisplayPort 2.1.', 74999, 7, '/images/products/rx7900xtx.jpg'),
(8, 'NVIDIA RTX 4070 Ti', 'GPU', '12 GB GDDR6X. Strong 1440p and capable 4K card. DLSS 3 frame generation. AV1 encode. Great price-to-performance for high-refresh gaming.', 54999, 10, '/images/products/rtx4070ti.jpg'),
(9, 'AMD RX 7800 XT', 'GPU', '16 GB GDDR6. Best-in-class 1440p value card. FSR 3 support. AV1 encode. Excellent for high-refresh 1440p gaming. Lower power draw.', 34500, 14, '/images/products/rx7800xt.jpg'),
(10, 'NVIDIA RTX 4060', 'GPU', '8 GB GDDR6. Efficient 1080p powerhouse. DLSS 3 and AV1 encode. Compact form factor. 115W TDP. Great for small builds.', 22999, 2, '/images/products/rtx4060.jpg'),
(11, 'Corsair Dominator 32GB DDR5-6000', 'RAM', '2×16 GB DDR5. 6000 MHz CL30. Premium DHX cooling fins. iCUE ARGB lighting. Intel XMP 3.0 and AMD EXPO support.', 12500, 18, '/images/products/corsair-dominator-ddr5.jpg'),
(12, 'G.Skill Trident Z5 32GB DDR5-7200', 'RAM', '2×16 GB DDR5. Extreme 7200 MHz XMP 3.0. Optimised for Intel Z790. Brushed aluminium heat spreader. Stunning aesthetics.', 16800, 9, '/images/products/gskill-trident-z5.jpg'),
(13, 'Kingston Fury Beast 16GB DDR4-3200', 'RAM', '2×8 GB DDR4. Plug-and-play XMP 2.0 at 3200 MHz. Low-profile design. Wide platform compatibility. Great budget kit.', 4200, 25, '/images/products/kingston-fury-ddr4.jpg'),
(14, 'Corsair Vengeance 64GB DDR5-5600', 'RAM', '4×16 GB DDR5 quad-channel. 5600 MHz. Designed for workstations and HEDT platforms. Low-profile heat spreader.', 24900, 6, '/images/products/corsair-vengeance-ddr5.jpg'),
(15, 'G.Skill Ripjaws V 32GB DDR4-3600', 'RAM', '2×16 GB DDR4-3600 CL16. Excellent AMD Ryzen compatibility. No RGB to keep costs low. Proven reliability for gaming rigs.', 7600, 11, '/images/products/gskill-ripjaws-ddr4.jpg'),
(16, 'ASUS ROG Maximus Z790 Hero', 'MBoard', 'Intel Z790. LGA1700. PCIe 5.0 x16 + dual M.2 PCIe 5.0. 20+1 power stages. Thunderbolt 4. Wi-Fi 6E. DDR5. For extreme builds.', 28999, 4, '/images/products/asus-rog-maximus-z790.jpg'),
(17, 'MSI MEG X670E ACE', 'MBoard', 'AMD X670E. AM5. Dual PCIe 5.0 M.2 slots. 22-phase SPS VRM. 2.5G LAN. Wi-Fi 6E. DDR5 only. Top-tier AM5 flagship board.', 26500, 6, '/images/products/msi-meg-x670e.jpg'),
(18, 'Gigabyte B650 AORUS Elite AX', 'MBoard', 'AMD B650. AM5. Solid mid-range for Ryzen 7000/9000. PCIe 5.0 M.2. Wi-Fi 6E. DDR5. 16-phase VRM. Great value flagship.', 13200, 13, '/images/products/gigabyte-b650-aorus.jpg'),
(19, 'ASRock Z790 Pro RS', 'MBoard', 'Intel Z790. LGA1700. 4× DDR5 slots. PCIe 5.0 M.2. 2.5G LAN. No Wi-Fi. Budget Z790 pick. Solid VRM for mid-tier builds.', 10800, 16, '/images/products/asrock-z790-pro.jpg'),
(20, 'ASUS TUF Gaming B760-Plus', 'MBoard', 'Intel B760. LGA1700. Reliable TUF build quality. DDR5. 2.5G LAN. PCIe 4.0 M.2 slots. Great mid-range Intel choice.', 9500, 20, '/images/products/asus-tuf-b760.jpg'),
(21, 'LG 27GP950-B 27\" 4K 160Hz', 'Monitor', 'IPS Nano Cell. 3840×2160. 160 Hz. 1ms GtG. HDMI 2.1 for console 4K120. G-Sync Compatible + FreeSync Premium Pro.', 29999, 7, '/images/products/lg-27gp950.jpg'),
(22, 'Samsung Odyssey G7 32\" 1440p', 'Monitor', 'VA curved 1000R. 2560×1440. 240 Hz. 1ms. Quantum Dot. DisplayHDR 600. G-Sync Compatible. Immersive gaming experience.', 22500, 5, '/images/products/samsung-odyssey-g7.jpg'),
(23, 'ASUS ROG Swift PG279QM 27\"', 'Monitor', 'IPS 1440p 240Hz. 1ms GtG. G-Sync Ultimate. 98% DCI-P3. HDR400. Top esports and creator monitor in one package.', 31999, 3, '/images/products/asus-rog-swift-pg279qm.jpg'),
(24, 'AOC 24G2SP 24\" 1080p 165Hz', 'Monitor', 'IPS 1920×1080. 165 Hz. 1ms MPRT. FreeSync Premium. Height adjustable stand. Best budget gaming monitor.', 7200, 30, '/images/products/aoc-24g2sp.jpg'),
(25, 'LG 34WP65G-B 34\" UltraWide', 'Monitor', '21:9 IPS 2560×1080. 75 Hz. sRGB 99%. USB-C 65W power delivery. Excellent productivity and multimedia ultrawide.', 14800, 9, '/images/products/lg-34wp65g.jpg'),
(26, 'Corsair HX1000i 1000W Platinum', 'PWsupply', 'Fully modular. 80 Plus Platinum. Zero RPM fan mode. iCUE digital monitoring. 10-year warranty. Ultra-stable rails.', 17500, 8, '/images/products/corsair-hx1000i.jpg'),
(27, 'EVGA SuperNOVA 850 G6 850W', 'PWsupply', 'Fully modular. 80 Plus Gold. Compact 140mm depth. Eco fan mode. Japanese capacitors. 10-year warranty.', 12200, 12, '/images/products/evga-supernova-850.jpg'),
(28, 'Seasonic Focus GX-750 750W', 'PWsupply', 'Fully modular. 80 Plus Gold. Hybrid fan control (fanless under light load). 10-year warranty. Excellent regulation.', 10500, 15, '/images/products/seasonic-focus-gx750.jpg'),
(29, 'be quiet! Pure Power 12 M 650W', 'PWsupply', 'Semi-modular. 80 Plus Gold. Silent 120mm fan. ATX 3.0 spec. PCIe 5.0 connector included. Great everyday value.', 7800, 20, '/images/products/bequiet-pure-power-12.jpg'),
(30, 'Thermaltake Toughpower GF3 1200W', 'PWsupply', 'Fully modular. 80 Plus Gold. ATX 3.0. Native PCIe 5.0 16-pin connector. Built for RTX 40 and RX 7000 series.', 19999, 5, '/images/products/thermaltake-gf3-1200w.jpg'),
(31, 'Lian Li O11 Dynamic EVO', 'Case', 'Mid-tower dual-chamber. Supports up to 10 fans and 420mm radiator. Tempered glass side + top. Tool-free PCIe riser. E-ATX support.', 14500, 10, '/images/products/lianli-o11-dynamic.jpg'),
(32, 'Fractal Design Torrent', 'Case', 'Open-grille front panel for maximum airflow. Two 180mm front fans included. ATX/E-ATX. Excellent cable routing. Vertical GPU mount.', 13200, 8, '/images/products/fractal-torrent.jpg'),
(33, 'NZXT H7 Flow', 'Case', 'Perforated mesh front. Three fan locations. Vertical GPU bracket option. Two-tone interior finish. ATX mid-tower. Clean aesthetics.', 11800, 12, '/images/products/nzxt-h7-flow.jpg'),
(34, 'Corsair 4000D Airflow', 'Case', 'Mesh front panel. Two 120mm fans included. Cable management bar. ATX. Best-in-class value for airflow-focused mid-tower builds.', 8900, 18, '/images/products/corsair-4000d.jpg'),
(35, 'be quiet! Silent Base 802', 'Case', 'Sound-dampened panels on all sides. Three Pure Wings 3 fans included. E-ATX support. Modular layout. Near-silent operation.', 16800, 6, '/images/products/bequiet-silent-base-802.jpg'),
(36, 'Noctua NH-D15', 'Cooling', 'Dual-tower air cooler. Two NF-A15 140mm fans. 165mm height. Universal mount for AM5 and LGA1700. Near-silent flagship.', 8500, 14, '/images/products/noctua-nh-d15.jpg'),
(37, 'Corsair iCUE H150i Elite 360mm', 'Cooling', 'AIO liquid cooler. 360mm radiator. Three 120mm ARGB fans. iCUE software control. AM5 + LGA1700. Strong performance.', 15999, 9, '/images/products/corsair-h150i-elite.jpg'),
(38, 'be quiet! Dark Rock Pro 4', 'Cooling', 'Dual-tower air. Two SilentWings 3 fans. 250W TDP rating. Rubber-dampened mounts. 135mm fan between towers.', 7200, 11, '/images/products/bequiet-dark-rock-pro4.jpg'),
(39, 'ARCTIC Liquid Freezer II 240', 'Cooling', '240mm AIO. Integrated VRM fan. Exceptional price-to-performance ratio. P12 PWM fans. AM5 bracket included.', 9800, 16, '/images/products/arctic-liquid-freezer2.jpg'),
(40, 'Thermalright Peerless Assassin 120 SE', 'Cooling', 'Dual-tower air cooler. Two TL-C12 fans. Six heat pipes. Budget alternative to Noctua with near-identical performance.', 4500, 22, '/images/products/thermalright-pa120se.jpg'),
(41, 'Logitech G Pro X Superlight 2', 'Accessories', '60g wireless gaming mouse. HERO 25K optical sensor. 95-hour battery. PTFE feet. USB-C charging. Zero compromises.', 8999, 15, '/images/products/logitech-gpro-superlight2.jpg'),
(42, 'Keychron Q3 Max TKL', 'Accessories', 'Gasket-mount TKL mechanical keyboard. QMK/VIA programmable. Wireless + wired. Hot-swap sockets. Solid aluminium body.', 12500, 8, '/images/products/keychron-q3-max.jpg'),
(43, 'SteelSeries QcK Heavy XL', 'Accessories', 'Extra-large cloth mousepad. 900×300×6mm thick. Micro-woven surface for consistent glide. Non-slip rubber base.', 1800, 40, '/images/products/steelseries-qck-heavy.jpg'),
(44, 'Elgato Stream Deck MK.2', 'Accessories', '15 customisable LCD keys. Drag-and-drop action setup. Integrates with OBS, Spotify, Premiere Pro, browsers and more.', 11200, 10, '/images/products/elgato-stream-deck.jpg'),
(45, 'Rode NT-USB Mini Microphone', 'Accessories', 'Studio-quality USB condenser. Built-in headphone monitoring. Swing-arm mount included. Plug-and-play, no drivers needed.', 7600, 13, '/images/products/rode-nt-usb-mini.jpg'),
(46, 'Chroma Starter Build', 'FBuilds', 'Ryzen 5 7600X · RX 7800 XT · 16GB DDR5-5600 · 500GB NVMe Gen4. Assembled and tested. Solid 1080p and entry 1440p gaming.', 64999, 5, '/images/products/build-starter.jpg'),
(47, 'Chroma Mid Build', 'FBuilds', 'Core i5-14600K · RTX 4070 Ti · 32GB DDR5-6000 · 1TB NVMe Gen4. Assembled and tested. Excellent 1440p high-refresh system.', 114999, 4, '/images/products/build-mid.jpg'),
(48, 'Chroma High-End Build', 'FBuilds', 'Ryzen 9 9950X · RTX 4090 · 64GB DDR5-6000 · 2TB NVMe Gen5. Assembled and tested. Uncompromising 4K performance beast.', 224999, 2, '/images/products/build-highend.jpg'),
(49, 'Chroma Creator Build', 'FBuilds', 'Core i9-14900K · RTX 4080 Super · 64GB DDR5 · 4TB RAID NVMe. Assembled and tested. Video editing, 3D render and streaming.', 189999, 3, '/images/products/build-creator.jpg'),
(50, 'Chroma Budget Build', 'FBuilds', 'Ryzen 5 7600 · RX 7600 · 16GB DDR5 · 500GB NVMe. Assembled and tested. Best value entry gaming PC — under 50K EGP.', 47999, 7, '/images/products/build-budget.jpg'),
(51, 'NVIDIA RTX 3070', 'GPU', '12 GB GDDR6X. Strong 1440p and capable 4K card. DLSS 3 frame generation. AV1 encode.', 34000, 4, '/images/products/rtx3070.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
