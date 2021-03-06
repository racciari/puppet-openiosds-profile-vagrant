-- MySQL dump 10.14  Distrib 5.5.44-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: pydiodb
-- ------------------------------------------------------
-- Server version	5.5.44-MariaDB

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

CREATE DATABASE IF NOT EXISTS `pydiodb`;
USE `pydiodb`;

--
-- Table structure for table `ajxp_changes`
--

DROP TABLE IF EXISTS `ajxp_changes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ajxp_changes` (
	  `seq` int(20) NOT NULL AUTO_INCREMENT,
	  `repository_identifier` text COLLATE utf8_unicode_ci NOT NULL,
	  `node_id` bigint(20) NOT NULL,
	  `type` enum('create','delete','path','content') COLLATE utf8_unicode_ci NOT NULL,
	  `source` text COLLATE utf8_unicode_ci NOT NULL,
	  `target` text COLLATE utf8_unicode_ci NOT NULL,
	  PRIMARY KEY (`seq`),
	  KEY `node_id` (`node_id`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ajxp_changes`
--

LOCK TABLES `ajxp_changes` WRITE;
/*!40000 ALTER TABLE `ajxp_changes` DISABLE KEYS */;
/*!40000 ALTER TABLE `ajxp_changes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ajxp_feed`
--

DROP TABLE IF EXISTS `ajxp_feed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ajxp_feed` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `edate` int(11) NOT NULL,
	  `etype` varchar(12) COLLATE utf8_unicode_ci NOT NULL,
	  `htype` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
	  `index_path` mediumtext COLLATE utf8_unicode_ci,
	  `user_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
	  `repository_id` varchar(33) COLLATE utf8_unicode_ci NOT NULL,
	  `user_group` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
	  `repository_scope` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
	  `repository_owner` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
	  `content` longblob NOT NULL,
	  PRIMARY KEY (`id`),
	  KEY `edate` (`edate`,`etype`,`htype`,`user_id`,`repository_id`),
	  KEY `index_path` (`index_path`(40))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ajxp_feed`
--

LOCK TABLES `ajxp_feed` WRITE;
/*!40000 ALTER TABLE `ajxp_feed` DISABLE KEYS */;
/*!40000 ALTER TABLE `ajxp_feed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ajxp_groups`
--

DROP TABLE IF EXISTS `ajxp_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ajxp_groups` (
	  `groupPath` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
	  `groupLabel` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
	  PRIMARY KEY (`groupPath`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ajxp_groups`
--

LOCK TABLES `ajxp_groups` WRITE;
/*!40000 ALTER TABLE `ajxp_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `ajxp_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ajxp_index`
--

DROP TABLE IF EXISTS `ajxp_index`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ajxp_index` (
	  `node_id` int(20) NOT NULL AUTO_INCREMENT,
	  `node_path` text COLLATE utf8_unicode_ci NOT NULL,
	  `bytesize` bigint(20) NOT NULL,
	  `md5` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
	  `mtime` int(11) NOT NULL,
	  `repository_identifier` text COLLATE utf8_unicode_ci NOT NULL,
	  PRIMARY KEY (`node_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ajxp_index`
--

LOCK TABLES `ajxp_index` WRITE;
/*!40000 ALTER TABLE `ajxp_index` DISABLE KEYS */;
/*!40000 ALTER TABLE `ajxp_index` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`pydiouser`@`localhost`*/ /*!50003 TRIGGER `LOG_INSERT` AFTER INSERT ON `ajxp_index`
FOR EACH ROW INSERT INTO ajxp_changes (repository_identifier, node_id,source,target,type)
  VALUES (new.repository_identifier, new.node_id, 'NULL', new.node_path, 'create') */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`pydiouser`@`localhost`*/ /*!50003 TRIGGER `LOG_UPDATE` AFTER UPDATE ON `ajxp_index`
FOR EACH ROW INSERT INTO ajxp_changes (repository_identifier, node_id,source,target,type)
  VALUES (new.repository_identifier, new.node_id, old.node_path, new.node_path, CASE old.node_path = new.node_path WHEN true THEN 'content' ELSE 'path' END) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`pydiouser`@`localhost`*/ /*!50003 TRIGGER `LOG_DELETE` AFTER DELETE ON `ajxp_index`
FOR EACH ROW INSERT INTO ajxp_changes (repository_identifier, node_id,source,target,type)
  VALUES (old.repository_identifier, old.node_id, old.node_path, 'NULL', 'delete') */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ajxp_log`
--

DROP TABLE IF EXISTS `ajxp_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ajxp_log` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `logdate` datetime DEFAULT NULL,
	  `remote_ip` varchar(45) DEFAULT NULL,
	  `severity` enum('DEBUG','INFO','NOTICE','WARNING','ERROR') DEFAULT NULL,
	  `user` varchar(255) DEFAULT NULL,
	  `source` varchar(255) DEFAULT NULL,
	  `message` text,
	  `params` text,
	  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ajxp_log`
--

LOCK TABLES `ajxp_log` WRITE;
/*!40000 ALTER TABLE `ajxp_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `ajxp_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ajxp_plugin_configs`
--

DROP TABLE IF EXISTS `ajxp_plugin_configs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ajxp_plugin_configs` (
	  `id` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
	  `configs` longblob NOT NULL,
	  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ajxp_plugin_configs`
--

LOCK TABLES `ajxp_plugin_configs` WRITE;
/*!40000 ALTER TABLE `ajxp_plugin_configs` DISABLE KEYS */;
INSERT INTO `ajxp_plugin_configs` VALUES ('access.swift','a:7:{s:19:\"AJXP_PLUGIN_ENABLED\";b:1;s:17:\"SHOW_HIDDEN_FILES\";b:0;s:12:\"HIDE_RECYCLE\";b:0;s:15:\"HIDE_EXTENSIONS\";s:3:\"ser\";s:12:\"HIDE_FOLDERS\";s:0:\"\";s:14:\"HIDE_FILENAMES\";s:0:\"\";s:19:\"DEFAULT_METASOURCES\";s:0:\"\";}'),('core.ajaxplorer','a:2:{s:17:\"APPLICATION_TITLE\";s:5:\"Pydio\";s:16:\"DEFAULT_LANGUAGE\";s:2:\"en\";}'),('core.log','a:1:{s:22:\"UNIQUE_PLUGIN_INSTANCE\";a:3:{s:13:\"instance_name\";s:7:\"log.sql\";s:18:\"group_switch_value\";s:7:\"log.sql\";s:10:\"SQL_DRIVER\";a:2:{s:11:\"core_driver\";s:4:\"core\";s:18:\"group_switch_value\";s:4:\"core\";}}}'),('core.mq','a:1:{s:18:\"UNIQUE_MS_INSTANCE\";a:3:{s:13:\"instance_name\";s:6:\"mq.sql\";s:18:\"group_switch_value\";s:6:\"mq.sql\";s:10:\"SQL_DRIVER\";a:2:{s:11:\"core_driver\";s:4:\"core\";s:18:\"group_switch_value\";s:4:\"core\";}}}'),('core.notifications','a:2:{s:11:\"USER_EVENTS\";b:1;s:20:\"UNIQUE_FEED_INSTANCE\";a:3:{s:13:\"instance_name\";s:8:\"feed.sql\";s:18:\"group_switch_value\";s:8:\"feed.sql\";s:10:\"SQL_DRIVER\";a:2:{s:11:\"core_driver\";s:4:\"core\";s:18:\"group_switch_value\";s:4:\"core\";}}}'),('core.uploader','a:5:{s:18:\"ALLOWED_EXTENSIONS\";s:0:\"\";s:27:\"ALLOWED_EXTENSIONS_READABLE\";s:0:\"\";s:17:\"UPLOAD_MAX_NUMBER\";s:1:\"0\";s:15:\"UPLOAD_MAX_SIZE\";s:7:\"1073741824\";s:21:\"UPLOAD_MAX_SIZE_TOTAL\";s:1:\"0\";}'),('gui.ajax','a:1:{s:22:\"CUSTOM_WELCOME_MESSAGE\";s:16:\"Welcome to Pydio\";}');
/*!40000 ALTER TABLE `ajxp_plugin_configs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ajxp_repo`
--

DROP TABLE IF EXISTS `ajxp_repo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ajxp_repo` (
	  `uuid` varchar(33) COLLATE utf8_unicode_ci NOT NULL,
	  `parent_uuid` varchar(33) COLLATE utf8_unicode_ci DEFAULT NULL,
	  `owner_user_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
	  `child_user_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
	  `path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
	  `display` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
	  `accessType` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
	  `recycle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
	  `bcreate` tinyint(1) DEFAULT NULL,
	  `writeable` tinyint(1) DEFAULT NULL,
	  `enabled` tinyint(1) DEFAULT NULL,
	  `isTemplate` tinyint(1) DEFAULT NULL,
	  `inferOptionsFromParent` tinyint(1) DEFAULT NULL,
	  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
	  `groupPath` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
	  PRIMARY KEY (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ajxp_repo`
--

LOCK TABLES `ajxp_repo` WRITE;
/*!40000 ALTER TABLE `ajxp_repo` DISABLE KEYS */;
INSERT INTO `ajxp_repo` VALUES ('0bc84a5af7fe4bcc6f08a1a26aa824e4',NULL,NULL,NULL,NULL,'OpenIO','swift','',0,1,1,0,0,'openio','/');
/*!40000 ALTER TABLE `ajxp_repo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ajxp_repo_options`
--

DROP TABLE IF EXISTS `ajxp_repo_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ajxp_repo_options` (
	  `oid` int(11) NOT NULL AUTO_INCREMENT,
	  `uuid` varchar(33) COLLATE utf8_unicode_ci NOT NULL,
	  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
	  `val` blob,
	  PRIMARY KEY (`oid`),
	  KEY `uuid` (`uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=96 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ajxp_repo_options`
--

LOCK TABLES `ajxp_repo_options` WRITE;
/*!40000 ALTER TABLE `ajxp_repo_options` DISABLE KEYS */;
INSERT INTO `ajxp_repo_options` VALUES (77,'0bc84a5af7fe4bcc6f08a1a26aa824e4','CREATION_TIME','$phpserial$i:1442007162;'),(78,'0bc84a5af7fe4bcc6f08a1a26aa824e4','CREATION_USER','admin'),(79,'0bc84a5af7fe4bcc6f08a1a26aa824e4','USERNAME','demo'),(80,'0bc84a5af7fe4bcc6f08a1a26aa824e4','PASSWORD','DEMO_PASS'),(81,'0bc84a5af7fe4bcc6f08a1a26aa824e4','TENANT_ID','VAGRANT_TENANT_ID'),(82,'0bc84a5af7fe4bcc6f08a1a26aa824e4','ENDPOINT','http://VAGRANT_SWIFT_IP:5000/v2.0'),(83,'0bc84a5af7fe4bcc6f08a1a26aa824e4','REGION','localhost-1'),(84,'0bc84a5af7fe4bcc6f08a1a26aa824e4','CONTAINER','demo'),(85,'0bc84a5af7fe4bcc6f08a1a26aa824e4','RECYCLE_BIN','recycle_bin'),(86,'0bc84a5af7fe4bcc6f08a1a26aa824e4','CHARSET',''),(87,'0bc84a5af7fe4bcc6f08a1a26aa824e4','PAGINATION_THRESHOLD','500'),(88,'0bc84a5af7fe4bcc6f08a1a26aa824e4','PAGINATION_NUMBER','200'),(89,'0bc84a5af7fe4bcc6f08a1a26aa824e4','REMOTE_SORTING','$phpserial$b:1;'),(90,'0bc84a5af7fe4bcc6f08a1a26aa824e4','USER_DESCRIPTION',''),(91,'0bc84a5af7fe4bcc6f08a1a26aa824e4','AJXP_SLUG',''),(92,'0bc84a5af7fe4bcc6f08a1a26aa824e4','AJXP_WEBDAV_DISABLED','$phpserial$b:0;'),(93,'0bc84a5af7fe4bcc6f08a1a26aa824e4','REMOTE_SORTING_DEFAULT_COLUMN','ajxp_label'),(94,'0bc84a5af7fe4bcc6f08a1a26aa824e4','REMOTE_SORTING_DEFAULT_DIRECTION','asc'),(95,'0bc84a5af7fe4bcc6f08a1a26aa824e4','DEFAULT_RIGHTS','');
/*!40000 ALTER TABLE `ajxp_repo_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ajxp_roles`
--

DROP TABLE IF EXISTS `ajxp_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ajxp_roles` (
	  `role_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
	  `serial_role` text COLLATE utf8_unicode_ci NOT NULL,
	  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ajxp_roles`
--

LOCK TABLES `ajxp_roles` WRITE;
/*!40000 ALTER TABLE `ajxp_roles` DISABLE KEYS */;
INSERT INTO `ajxp_roles` VALUES ('AJXP_USR_/admin','O:9:\"AJXP_Role\":6:{s:12:\"\0*\0groupPath\";N;s:9:\"\0*\0roleId\";s:15:\"AJXP_USR_/admin\";s:7:\"\0*\0acls\";a:7:{i:1;s:2:\"rw\";s:9:\"ajxp_user\";s:2:\"rw\";s:9:\"ajxp_home\";s:2:\"rw\";s:9:\"ajxp_conf\";s:2:\"rw\";i:0;s:2:\"rw\";s:11:\"fs_template\";s:2:\"rw\";s:32:\"0bc84a5af7fe4bcc6f08a1a26aa824e4\";s:2:\"rw\";}s:13:\"\0*\0parameters\";a:1:{s:19:\"AJXP_REPO_SCOPE_ALL\";a:1:{s:9:\"core.conf\";a:1:{s:17:\"USER_DISPLAY_NAME\";s:5:\"admin\";}}}s:10:\"\0*\0actions\";a:0:{}s:14:\"\0*\0autoApplies\";a:0:{}}'),('GUEST','O:9:\"AJXP_Role\":6:{s:12:\"\0*\0groupPath\";N;s:9:\"\0*\0roleId\";s:5:\"GUEST\";s:7:\"\0*\0acls\";a:0:{}s:13:\"\0*\0parameters\";a:1:{s:19:\"AJXP_REPO_SCOPE_ALL\";a:1:{s:9:\"core.conf\";a:1:{s:17:\"ROLE_DISPLAY_NAME\";s:15:\"Guest user role\";}}}s:10:\"\0*\0actions\";a:1:{s:19:\"AJXP_REPO_SCOPE_ALL\";a:3:{s:9:\"access.fs\";a:1:{s:5:\"purge\";s:8:\"disabled\";}s:10:\"meta.watch\";a:1:{s:12:\"toggle_watch\";s:8:\"disabled\";}s:12:\"index.lucene\";a:1:{s:5:\"index\";s:8:\"disabled\";}}}s:14:\"\0*\0autoApplies\";a:1:{i:0;s:5:\"guest\";}}'),('MINISITE','O:9:\"AJXP_Role\":6:{s:12:\"\0*\0groupPath\";N;s:9:\"\0*\0roleId\";s:8:\"MINISITE\";s:7:\"\0*\0acls\";a:0:{}s:13:\"\0*\0parameters\";a:1:{s:19:\"AJXP_REPO_SCOPE_ALL\";a:1:{s:9:\"core.conf\";a:1:{s:17:\"ROLE_DISPLAY_NAME\";s:14:\"Minisite Users\";}}}s:10:\"\0*\0actions\";a:1:{s:22:\"AJXP_REPO_SCOPE_SHARED\";a:9:{s:9:\"access.fs\";a:3:{s:9:\"ajxp_link\";b:0;s:5:\"chmod\";b:0;s:5:\"purge\";b:0;}s:10:\"meta.watch\";a:1:{s:12:\"toggle_watch\";b:0;}s:11:\"conf.serial\";a:1:{s:13:\"get_bookmarks\";b:0;}s:8:\"conf.sql\";a:1:{s:13:\"get_bookmarks\";b:0;}s:12:\"index.lucene\";a:1:{s:5:\"index\";b:0;}s:12:\"action.share\";a:6:{s:5:\"share\";b:0;s:17:\"share-edit-shared\";b:0;s:22:\"share-folder-workspace\";b:0;s:19:\"share-file-minisite\";b:0;s:24:\"share-selection-minisite\";b:0;s:28:\"share-folder-minisite-public\";b:0;}s:8:\"gui.ajax\";a:1:{s:8:\"bookmark\";b:0;}s:11:\"auth.serial\";a:1:{s:11:\"pass_change\";b:0;}s:8:\"auth.sql\";a:1:{s:11:\"pass_change\";b:0;}}}s:14:\"\0*\0autoApplies\";a:0:{}}'),('MINISITE_NODOWNLOAD','O:9:\"AJXP_Role\":6:{s:12:\"\0*\0groupPath\";N;s:9:\"\0*\0roleId\";s:19:\"MINISITE_NODOWNLOAD\";s:7:\"\0*\0acls\";a:0:{}s:13:\"\0*\0parameters\";a:1:{s:19:\"AJXP_REPO_SCOPE_ALL\";a:1:{s:9:\"core.conf\";a:1:{s:17:\"ROLE_DISPLAY_NAME\";s:28:\"Minisite Users - No Download\";}}}s:10:\"\0*\0actions\";a:1:{s:22:\"AJXP_REPO_SCOPE_SHARED\";a:1:{s:9:\"access.fs\";a:4:{s:8:\"download\";b:0;s:14:\"download_chunk\";b:0;s:16:\"prepare_chunk_dl\";b:0;s:12:\"download_all\";b:0;}}}s:14:\"\0*\0autoApplies\";a:0:{}}'),('ROOT_ROLE','O:9:\"AJXP_Role\":6:{s:12:\"\0*\0groupPath\";N;s:9:\"\0*\0roleId\";s:9:\"ROOT_ROLE\";s:7:\"\0*\0acls\";a:3:{i:1;s:2:\"rw\";s:9:\"ajxp_user\";s:2:\"rw\";s:9:\"ajxp_home\";s:2:\"rw\";}s:13:\"\0*\0parameters\";a:1:{s:19:\"AJXP_REPO_SCOPE_ALL\";a:3:{s:9:\"core.conf\";a:2:{s:17:\"ROLE_DISPLAY_NAME\";s:9:\"Root Role\";s:24:\"DEFAULT_START_REPOSITORY\";s:9:\"ajxp_home\";}s:17:\"action.disclaimer\";a:1:{s:19:\"DISCLAIMER_ACCEPTED\";s:2:\"no\";}s:13:\"meta.syncable\";a:3:{s:13:\"REPO_SYNCABLE\";s:4:\"true\";s:23:\"OBSERVE_STORAGE_CHANGES\";s:5:\"false\";s:21:\"OBSERVE_STORAGE_EVERY\";s:1:\"5\";}}}s:10:\"\0*\0actions\";a:0:{}s:14:\"\0*\0autoApplies\";a:2:{i:0;s:8:\"standard\";i:1;s:5:\"admin\";}}');
/*!40000 ALTER TABLE `ajxp_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ajxp_simple_store`
--

DROP TABLE IF EXISTS `ajxp_simple_store`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ajxp_simple_store` (
	  `object_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
	  `store_id` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
	  `serialized_data` longtext COLLATE utf8_unicode_ci,
	  `binary_data` longblob,
	  `related_object_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
	  `insertion_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	  PRIMARY KEY (`object_id`,`store_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ajxp_simple_store`
--

LOCK TABLES `ajxp_simple_store` WRITE;
/*!40000 ALTER TABLE `ajxp_simple_store` DISABLE KEYS */;
/*!40000 ALTER TABLE `ajxp_simple_store` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ajxp_user_bookmarks`
--

DROP TABLE IF EXISTS `ajxp_user_bookmarks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ajxp_user_bookmarks` (
	  `rid` int(11) NOT NULL AUTO_INCREMENT,
	  `login` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
	  `repo_uuid` varchar(33) COLLATE utf8_unicode_ci NOT NULL,
	  `path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
	  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
	  PRIMARY KEY (`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ajxp_user_bookmarks`
--

LOCK TABLES `ajxp_user_bookmarks` WRITE;
/*!40000 ALTER TABLE `ajxp_user_bookmarks` DISABLE KEYS */;
/*!40000 ALTER TABLE `ajxp_user_bookmarks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ajxp_user_prefs`
--

DROP TABLE IF EXISTS `ajxp_user_prefs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ajxp_user_prefs` (
	  `rid` int(11) NOT NULL AUTO_INCREMENT,
	  `login` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
	  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
	  `val` blob,
	  PRIMARY KEY (`rid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ajxp_user_prefs`
--

LOCK TABLES `ajxp_user_prefs` WRITE;
/*!40000 ALTER TABLE `ajxp_user_prefs` DISABLE KEYS */;
INSERT INTO `ajxp_user_prefs` VALUES (1,'admin','AJXP_WEBDAV_DATA','$phpserial$a:1:{s:3:\"HA1\";s:32:\"f95f32f9ca9206eb9eb5ddfcdd3fe6b5\";}'),(2,'admin','ls_history','{\"ajxp_conf\":\"/config/plugins\"}'),(3,'admin','gui_preferences','{\"content_pane_FilesList\":{\"repo-ajxp_conf\":{\"display\":\"detail\"}}}');
/*!40000 ALTER TABLE `ajxp_user_prefs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ajxp_user_rights`
--

DROP TABLE IF EXISTS `ajxp_user_rights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ajxp_user_rights` (
	  `rid` int(11) NOT NULL AUTO_INCREMENT,
	  `login` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
	  `repo_uuid` varchar(33) COLLATE utf8_unicode_ci NOT NULL,
	  `rights` mediumtext COLLATE utf8_unicode_ci NOT NULL,
	  PRIMARY KEY (`rid`),
	  KEY `login` (`login`),
	  KEY `repo_uuid` (`repo_uuid`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ajxp_user_rights`
--

LOCK TABLES `ajxp_user_rights` WRITE;
/*!40000 ALTER TABLE `ajxp_user_rights` DISABLE KEYS */;
INSERT INTO `ajxp_user_rights` VALUES (11,'admin','ajxp.admin','1'),(12,'admin','ajxp.roles','$phpserial$a:2:{s:9:\"ROOT_ROLE\";b:1;s:15:\"AJXP_USR_/admin\";b:1;}');
/*!40000 ALTER TABLE `ajxp_user_rights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ajxp_user_teams`
--

DROP TABLE IF EXISTS `ajxp_user_teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ajxp_user_teams` (
	  `team_id` varchar(70) COLLATE utf8_unicode_ci NOT NULL,
	  `user_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
	  `team_label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
	  `owner_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
	  PRIMARY KEY (`team_id`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ajxp_user_teams`
--

LOCK TABLES `ajxp_user_teams` WRITE;
/*!40000 ALTER TABLE `ajxp_user_teams` DISABLE KEYS */;
/*!40000 ALTER TABLE `ajxp_user_teams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ajxp_users`
--

DROP TABLE IF EXISTS `ajxp_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ajxp_users` (
	  `login` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
	  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
	  `groupPath` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
	  PRIMARY KEY (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ajxp_users`
--

LOCK TABLES `ajxp_users` WRITE;
/*!40000 ALTER TABLE `ajxp_users` DISABLE KEYS */;
INSERT INTO `ajxp_users` VALUES ('admin','sha256:1000:gDohf0sBWlgvxdcwJxUaLSumQbKIJ9PU:ETY154JLle1OW6yAD696fa8LKR5gQ1CH','/');
/*!40000 ALTER TABLE `ajxp_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ajxp_version`
--

DROP TABLE IF EXISTS `ajxp_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ajxp_version` (
	  `db_build` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ajxp_version`
--

LOCK TABLES `ajxp_version` WRITE;
/*!40000 ALTER TABLE `ajxp_version` DISABLE KEYS */;
INSERT INTO `ajxp_version` VALUES (60);
/*!40000 ALTER TABLE `ajxp_version` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-09-12  2:24:47
