-- MySQL dump 10.13  Distrib 5.7.31, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: final
-- ------------------------------------------------------
-- Server version	8.0.21

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
-- Table structure for table `Bill`
--
DROP DATABASE IF EXISTS `final`;
CREATE SCHEMA `final`;
USE `final`;

DROP TABLE IF EXISTS `Bill`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Bill` (
  `Doctor_ID` int NOT NULL,
  `Medicine_ID` int NOT NULL,
  `Room_No` int NOT NULL,
  `Treatment_ID` int NOT NULL,
  KEY `Room_No` (`Room_No`),
  KEY `Doctor_ID` (`Doctor_ID`),
  KEY `Medicine_ID` (`Medicine_ID`),
  CONSTRAINT `Bill_ibfk_2` FOREIGN KEY (`Room_No`) REFERENCES `Rooms` (`Room_No`),
  CONSTRAINT `Bill_ibfk_3` FOREIGN KEY (`Doctor_ID`) REFERENCES `Doctor` (`Doctor_ID`),
  CONSTRAINT `Bill_ibfk_4` FOREIGN KEY (`Medicine_ID`) REFERENCES `Medicine` (`Medicine_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Bill`
--

LOCK TABLES `Bill` WRITE;
/*!40000 ALTER TABLE `Bill` DISABLE KEYS */;
INSERT INTO `Bill` VALUES (1,0,2,1),(2,0,1,2),(1,0,4,3),(3,0,5,4),(3,2,5,4),(1,3,4,3),(2,1,1,2),(1,2,2,1),(3,1,5,4);
/*!40000 ALTER TABLE `Bill` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Disease`
--

DROP TABLE IF EXISTS `Disease`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Disease` (
  `Disease_ID` int NOT NULL,
  `Name` varchar(50) DEFAULT NULL,
  KEY `Disease_ID` (`Disease_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Disease`
--

LOCK TABLES `Disease` WRITE;
/*!40000 ALTER TABLE `Disease` DISABLE KEYS */;
INSERT INTO `Disease` VALUES (1,'AIDS'),(2,'Dengue'),(3,'Malaria'),(4,'Jaundice'),(5,'Cancer'),(7,'Amar');
/*!40000 ALTER TABLE `Disease` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Doctor`
--

DROP TABLE IF EXISTS `Doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Doctor` (
  `Doctor_ID` int NOT NULL,
  `Gender` enum('M','F') DEFAULT NULL,
  `Email_id` varchar(50) DEFAULT NULL,
  `Class` enum('Permanent','Visiting','Trainee') DEFAULT NULL,
  `First_Name` varchar(50) DEFAULT NULL,
  `Middle_Name` varchar(50) DEFAULT NULL,
  `Last_Name` varchar(50) DEFAULT NULL,
  `Address` varchar(50) DEFAULT NULL,
  `D_O_B` date DEFAULT NULL,
  PRIMARY KEY (`Doctor_ID`),
  KEY `Doctor_ID` (`Doctor_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Doctor`
--

LOCK TABLES `Doctor` WRITE;
/*!40000 ALTER TABLE `Doctor` DISABLE KEYS */;
INSERT INTO `Doctor` VALUES (1,'M','sbvkjb.com','Permanent','Vasool','M','Raja','randomjagah1','2020-11-11'),(2,'M','kjabdcjkj.com','Trainee','Daniel','Hale','Williams','randomjagah2','2020-11-11'),(3,'M','jhvshjs.com','Visiting','Alexander','M','Fleming','randomjagah3','2020-11-11'),(4,'M','jvcjacjh.com','Permanent','Charles','Richard','Drew','randomjagah4','2020-11-11');
/*!40000 ALTER TABLE `Doctor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Doctor_Qualification`
--

DROP TABLE IF EXISTS `Doctor_Qualification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Doctor_Qualification` (
  `Doctor_ID` int NOT NULL,
  `Qualification` varchar(50) DEFAULT NULL,
  KEY `Doctor_ID` (`Doctor_ID`),
  CONSTRAINT `Doctor_Qualification_ibfk_1` FOREIGN KEY (`Doctor_ID`) REFERENCES `Doctor` (`Doctor_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Doctor_Qualification`
--

LOCK TABLES `Doctor_Qualification` WRITE;
/*!40000 ALTER TABLE `Doctor_Qualification` DISABLE KEYS */;
INSERT INTO `Doctor_Qualification` VALUES (1,'MBBS'),(2,'MBBS'),(2,'Sonology'),(3,'DMRT'),(3,'Anesthetist'),(4,'MBBS'),(4,'Radiology');
/*!40000 ALTER TABLE `Doctor_Qualification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Illness`
--

DROP TABLE IF EXISTS `Illness`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Illness` (
  `Disease_ID` int NOT NULL,
  `Patient_ID` int NOT NULL,
  PRIMARY KEY (`Disease_ID`,`Patient_ID`),
  KEY `Patient_ID` (`Patient_ID`),
  KEY `Disease_ID` (`Disease_ID`),
  CONSTRAINT `Illness_ibfk_1` FOREIGN KEY (`Patient_ID`) REFERENCES `Patient` (`Patient_ID`),
  CONSTRAINT `Illness_ibfk_2` FOREIGN KEY (`Disease_ID`) REFERENCES `Disease` (`Disease_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Illness`
--

LOCK TABLES `Illness` WRITE;
/*!40000 ALTER TABLE `Illness` DISABLE KEYS */;
INSERT INTO `Illness` VALUES (2,1),(1,2),(4,3),(3,4);
/*!40000 ALTER TABLE `Illness` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Medicine`
--

DROP TABLE IF EXISTS `Medicine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Medicine` (
  `Cost` int DEFAULT NULL,
  `Expiry_Date` date DEFAULT NULL,
  `Medicine_ID` int NOT NULL,
  KEY `Medicine_ID` (`Medicine_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Medicine`
--

LOCK TABLES `Medicine` WRITE;
/*!40000 ALTER TABLE `Medicine` DISABLE KEYS */;
INSERT INTO `Medicine` VALUES (100,'2020-11-11',1),(500,'2021-10-10',2),(1000,'2025-02-01',3),(0,'3000-01-01',0);
/*!40000 ALTER TABLE `Medicine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Nurse`
--

DROP TABLE IF EXISTS `Nurse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Nurse` (
  `Nurse_ID` int NOT NULL,
  `Room_No` int NOT NULL,
  `First_Name` varchar(50) DEFAULT NULL,
  `Middle_Name` varchar(50) DEFAULT NULL,
  `Last_Name` varchar(50) DEFAULT NULL,
  `Gender` enum('M','F') DEFAULT NULL,
  `Qualification` varchar(50) DEFAULT NULL,
  KEY `Room_No` (`Room_No`),
  KEY `Nurse_ID` (`Nurse_ID`),
  CONSTRAINT `Nurse_ibfk_1` FOREIGN KEY (`Room_No`) REFERENCES `Rooms` (`Room_No`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Nurse`
--

LOCK TABLES `Nurse` WRITE;
/*!40000 ALTER TABLE `Nurse` DISABLE KEYS */;
INSERT INTO `Nurse` VALUES (1,3,'Florence','S','Nightingale','F','GNM'),(2,4,'Margaret','G','Sanger','F','MBBS'),(3,1,'Jack','Peter','Jackson','M','Bsc'),(4,2,'George','T','Tom','M','MBBS'),(5,5,'Amber','G','Mayer','F','GNM');
/*!40000 ALTER TABLE `Nurse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Nurse_Number`
--

DROP TABLE IF EXISTS `Nurse_Number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Nurse_Number` (
  `Nurse_ID` int NOT NULL,
  `Ph_No` varchar(15) DEFAULT NULL,
  KEY `Nurse_ID` (`Nurse_ID`),
  CONSTRAINT `Nurse_Number_ibfk_1` FOREIGN KEY (`Nurse_ID`) REFERENCES `Nurse` (`Nurse_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Nurse_Number`
--

LOCK TABLES `Nurse_Number` WRITE;
/*!40000 ALTER TABLE `Nurse_Number` DISABLE KEYS */;
INSERT INTO `Nurse_Number` VALUES (1,'2233445566'),(2,'1234567890'),(2,'9880110102'),(3,'8883456723'),(3,'1234428963'),(4,'9874536025'),(5,'8342710635');
/*!40000 ALTER TABLE `Nurse_Number` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Patient`
--

DROP TABLE IF EXISTS `Patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Patient` (
  `Patient_ID` int NOT NULL,
  `Room_No` int DEFAULT NULL,
  `Doctor_ID` int DEFAULT NULL,
  `First_Name` varchar(50) DEFAULT NULL,
  `Middle_Name` varchar(50) DEFAULT NULL,
  `Last_Name` varchar(50) DEFAULT NULL,
  `Address` varchar(50) DEFAULT NULL,
  `Email_id` varchar(50) DEFAULT NULL,
  `Gender` enum('M','F') DEFAULT NULL,
  `D_O_B` date DEFAULT NULL,
  `Condn` enum('Alive','Dead','Coma') DEFAULT NULL,
  PRIMARY KEY (`Patient_ID`),
  KEY `Room_No` (`Room_No`),
  KEY `Doctor_ID` (`Doctor_ID`),
  CONSTRAINT `Patient_ibfk_1` FOREIGN KEY (`Doctor_ID`) REFERENCES `Doctor` (`Doctor_ID`),
  CONSTRAINT `Patient_ibfk_2` FOREIGN KEY (`Room_No`) REFERENCES `Rooms` (`Room_No`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Patient`
--

LOCK TABLES `Patient` WRITE;
/*!40000 ALTER TABLE `Patient` DISABLE KEYS */;
INSERT INTO `Patient` VALUES (1,5,3,'Peter','P','Parker','12,NewAvenue,NY','skj.com','M','2000-11-02','Alive'),(2,4,1,'Natasha','R','Romanoff','31,12thstreet,NewYork','fsgg.com','F','1992-11-10','Coma'),(3,1,2,'James','Jonah','Johnson','ParkerLane,LA','alooo.com','M','1965-09-12','Alive'),(4,2,1,'Leonardo','Di','Caprio','12,Amazingstreet,California','kkkkhhh.com','M','1985-04-09','Alive'),(5,6,3,'Ashish','Saraswati','tt','laudanagar','hfghjgh.com','M','2000-11-01','Alive');
/*!40000 ALTER TABLE `Patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Patient_Attender`
--

DROP TABLE IF EXISTS `Patient_Attender`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Patient_Attender` (
  `Patient_ID` int NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Gender` enum('M','F') DEFAULT NULL,
  `Ph_No` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`Patient_ID`,`Name`),
  CONSTRAINT `Patient_Attender_ibfk_1` FOREIGN KEY (`Patient_ID`) REFERENCES `Patient` (`Patient_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Patient_Attender`
--

LOCK TABLES `Patient_Attender` WRITE;
/*!40000 ALTER TABLE `Patient_Attender` DISABLE KEYS */;
/*!40000 ALTER TABLE `Patient_Attender` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Patient_numbers`
--

DROP TABLE IF EXISTS `Patient_numbers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Patient_numbers` (
  `Patient_ID` int NOT NULL,
  `Pho_No` varchar(15) DEFAULT NULL,
  KEY `Patient_ID` (`Patient_ID`),
  CONSTRAINT `Patient_numbers_ibfk_1` FOREIGN KEY (`Patient_ID`) REFERENCES `Patient` (`Patient_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Patient_numbers`
--

LOCK TABLES `Patient_numbers` WRITE;
/*!40000 ALTER TABLE `Patient_numbers` DISABLE KEYS */;
INSERT INTO `Patient_numbers` VALUES (1,'134'),(2,'178'),(3,'678'),(4,'544'),(5,'667'),(1,'777666555');
/*!40000 ALTER TABLE `Patient_numbers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Prescription`
--

DROP TABLE IF EXISTS `Prescription`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Prescription` (
  `Medicine_ID` int NOT NULL,
  `Patient_ID` int NOT NULL,
  KEY `Patient_ID` (`Patient_ID`),
  KEY `Medicine_ID` (`Medicine_ID`),
  CONSTRAINT `Prescription_ibfk_1` FOREIGN KEY (`Patient_ID`) REFERENCES `Patient` (`Patient_ID`),
  CONSTRAINT `Prescription_ibfk_2` FOREIGN KEY (`Medicine_ID`) REFERENCES `Medicine` (`Medicine_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Prescription`
--

LOCK TABLES `Prescription` WRITE;
/*!40000 ALTER TABLE `Prescription` DISABLE KEYS */;
INSERT INTO `Prescription` VALUES (2,1),(3,2),(1,3),(2,4),(1,1);
/*!40000 ALTER TABLE `Prescription` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Rooms`
--

DROP TABLE IF EXISTS `Rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Rooms` (
  `Room_No` int NOT NULL,
  `Cost` int DEFAULT NULL,
  `Type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Room_No`),
  KEY `Room_No` (`Room_No`),
  KEY `Room_No_2` (`Room_No`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Rooms`
--

LOCK TABLES `Rooms` WRITE;
/*!40000 ALTER TABLE `Rooms` DISABLE KEYS */;
INSERT INTO `Rooms` VALUES (1,1000,'normal'),(2,1000,'normal'),(3,2000,'AC'),(4,2000,'AC'),(5,5000,'ICU'),(6,2000,'normal');
/*!40000 ALTER TABLE `Rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Treatment`
--

DROP TABLE IF EXISTS `Treatment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Treatment` (
  `Treatment_ID` int NOT NULL,
  `Patient_ID` int NOT NULL,
  `Bill` int DEFAULT NULL,
  `Time` int DEFAULT NULL,
  KEY `Patient_ID` (`Patient_ID`),
  KEY `Treatment_ID` (`Treatment_ID`),
  CONSTRAINT `Treatment_ibfk_1` FOREIGN KEY (`Patient_ID`) REFERENCES `Patient` (`Patient_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Treatment`
--

LOCK TABLES `Treatment` WRITE;
/*!40000 ALTER TABLE `Treatment` DISABLE KEYS */;
INSERT INTO `Treatment` VALUES (1,4,1080,4),(2,3,1282,7),(3,2,1460,7),(4,1,1332,4);
/*!40000 ALTER TABLE `Treatment` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-10-07 17:20:57


