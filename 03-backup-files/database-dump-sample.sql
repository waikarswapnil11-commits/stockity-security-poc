-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
-- Host: localhost    Database: stockity_prod

-- Sample of exposed database backup

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` text,
  `city` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `postal_code` varchar(20) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_login` datetime DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `role` enum('user','admin','moderator') DEFAULT 'user',
  `email_verified` tinyint(1) DEFAULT '0',
  `verification_token` varchar(255) DEFAULT NULL,
  `reset_token` varchar(255) DEFAULT NULL,
  `reset_expires` datetime DEFAULT NULL,
  `stripe_customer_id` varchar(255) DEFAULT NULL,
  `payment_methods` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `idx_created_at` (`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=15234 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` VALUES 
(1001,'john.doe@example.com','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','John','Doe','+1-555-123-4567','123 Main St','New York','USA','10001','2024-01-15 10:30:00','2024-03-07 14:22:33','2024-03-07 09:15:22',1,'user',1,NULL,NULL,NULL,'cus_1234567890',NULL),
(1002,'jane.smith@example.com','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','Jane','Smith','+44-20-1234-5678','456 Oxford St','London','UK','W1D 1BS','2024-01-20 14:45:00','2024-03-06 11:30:45','2024-03-06 11:30:45',1,'admin',1,NULL,NULL,NULL,'cus_0987654321',NULL),
(15000,'admin@stockity.com','$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi','Admin','User','+1-555-000-0000','789 Admin Blvd','San Francisco','USA','94105','2023-01-01 00:00:00','2024-03-08 08:00:00','2024-03-08 08:00:00',1,'admin',1,NULL,NULL,NULL,'cus_admin_001',NULL);

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
CREATE TABLE `transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `currency` varchar(3) DEFAULT 'USD',
  `status` enum('pending','completed','failed','refunded') DEFAULT 'pending',
  `payment_method` varchar(50) DEFAULT NULL,
  `stripe_payment_intent` varchar(255) DEFAULT NULL,
  `paypal_transaction_id` varchar(255) DEFAULT NULL,
  `description` text,
  `metadata` json DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `created_at` (`created_at`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52341 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `transactions` (sample 10 rows)
--

INSERT INTO `transactions` VALUES 
(50001,1001,299.99,'USD','completed','stripe','pi_3OqXpY2eZvKYlo2C1xY5n8f9',NULL,'Premium Subscription - Annual',NULL,'2024-03-01 09:15:22','2024-03-01 09:15:22'),
(50002,1002,99.99,'GBP','completed','paypal',NULL,'PAYID-MARCH2024XYZ123','Basic Subscription - Monthly',NULL,'2024-03-02 14:30:00','2024-03-02 14:30:00'),
(50003,1001,49.99,'USD','completed','stripe','pi_3OqYqZ2eZvKYlo2C2yZ6n9g0',NULL,'Add-on Feature',NULL,'2024-03-03 11:45:00','2024-03-03 11:45:00'),
(50004,15000,0.00,'USD','completed','system',NULL,NULL,'Admin adjustment',NULL,'2024-03-04 10:00:00','2024-03-04 10:00:00');

-- ... (50,000+ more rows)

-- Dump completed on 2024-03-08 10:00:00
