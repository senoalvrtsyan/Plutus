CREATE DATABASE  IF NOT EXISTS `plutus` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `plutus`;
-- MySQL dump 10.13  Distrib 5.7.12, for osx10.9 (x86_64)
--
-- Host: localhost    Database: plutus
-- ------------------------------------------------------
-- Server version	5.7.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accounts` (
  `idaccounts` varchar(128) NOT NULL,
  `iduser` int(10) unsigned NOT NULL,
  `type` int(10) unsigned DEFAULT NULL,
  `balance` decimal(19,4) DEFAULT NULL,
  `limit` decimal(19,4) DEFAULT NULL,
  PRIMARY KEY (`idaccounts`),
  UNIQUE KEY `idaccounts_UNIQUE` (`idaccounts`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES ('100100101',2,1,224399.0000,NULL),('100100102',3,1,800800182990.0000,0.0000),('100100103',4,1,106561.0000,0.0000),('100100104',15,1,0.0000,0.0000),('100100105',16,1,0.0000,0.0000),('100100106',17,1,0.0000,0.0000),('100100107',18,1,0.0000,0.0000),('100100108',20,1,0.0000,0.0000),('100100109',22,1,0.0000,0.0000),('100100110',23,1,0.0000,0.0000),('100100111',24,1,0.0000,0.0000),('100100112',25,1,0.0000,0.0000),('100100113',26,1,0.0000,0.0000),('100100114',27,1,0.0000,0.0000),('100100115',28,1,0.0000,0.0000),('100100116',29,1,0.0000,0.0000),('100100117',30,1,0.0000,0.0000),('100100118',31,1,0.0000,0.0000),('200100101',2,2,256789.0000,400000.0000),('200100102',3,2,320001.0000,500000.0000),('200100103',4,2,436447.0000,600000.0000),('200100104',15,2,0.0000,300000.0000),('200100105',16,2,0.0000,300000.0000),('200100106',17,2,0.0000,100000.0000),('200100107',18,2,0.0000,100000.0000),('200100108',20,2,0.0000,100000.0000),('200100109',22,2,0.0000,100000.0000),('200100110',23,2,0.0000,100000.0000),('200100111',24,2,0.0000,100000.0000),('200100112',25,2,0.0000,100000.0000),('200100113',26,2,0.0000,100000.0000),('200100114',27,2,0.0000,100000.0000),('200100115',28,2,0.0000,100000.0000),('200100116',29,2,0.0000,100000.0000),('200100117',30,2,100000.0000,100000.0000),('200100118',31,2,5000.0000,100000.0000);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment` (
  `idpayment` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sender` varchar(128) NOT NULL,
  `receiver` varchar(128) NOT NULL,
  `amount` decimal(19,4) NOT NULL,
  `datetime` datetime NOT NULL,
  PRIMARY KEY (`idpayment`),
  UNIQUE KEY `idpayment_UNIQUE` (`idpayment`)
) ENGINE=InnoDB AUTO_INCREMENT=71 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
INSERT INTO `payment` VALUES (1,'100100101','100100102',15000.0000,'2016-09-17 17:25:31'),(2,'200100101','200100103',190000.0000,'2016-10-06 17:25:31'),(3,'100100101','100100102',1000.0000,'2016-10-06 17:25:31'),(4,'100100101','100100102',4567.0000,'2016-10-06 17:25:31'),(5,'100100101','100100102',4567.0000,'2016-10-06 17:25:31'),(6,'100100101','100100102',4567.0000,'2016-10-06 17:25:31'),(7,'100100101','100100102',4567.0000,'2016-10-06 17:25:31'),(8,'100100101','100100102',4567.0000,'2016-10-06 17:25:31'),(9,'100100101','100100102',4567.0000,'2016-10-06 17:25:31'),(10,'100100101','100100102',4567.0000,'2016-10-06 17:25:31'),(11,'100100101','100100102',10000.0000,'2016-10-06 17:25:31'),(12,'100100101','100100102',10000.0000,'2016-10-06 17:25:31'),(13,'100100101','100100102',10000.0000,'2016-10-06 17:25:31'),(14,'100100101','100100103',1000.0000,'2016-10-06 17:25:31'),(15,'100100101','100100102',31.0000,'2016-10-06 17:25:31'),(16,'100100101','100100102',7000.0000,'2016-10-06 17:25:31'),(17,'100100101','100100102',10000.0000,'2016-10-06 17:25:31'),(18,'100100101','100100102',10000.0000,'2016-10-06 17:25:31'),(19,'200100101','100100103',5000.0000,'2016-10-06 17:25:31'),(20,'100100101','100100103',5000.0000,'2016-10-06 17:25:31'),(21,'200100101','100100103',5000.0000,'2016-10-06 17:25:31'),(22,'100100101','100100103',1000.0000,'2016-10-17 23:29:05'),(23,'100100102','100100103',1000.0000,'2016-10-17 23:29:34'),(24,'200100102','100100103',1000.0000,'2016-10-17 23:30:08'),(25,'200100102','100100103',1000.0000,'2016-10-17 23:30:38'),(26,'200100101','100100103',1000.0000,'2016-10-17 23:30:59'),(27,'200100101','100100103',1000.0000,'2016-10-17 23:31:25'),(28,'200100101','100100103',1000.0000,'2016-10-17 23:31:25'),(29,'200100101','100100103',1000.0000,'2016-10-17 23:31:26'),(30,'200100101','100100103',1000.0000,'2016-10-17 23:31:26'),(31,'200100101','100100103',1000.0000,'2016-10-17 23:31:27'),(32,'200100101','100100103',1000.0000,'2016-10-17 23:31:27'),(33,'200100101','100100103',1000.0000,'2016-10-17 23:31:28'),(34,'200100101','100100103',1000.0000,'2016-10-17 23:31:28'),(35,'200100101','100100103',1000.0000,'2016-10-17 23:32:22'),(36,'200100101','100100103',1000.0000,'2016-10-17 23:32:23'),(37,'200100101','100100103',1000.0000,'2016-10-17 23:32:23'),(38,'200100101','100100103',1000.0000,'2016-10-17 23:32:24'),(39,'200100101','100100103',1000.0000,'2016-10-17 23:32:24'),(40,'200100101','100100103',1000.0000,'2016-10-17 23:32:25'),(41,'200100101','100100103',1000.0000,'2016-10-17 23:32:25'),(42,'100100101','100100102',4000.0000,'2016-10-17 23:41:55'),(43,'100100101','100100102',400000000.0000,'2016-10-17 23:42:01'),(44,'100100101','100100102',400000000.0000,'2016-10-17 23:42:02'),(45,'100100101','100100102',400000000000.0000,'2016-10-17 23:42:06'),(46,'100100101','100100102',400000000000.0000,'2016-10-17 23:42:07'),(47,'100100103','100100102',10.0000,'2016-10-17 23:45:20'),(48,'100100103','100100102',1000.0000,'2016-10-17 23:46:28'),(49,'100100101','100100103',500.0000,'2016-10-17 23:58:35'),(50,'200100101','100100103',500.0000,'2016-10-17 23:58:47'),(51,'200100101','100100103',500.0000,'2016-10-17 23:58:58'),(52,'200100102','100100101',778.0000,'2016-10-18 00:00:02'),(53,'200100101','100100103',50.0000,'2016-10-20 21:35:21'),(54,'200100101','100100102',1234.0000,'2016-10-22 17:21:00'),(55,'100100102','100100101',4321.0000,'2016-10-22 17:21:31'),(56,'200100103','100100103',15.0000,'2016-10-22 17:24:00'),(57,'200100102','100100103',1.0000,'2016-10-22 17:26:18'),(58,'200100101','100100103',5.0000,'2016-10-22 17:27:23'),(59,'200100101','100100102',25000.0000,'2016-10-22 17:31:19'),(60,'200100103','100100101',800.0000,'2016-10-23 16:14:40'),(61,'100100102','100100101',5000.0000,'2016-10-23 16:15:39'),(62,'100100102','100100101',7500.0000,'2016-10-23 16:17:07'),(63,'100100101','100100117',25000.0000,'2016-10-23 16:20:27'),(64,'200100101','100100117',1500.0000,'2016-10-23 16:25:55'),(65,'100100101','100100117',500.0000,'2016-10-23 16:26:04'),(66,'100100117','100100101',2000.0000,'2016-10-23 16:26:43'),(67,'100100117','100100101',25000.0000,'2016-10-23 16:32:31'),(68,'200100117','100100101',1000.0000,'2016-10-23 16:32:47'),(69,'200100117','100100101',99000.0000,'2016-10-23 16:33:14'),(70,'200100118','100100101',5000.0000,'2016-10-23 17:14:53');
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_requests`
--

DROP TABLE IF EXISTS `payment_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_requests` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `receiver` int(10) unsigned NOT NULL,
  `sender` int(10) unsigned NOT NULL,
  `amount` decimal(19,4) NOT NULL,
  `datetime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idpayment_requests_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_requests`
--

LOCK TABLES `payment_requests` WRITE;
/*!40000 ALTER TABLE `payment_requests` DISABLE KEYS */;
INSERT INTO `payment_requests` VALUES (12,31,2,5000.0000,'2016-10-23 17:15:12');
/*!40000 ALTER TABLE `payment_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `idusers` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `username` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `email` varchar(128) NOT NULL,
  `password` varchar(128) NOT NULL,
  `phone` varchar(128) DEFAULT NULL,
  `address` varchar(128) DEFAULT NULL,
  `passport` varchar(128) DEFAULT NULL,
  `latitude` int(11) DEFAULT NULL,
  `longitude` int(11) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  PRIMARY KEY (`idusers`),
  UNIQUE KEY `idusers_UNIQUE` (`idusers`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (2,'Hovhannes Grigoryan','hov','hovgrig@gmail.com','pwd','37491305404','Yerevan, Armenia',NULL,NULL,NULL,NULL),(3,'Koriun Aslanyan','kor','kor@gmail.com','pwd',NULL,NULL,NULL,NULL,NULL,NULL),(4,'Senik Alvrtsyan','seno','seno@gmail.com','pwd',NULL,NULL,NULL,NULL,NULL,NULL),(5,'Gexamyan Mushex','musho','musho@gmail.com','pwd',NULL,NULL,NULL,NULL,NULL,NULL),(15,'Bill Gates','bill','bill@ms.com','pwd',NULL,NULL,NULL,NULL,NULL,NULL),(16,'James Bond','bond','bond@007.com','pwd',NULL,NULL,NULL,NULL,NULL,NULL),(17,'Justin Bieber','jb','jb@pibib.com','pwd',NULL,NULL,NULL,NULL,NULL,NULL),(18,'Kim Kardashian','kim','kim@gmail.com','pwd',NULL,NULL,NULL,NULL,NULL,NULL),(20,'Harry Poter','harry','hp@gmail.com','pwd',NULL,NULL,NULL,NULL,NULL,NULL),(22,'Dan Bilzerian','dan','danb@gmail.com','pwd',NULL,NULL,NULL,NULL,NULL,NULL),(23,'Don Johns','don','don@gmail.com','pwd',NULL,NULL,NULL,NULL,NULL,NULL),(24,'Mickey Mouse','mickey','mickey@gmail.com','pwd',NULL,NULL,NULL,NULL,NULL,NULL),(25,'Karen Karapetyan','karen','kar@gmail.com','pwd',NULL,NULL,NULL,NULL,NULL,NULL),(26,'Betmen Gothem','betben','bm@gmail.com','pwd',NULL,NULL,NULL,NULL,NULL,NULL),(27,'Super men','sm','sm@gmail.com','pwd',NULL,NULL,NULL,NULL,NULL,NULL),(28,'Donald Duck','donald','donald@gmail.com','pwd',NULL,NULL,NULL,NULL,NULL,NULL),(29,'J Lo','jlo','jlo@gmail.com','pwd',NULL,NULL,NULL,NULL,NULL,NULL),(30,'Masha Grigoryan','masha','masha@gmail.com','pwd',NULL,NULL,NULL,NULL,NULL,NULL),(31,'Husein Bolt','bolt','bolt@gmail.com','pwd',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'plutus'
--

--
-- Dumping routines for database 'plutus'
--
/*!50003 DROP PROCEDURE IF EXISTS `CreateUser` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `CreateUser`(IN inName VARCHAR(128),
														 IN inUsername VARCHAR(128),
                                                         IN inEmail VARCHAR(128),
                                                         IN inPassword VARCHAR(128))
BEGIN

-- Variables needed to create accounts.
DECLARE newUserId INT;
DECLARE newDebitAccountId VARCHAR(128);
DECLARE newCreditAccountId VARCHAR(128);

DECLARE debitAccType INT;
DECLARE creditAccType INT;

DECLARE defaultCreditLimit DECIMAL(19, 4);

SET debitAccType = 1;
SET creditAccType = 2;
SET defaultCreditLimit = 100000;

-- 1. Create the new user first.
INSERT INTO plutus.users (name, username, email, password)
VALUES (inName, inUsername, inEmail, inPassword);

-- 2. Cool, now query to get the newely added user Id.
SELECT idusers INTO newUserId FROM plutus.users
WHERE binary username = inUsername;

-- 3. Before creating accounts determine the new account ids first.
SELECT MAX(idaccounts) + 1 INTO newDebitAccountId FROM plutus.accounts
WHERE type = debitAccType;

SELECT MAX(idaccounts) + 1 INTO newCreditAccountId FROM plutus.accounts
WHERE type = creditAccType;

-- 4. We are good to create both debit and credit acounts now.
INSERT INTO plutus.accounts (idaccounts, iduser, type, balance, `limit`)
VALUES (newDebitAccountId, newUserId, debitAccType, 0, 0);

INSERT INTO plutus.accounts (idaccounts, iduser, type, balance, `limit`)
VALUES (newCreditAccountId, newUserId, creditAccType, 0, defaultCreditLimit);

-- 5. Awesome, we want to return newely created user here.
SELECT idusers, name, username, email FROM users
WHERE idusers = newUserId;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `GetPaymentHistory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetPaymentHistory`(IN inUserID INT, IN inSent BOOL)
BEGIN

SELECT IF(inSent, sender, receiver) as account, mainType, name, username, amount, `datetime` FROM (
	SELECT sender, receiver, mainType, amount, `datetime`, mainUserId, iduser FROM (
		SELECT sender, receiver, type as mainType, amount, `datetime`, iduser as mainUserId
		FROM plutus.payment, plutus.accounts
		WHERE BINARY IF(inSent, sender, receiver) = idaccounts
        AND iduser = inUserID
	) AS R1
	LEFT JOIN plutus.accounts
	ON BINARY IF(inSent, R1.receiver, R1.sender) = plutus.accounts.idaccounts
) AS R2
LEFT JOIN plutus.users
ON binary R2.iduser = plutus.users.idusers
ORDER BY `datetime` DESC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `MakePayment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `MakePayment`(IN inAccount VARCHAR(128),
														  IN inUserID INT,
                                                          IN inAmount decimal(19,4))
this_proc:BEGIN

-- TODO, begin trnasaction.

DECLARE recivingAccountId VARCHAR(128);
DECLARE debitAccType INT;
DECLARE creditAccType INT;
DECLARE accountBalance decimal(19, 4);
DECLARE accountType INT;

SET debitAccType = 1;
SET creditAccType = 2;

-- 0 Make sure we know what type of account we operate with.
SELECT `type` INTO accountType FROM plutus.accounts
WHERE binary idaccounts = inAccount;

-- 1. Check if there are availible founds.
SELECT IF(accountType = debitAccType, balance, `limit` - balance) INTO accountBalance FROM plutus.accounts
WHERE binary idAccounts = inAccount;

IF (accountBalance < inAmount) THEN
	SIGNAL SQLSTATE 'ERR0R';
END IF;

-- 2. First of all, get the debit account of the reciving user so we can make the payment.
SELECT idaccounts INTO recivingAccountId FROM plutus.accounts
WHERE iduser = inUserId AND type = debitAccType;

-- 3. Now when we have the account we can start deducing the amount from sender account.
UPDATE plutus.accounts
SET balance = if(accountType = creditAccType,  balance + inAmount, balance - inAmount)
WHERE binary idaccounts = inAccount;

-- 4. Cool, now add amount to reciver account.
UPDATE plutus.accounts
SET balance = balance + inAmount
WHERE binary idaccounts = recivingAccountId;

-- 5. Register the payment into DB.
INSERT INTO plutus.payment (sender, receiver, amount, `datetime`)
VALUES (inAccount, recivingAccountId, inAmount, NOW());

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-10-23 17:32:49
