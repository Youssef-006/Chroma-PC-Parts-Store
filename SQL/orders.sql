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
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `placed_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `address` varchar(255) NOT NULL,
  `city` varchar(255) DEFAULT NULL,
  `governorate` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `leave_at_door` tinyint(1) NOT NULL DEFAULT '0',
  `total` double NOT NULL DEFAULT '0',
  `status` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `placed_at`, `address`, `city`, `governorate`, `phone`, `payment_method`, `leave_at_door`, `total`, `status`) VALUES
(1, 4, '2026-05-09 20:08:49', 'Sheraton, a', 'Cairo', 'a', '+201099745131', 'cash', 1, 220900, 'DELIVERED'),
(2, 4, '2026-05-09 20:21:21', 'Sheraton, a', 'Cairo', 'a', '+201099745131', 'card', 0, 71450, 'SHIPPED'),
(3, 4, '2026-05-09 20:33:33', 'a, a', 'a', 'a', 'a', 'card', 1, 52700, 'DELIVERED'),
(4, 4, '2026-05-09 20:41:31', 'Sheraton, 72', 'Nasr City', 'Cairo', '+201099745131', 'card', 1, 69000, 'PENDING'),
(5, 4, '2026-05-09 22:14:57', 'Sheraton, 72', 'Cairo', 'Cairo', '+201099745131', 'card', 1, 115500, 'PENDING'),
(6, 7, '2026-05-11 22:32:21', 'Sheraton, City Stars - 72', 'Nasr City', 'Cairo', '+201099745131', 'cash', 1, 160399, 'PENDING'),
(7, 4, '2026-05-11 22:34:10', 'Sheraton, 72', 'Nasr City', 'Cairo', '+201099745131', 'card', 0, 38500, 'PENDING'),
(8, 4, '2026-05-11 22:39:17', 'Sheraton, a', 'Cairo', 'a', '+201099745131', 'card', 1, 14200, 'PENDING'),
(9, 4, '2026-05-11 22:43:59', 'Sheraton, 72', 'Nasr City', 'Cairo', '+201099745131', 'card', 1, 28400, 'PENDING'),
(10, 4, '2026-05-11 22:46:33', 'Sheraton, a', 'Cairo', 'a', '+201099745131', 'card', 1, 42999, 'PENDING');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_order_user` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_order_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
