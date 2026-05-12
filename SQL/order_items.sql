-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 11, 2026 at 10:04 PM
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
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` bigint NOT NULL,
  `order_id` bigint NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_category` varchar(255) NOT NULL,
  `unit_price` double NOT NULL,
  `quantity` int NOT NULL,
  `line_total` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_name`, `product_category`, `unit_price`, `quantity`, `line_total`) VALUES
(1, 1, 'AMD Ryzen 7 9700X', 'CPU', 22300, 3, 66900),
(2, 1, 'Intel Core i9-14900K', 'CPU', 38500, 4, 154000),
(3, 2, 'Intel Core i5-14600K', 'CPU', 18750, 1, 18750),
(4, 2, 'AMD Ryzen 5 7600X', 'CPU', 14200, 1, 14200),
(5, 2, 'Intel Core i9-14900K', 'CPU', 38500, 1, 38500),
(6, 3, 'AMD Ryzen 5 7600X', 'CPU', 14200, 1, 14200),
(7, 3, 'Intel Core i9-14900K', 'CPU', 38500, 1, 38500),
(8, 4, 'AMD RX 7800 XT', 'GPU', 34500, 2, 69000),
(9, 5, 'Intel Core i9-14900K', 'CPU', 38500, 3, 115500),
(10, 6, 'Intel Core i9-14900K', 'CPU', 38500, 2, 77000),
(11, 6, 'NVIDIA RTX 4070 Ti', 'GPU', 54999, 1, 54999),
(12, 6, 'AMD Ryzen 5 7600X', 'CPU', 14200, 2, 28400),
(13, 7, 'Intel Core i9-14900K', 'CPU', 38500, 1, 38500),
(14, 8, 'AMD Ryzen 5 7600X', 'CPU', 14200, 1, 14200),
(15, 9, 'AMD Ryzen 5 7600X', 'CPU', 14200, 2, 28400),
(16, 10, 'AMD Ryzen 9 9950X', 'CPU', 42999, 1, 42999);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_item_order` (`order_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `fk_item_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
