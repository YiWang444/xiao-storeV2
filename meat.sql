-- MySQL dump 10.13  Distrib 8.0.33, for macos13 (arm64)
--
-- Host: 127.0.0.1    Database: storeDB
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `province` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `district` varchar(100) DEFAULT NULL,
  `detail` varchar(200) DEFAULT NULL,
  `telephone` char(11) NOT NULL COMMENT '收货手机号',
  `name` varchar(20) NOT NULL COMMENT '收货名',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `address_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (13,1,'福建省','厦门市','思明区','湖滨北路61号','15980770666','zhangsan'),(14,1,'福建省','厦门市','思明区','厦门市思明区厦门市人民政府','15980770666','zhangsan');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `address_order`
--

DROP TABLE IF EXISTS `address_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address_order` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_id` bigint NOT NULL COMMENT '订单id',
  `address_id` int NOT NULL COMMENT '地址id',
  PRIMARY KEY (`id`),
  KEY `FK_address_order_address_id` (`address_id`),
  CONSTRAINT `FK_address_order_address_id` FOREIGN KEY (`address_id`) REFERENCES `address` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address_order`
--

LOCK TABLES `address_order` WRITE;
/*!40000 ALTER TABLE `address_order` DISABLE KEYS */;
INSERT INTO `address_order` VALUES (19,1714890246979592,14);
/*!40000 ALTER TABLE `address_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carousel`
--

DROP TABLE IF EXISTS `carousel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carousel` (
  `carousel_id` int NOT NULL AUTO_INCREMENT COMMENT '轮播ID',
  `img_path` char(200) NOT NULL COMMENT '轮播图图片路径',
  `describes` char(50) DEFAULT NULL COMMENT '轮播图描述',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除',
  `version` int NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`carousel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='轮播图表格';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carousel`
--

LOCK TABLES `carousel` WRITE;
/*!40000 ALTER TABLE `carousel` DISABLE KEYS */;
INSERT INTO `carousel` VALUES (1,'https://#{阿里云地址}aliyuncs.com/store_system/carousel/c1.jpg',NULL,0,1,'2023-06-17 00:00:55','2023-06-27 17:39:59'),(2,'https://#{阿里云地址}aliyuncs.com/store_system/carousel/c2.jpg',NULL,0,1,'2023-06-17 00:00:55','2023-06-27 17:39:59'),(3,'https://#{阿里云地址}aliyuncs.com/store_system/carousel/c3.jpg',NULL,0,1,'2023-06-17 00:00:55','2023-06-27 17:39:59');
/*!40000 ALTER TABLE `carousel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `category_id` int NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `category_name` char(20) NOT NULL COMMENT '分类名称',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除',
  `version` int NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='商品分类表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (1,'食用菌',0,1,'2023-06-16 10:28:09','2023-06-26 17:40:56'),(2,'蔬菜',0,1,'2023-06-26 17:40:56','2023-06-26 17:40:56'),(3,'水果',0,1,'2023-06-26 17:40:56','2023-06-26 17:40:56');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `collect`
--

DROP TABLE IF EXISTS `collect`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `collect` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '收藏ID',
  `user_id` int NOT NULL COMMENT '用户ID',
  `product_id` int NOT NULL COMMENT '商品ID',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除',
  `version` int NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`),
  KEY `FK_collect_id` (`product_id`),
  KEY `FK_collect_user_id` (`user_id`),
  CONSTRAINT `FK_collect_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `FK_collect_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='收藏表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `collect`
--

LOCK TABLES `collect` WRITE;
/*!40000 ALTER TABLE `collect` DISABLE KEYS */;
INSERT INTO `collect` VALUES (1,1,1,0,0,'2023-06-28 09:57:48','2023-06-28 09:57:48');
/*!40000 ALTER TABLE `collect` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discussion`
--

DROP TABLE IF EXISTS `discussion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discussion` (
  `discussion_id` bigint NOT NULL AUTO_INCREMENT COMMENT '讨论 ID',
  `discussion_content` text NOT NULL COMMENT '讨论内容',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除',
  `version` int NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `user_id` int NOT NULL COMMENT '用户ID',
  `product_id` int NOT NULL COMMENT '商品ID',
  PRIMARY KEY (`discussion_id`),
  KEY `FK_discussion_product_id` (`product_id`),
  KEY `FK_discussion_user_id` (`user_id`),
  CONSTRAINT `FK_discussion_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `FK_discussion_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='一级讨论表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discussion`
--

LOCK TABLES `discussion` WRITE;
/*!40000 ALTER TABLE `discussion` DISABLE KEYS */;
INSERT INTO `discussion` VALUES (3,'这是第1条父评论',0,1,'2023-06-29 09:58:56','2023-06-29 10:46:23',1,1),(6,'这是第2条父评论',0,1,'2023-06-29 10:46:23','2023-06-29 10:46:23',1,1),(7,'这是第3条父评论',0,1,'2023-06-29 10:46:23','2023-06-29 10:46:23',1,1),(8,'这是第4条父评论',0,1,'2023-06-29 10:46:23','2023-06-29 10:46:23',1,1),(9,'这是第5条父评论',0,1,'2023-06-29 10:46:23','2023-06-29 10:46:23',1,1),(10,'这是第6条父评论',0,1,'2023-06-29 10:46:23','2023-06-29 10:46:23',1,1),(11,'这是第7条父评论',0,1,'2023-06-29 10:46:23','2023-06-29 10:46:23',1,1),(12,'这是第8条父评论',0,1,'2023-06-29 10:46:24','2023-06-29 10:46:24',1,1),(13,'这是第9条父评论',0,1,'2023-06-29 10:46:24','2023-06-29 10:46:24',1,1),(14,'这是第10条父评论',0,1,'2023-06-29 10:46:24','2023-06-29 10:46:24',1,1),(15,'这是第11条父评论',0,1,'2023-06-29 10:46:24','2023-06-29 10:46:24',1,1),(16,'这是第12条父评论',0,1,'2023-06-29 10:46:24','2023-06-29 10:46:24',1,1),(17,'这是第13条父评论',0,1,'2023-06-29 10:46:24','2023-06-29 10:46:24',1,1),(18,'这是第14条父评论',0,1,'2023-06-29 10:46:24','2023-06-29 10:46:24',1,1),(19,'这是第15条父评论',0,1,'2023-06-29 10:46:24','2023-06-29 10:46:24',1,1),(20,'这是第16条父评论',0,1,'2023-06-29 10:46:24','2023-06-29 10:46:24',1,1),(21,'这是第17条父评论',0,1,'2023-06-29 10:46:24','2023-06-29 10:46:24',1,1),(22,'这是第18条父评论',0,1,'2023-06-29 10:46:24','2023-06-29 10:46:24',1,1),(23,'这是第19条父评论',0,1,'2023-06-29 10:46:24','2023-06-29 10:46:24',1,1),(24,'这是第20条父评论',0,1,'2023-06-29 10:46:24','2023-06-29 10:46:24',1,1);
/*!40000 ALTER TABLE `discussion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discussion_sub`
--

DROP TABLE IF EXISTS `discussion_sub`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `discussion_sub` (
  `discussion_sub_id` bigint NOT NULL AUTO_INCREMENT COMMENT '讨论 ID',
  `discussion_content` text NOT NULL COMMENT '讨论内容',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除',
  `version` int NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `user_id` int NOT NULL COMMENT '用户ID',
  `product_id` int NOT NULL COMMENT '商品ID',
  `parent_id` bigint NOT NULL COMMENT '关联一级评论的唯一标识',
  `touch_id` int NOT NULL COMMENT '@的人',
  PRIMARY KEY (`discussion_sub_id`),
  KEY `FK_discussion_sub_discussion_user_id` (`touch_id`),
  KEY `FK_discussion_sub_parent_id` (`parent_id`),
  KEY `FK_discussion_sub_product_id` (`product_id`),
  KEY `FK_discussion_sub_user_id` (`user_id`),
  CONSTRAINT `FK_discussion_sub_parent_id` FOREIGN KEY (`parent_id`) REFERENCES `discussion` (`discussion_id`),
  CONSTRAINT `FK_discussion_sub_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `FK_discussion_sub_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='二级讨论表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discussion_sub`
--

LOCK TABLES `discussion_sub` WRITE;
/*!40000 ALTER TABLE `discussion_sub` DISABLE KEYS */;
/*!40000 ALTER TABLE `discussion_sub` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `order_id` bigint NOT NULL COMMENT '唯一订单号',
  `user_id` int NOT NULL COMMENT '用户ID',
  `product_id` int NOT NULL COMMENT '商品ID',
  `product_num` int NOT NULL COMMENT '商品数量',
  `product_price` double NOT NULL COMMENT '商品单价',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除',
  `version` int NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `apply_method` tinyint NOT NULL COMMENT '0:微信, 1:支付宝, 2:银联',
  PRIMARY KEY (`id`),
  KEY `FK_order_id` (`product_id`),
  KEY `FK_order_user_id` (`user_id`),
  CONSTRAINT `FK_order_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `FK_order_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='订单表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (16,1611879751352322,1,1,1,23.78,0,0,'2023-06-29 10:43:30','2023-06-29 10:43:30',1),(17,1612841824026627,1,2,1,10.83,0,0,'2023-06-29 10:47:14','2023-06-29 10:47:14',1),(18,1613271320756228,1,2,1,10.83,0,0,'2023-06-29 10:48:54','2023-06-29 10:48:54',2),(19,1613271320756228,1,3,1,16.65,0,0,'2023-06-29 10:48:54','2023-06-29 10:48:54',2),(20,1613357220102149,1,4,1,24.99,0,0,'2023-06-29 10:49:14','2023-06-29 10:49:14',2),(21,1618631439941638,1,1,4,23.78,0,0,'2023-06-29 11:09:42','2023-06-29 11:09:42',1),(22,1620349426860033,1,2,1,10.83,0,0,'2023-06-29 11:16:23','2023-06-29 11:16:23',1),(23,1690185595092994,1,2,1,10.83,0,0,'2023-06-29 15:47:22','2023-06-29 15:47:22',2),(24,1690185595092994,1,1,1,23.78,0,0,'2023-06-29 15:47:22','2023-06-29 15:47:22',2),(25,1692006661226499,1,2,10,10.83,0,0,'2023-06-29 15:54:26','2023-06-29 15:54:26',2),(26,1692015251161092,1,2,10,10.83,0,0,'2023-06-29 15:54:28','2023-06-29 15:54:28',1),(27,1692036725997573,1,2,10,10.83,0,0,'2023-06-29 15:54:33','2023-06-29 15:54:33',0),(28,1702606640513030,1,2,1,10.83,0,0,'2023-06-29 16:35:34','2023-06-29 16:35:34',1),(29,1702606640513030,1,1,7,23.78,0,0,'2023-06-29 16:35:34','2023-06-29 16:35:34',1),(30,1702967417765895,1,2,1,10.83,0,0,'2023-06-29 16:36:58','2023-06-29 16:36:58',2),(31,1702967417765895,1,1,7,23.78,0,0,'2023-06-29 16:36:58','2023-06-29 16:36:58',2),(32,1714890246979592,1,2,1,10.83,0,0,'2023-06-29 17:23:15','2023-06-29 17:23:15',1);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `product_id` int NOT NULL AUTO_INCREMENT COMMENT '商品ID',
  `product_name` char(100) NOT NULL COMMENT '商品名称',
  `product_title` char(30) NOT NULL COMMENT '商品标题',
  `product_intro` text NOT NULL COMMENT '商品简介',
  `product_price` double NOT NULL COMMENT '商品标价',
  `product_num` int NOT NULL COMMENT '商品库存',
  `product_sales` int NOT NULL COMMENT '商品销量',
  `product_picture` char(200) DEFAULT NULL COMMENT '商品图片路径',
  `product_picture_desc` text COMMENT '商品图片描述',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除',
  `version` int NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `category_id` int NOT NULL COMMENT '分类ID',
  `product_selling_price` double DEFAULT NULL COMMENT '商品优惠价格',
  PRIMARY KEY (`product_id`),
  KEY `FK_product_category` (`category_id`),
  CONSTRAINT `FK_product_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='商品表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'白灵菇','title','白灵菇，又称白玉菇，是一种营养丰富的食用菌，具有柔软细滑的口',27,78,52,'https://#{阿里云地址}aliyuncs.com/store_system/product/b44b22eb4a8406bd1179c85d44b23677.jpg','白灵菇（封面）',1,1,'2023-06-26 14:32:39','2023-06-29 16:36:58',1,23.78),(2,'草菇','title','草菇是一种常见的食用菌，外形似伞状，帽面呈白色或浅棕色，质地',11,74,26,'https://#{阿里云地址}aliyuncs.com/store_system/product/e005f2973696b25de792627430c568d2.jpg','草菇（封面）',1,1,'2023-06-26 17:31:56','2023-06-29 17:23:15',1,10.83),(3,'虫草','title','虫草，又称冬虫夏草，是一种珍贵的中药材和滋补食品。它生长在蝉',19,77,97,'https://#{阿里云地址}aliyuncs.com/store_system/product/bb2cfd707479a6c10f3cee62613576aa.jpg','虫草（封面）',1,1,'2023-06-26 17:31:56','2023-06-29 10:48:54',1,16.65),(4,'红菇','title','红菇是一种菌类食物，外形红色，质地肉厚，口感鲜美。它富含蛋白',30,48,62,'https://#{阿里云地址}aliyuncs.com/store_system/product/dce1d6f82ac0c50072aeee1b59c74ce3.jpg','红菇（封面）',1,1,'2023-06-26 17:31:56','2023-06-29 10:49:14',1,24.99),(5,'蘑菇','title','蘑菇是一类多种多样的真菌类食材，包括香菇、平菇、秀珍菇等。蘑',17,59,44,'https://#{阿里云地址}aliyuncs.com/store_system/product/c3081227dba2ef1f19f9d1a8ecf69c7c.jpg','蘑菇（封面）',1,1,'2023-06-26 17:31:56','2023-06-28 12:55:27',1,15.38),(6,'木耳','title','木耳，又称黑木耳，是一种常见的菌类食材，质地柔软，口感有嚼劲',27,58,97,'https://#{阿里云地址}aliyuncs.com/store_system/product/6ab7efc0fd86e34875575316c3bb7455.jpg','木耳（封面）',1,1,'2023-06-26 17:31:56','2023-06-28 12:55:27',1,21.04),(7,'松茸','title','松茸是一种高级食用菌，具有浓郁的香气和鲜美的口感。它含有丰富',26,86,30,'https://#{阿里云地址}aliyuncs.com/store_system/product/401b49976f8e49ae3d10810e1920dc8c.jpg','松茸（封面）',1,1,'2023-06-26 17:31:56','2023-06-28 12:55:27',1,25.71),(8,'银耳','title','银耳是一种常见的食用真菌，外形圆盘状，质地柔软，口感爽滑。它',12,76,10,'https://#{阿里云地址}aliyuncs.com/store_system/product/2f47711328deb062ee2da754c61dd9e7.jpg','银耳（封面）',1,1,'2023-06-26 17:31:56','2023-06-28 12:55:27',1,10.12),(9,'菠菜','title','菠菜是一种绿叶蔬菜，富含维生素C、维生素K和多种矿物质。它具',21,85,68,'https://#{阿里云地址}aliyuncs.com/store_system/product/dfc271eeb375d121e4584eb024e514e7.jpg','菠菜（封面）',1,1,'2023-06-26 17:31:56','2023-06-28 12:55:27',2,16.66),(10,'茶树菇','title','茶树菇是一种特殊的食用菌，形状像茶叶，质地肉质鲜嫩，口感丰满',25,88,83,'https://#{阿里云地址}aliyuncs.com/store_system/product/36bfedd4e8643581cc11f64ebd2972c5.jpg','茶树菇（封面）',1,1,'2023-06-26 17:31:56','2023-06-28 12:55:27',2,22.62),(11,'大葱','title','大葱是一种常见的调味蔬菜，具有辛辣的气味和独特的味道。大葱富',36,72,64,'https://#{阿里云地址}aliyuncs.com/store_system/product/34a516182583522e4cb26a2ba6be78e9.jpg','大葱（封面）',1,1,'2023-06-26 17:31:57','2023-06-28 12:55:27',2,27.01),(12,'红薯','title','红薯，也称为甘薯，是一种根茎类植物，外皮颜色多为红色或紫色。',37,75,57,'https://#{阿里云地址}aliyuncs.com/store_system/product/4792c06d81860c9b1508de7815346452.jpg','红薯（封面）',1,1,'2023-06-26 17:31:57','2023-06-28 12:55:27',2,32.16),(13,'胡萝卜','title','胡萝卜是一种根茎类蔬菜，形状长圆，颜色通常为橙色。它富含胡萝',17,56,78,'https://#{阿里云地址}aliyuncs.com/store_system/product/492eb3a7e6a9264227d18ccdcbb1bf75.jpg','胡萝卜（封面）',1,1,'2023-06-26 17:31:57','2023-06-28 12:55:27',2,12.37),(14,'花菜','title','花菜，又称花椰菜，是一种蔬菜，形状像白色小花朵。它富含维生素',32,52,87,'https://#{阿里云地址}aliyuncs.com/store_system/product/59b6bf73cf68e884cd98120d9fa3bddb.jpg','花菜（封面）',1,1,'2023-06-26 17:31:57','2023-06-28 12:55:27',2,30.42),(15,'空心菜','title','空心菜是一种绿叶蔬菜，叶片中间有空隙，口感爽滑。它富含维生素',25,83,90,'https://#{阿里云地址}aliyuncs.com/store_system/product/f5522796ac474e5293ab6fffa7d8450a.jpg','空心菜（封面）',1,1,'2023-06-26 17:31:57','2023-06-28 12:55:27',2,22.75),(16,'莲藕','title','莲藕，也称荷藕，是莲花的茎部，外表呈棕黄色。它富含膳食纤维、',39,59,20,'https://#{阿里云地址}aliyuncs.com/store_system/product/e4b0c572dc25cc4abce0fa235b879473.jpg','莲藕（封面）',1,1,'2023-06-26 17:31:57','2023-06-28 12:55:27',2,37.03),(17,'龙须菜','title','龙须菜是一种海藻类食材，外形长而细软，质地韧嫩，富含蛋白质和',15,84,66,'https://#{阿里云地址}aliyuncs.com/store_system/product/0b8d790d468d50564e0dea88194671e3.jpg','龙须菜（封面）',1,1,'2023-06-26 17:31:57','2023-06-28 12:55:27',2,11.89),(18,'毛豆','title','毛豆是大豆的未成熟种子，外壳内有绒毛，颜色鲜绿。它富含优质蛋',19,65,77,'https://#{阿里云地址}aliyuncs.com/store_system/product/a578d2bdb11f8b016ce8d0436397c24f.jpg','毛豆（封面）',1,1,'2023-06-26 17:31:57','2023-06-28 12:55:27',2,15.27),(19,'芹菜','title','芹菜是一种蔬菜，具有清香的气味和脆嫩的口感。它富含膳食纤维、',26,77,57,'https://#{阿里云地址}aliyuncs.com/store_system/product/819e233a725575f3dcf988ea5ffca258.jpg','芹菜（封面）',1,1,'2023-06-26 17:31:57','2023-06-28 12:55:27',2,21.21),(20,'生姜','title','生姜是一种常见的调味品和草药，具有辛辣味和独特的香气。生姜被',29,73,26,'https://#{阿里云地址}aliyuncs.com/store_system/product/322e4314ce6d388b914b54341b72f077.jpg','生姜（封面）',1,1,'2023-06-26 17:31:57','2023-06-28 12:55:27',2,21.85),(21,'四季豆','title','四季豆，也称为刀豆或长豆，是一种蔬菜，形状细长，口感爽脆。它',13,69,61,'https://#{阿里云地址}aliyuncs.com/store_system/product/c579d39e7e6240f48ce557e662ee28a5.jpg','四季豆（封面）',1,1,'2023-06-26 17:31:57','2023-06-28 12:55:27',2,12.75),(22,'蒜','title','蒜是一种常见的调味品和草药，具有辛辣的气味和独特的味道。蒜具',10,58,56,'https://#{阿里云地址}aliyuncs.com/store_system/product/023d7c0c7b4d2c9e34d96418e68a7013.jpg','蒜（封面）',1,1,'2023-06-26 17:31:57','2023-06-28 12:55:27',2,7.53),(23,'土豆','title','土豆是一种主食蔬菜，富含淀粉、膳食纤维和多种维生素。土豆具有',34,52,77,'https://#{阿里云地址}aliyuncs.com/store_system/product/86e79f5d5b188326117f4c288e9ae279.jpg','土豆（封面）',1,1,'2023-06-26 17:31:57','2023-06-28 12:55:27',2,27.76),(24,'娃娃菜','title','娃娃菜，又称小油菜，是一种叶菜类蔬菜，味道清香，口感嫩滑。常用于炒菜、凉拌以及火锅等料理中。\r',36,83,23,'https://#{阿里云地址}aliyuncs.com/store_system/product/da9b4fedb210b09d98bc5db4bc755b45.jpg','娃娃菜（封面）',1,1,'2023-06-26 17:31:57','2023-06-28 13:03:37',2,29.45),(25,'西兰花','title','西兰花是一种十字花科蔬菜，花朵由多个绿色小花组成，口感紧实鲜嫩。常用于炒菜、蒸煮以及做沙拉等料理中。\r',19,98,16,'https://#{阿里云地址}aliyuncs.com/store_system/product/fab161dee41933a08c35446365cfc41f.jpg','西兰花（封面）',1,1,'2023-06-26 17:31:58','2023-06-28 13:03:37',2,13.92),(26,'香菇','title','香菇是一种菇类食材，具有鲜香的气味和独特的口感。常用于炒菜、烹饪以及作为汤的配料等。\r',26,51,28,'https://#{阿里云地址}aliyuncs.com/store_system/product/65d6e035e9eed2c94aa42ef0ea2d929b.jpg','香菇（封面）',1,1,'2023-06-26 17:31:58','2023-06-28 13:03:37',2,21),(27,'洋葱','title','洋葱是一种调味蔬菜，具有辛辣的气味和辣味。常用于炒菜、烹饪以及作为调味料等。\r',11,51,27,'https://#{阿里云地址}aliyuncs.com/store_system/product/2932b953d1d49cf51c0945b84b557594.jpg','洋葱（封面）',1,1,'2023-06-26 17:31:58','2023-06-28 13:03:37',2,8.38),(28,'油菜','title','油菜，又称芥蓝，是一种叶菜类蔬菜，嫩叶呈深绿色，口感嫩滑爽脆。常用于炒菜、凉拌以及作为火锅的配料等。\r',31,67,22,'https://#{阿里云地址}aliyuncs.com/store_system/product/6df8d0d5334f8225b80b6b1c510e83df.jpg','油菜（封面）',1,1,'2023-06-26 17:31:58','2023-06-28 13:03:37',2,24.11),(29,'菠萝','title','菠萝是一种热带水果，外表呈黄色，果肉酸甜多汁。常用于生食、制作果酱以及烹饪等。\r',11,85,35,'https://#{阿里云地址}aliyuncs.com/store_system/product/40c15d0bcd2482e48e56251d68e3bf1a.jpg','菠萝（封面）',1,1,'2023-06-26 17:31:58','2023-06-28 13:03:37',3,10.06),(30,'菠萝蜜','title','菠萝蜜是一种热带水果，外表呈绿色或黄色，果肉香甜且具有浓郁的香味。常用于生食、制作果汁以及烹饪等。\r',27,54,85,'https://#{阿里云地址}aliyuncs.com/store_system/product/4ca00d4c37fa69054ce97688ce6dc963.jpg','波罗蜜（封面）',1,1,'2023-06-26 17:31:58','2023-06-28 13:03:37',3,22.52),(31,'草莓','title','草莓是一种水果，外表呈鲜红色，味道酸甜微酸。常用于生食、制作甜点以及做果酱等。\r',40,87,53,'https://#{阿里云地址}aliyuncs.com/store_system/product/36b965e56954d54f0efacbc68d876914.jpg','草莓（封面）',1,1,'2023-06-26 17:31:58','2023-06-28 13:03:37',3,39.22),(32,'柑橘','title','柑橘是一种柑橘类水果，外表呈橙黄色，果肉多汁酸甜。常用于生食、制作果汁以及做糕点等。\r',10,78,10,'https://#{阿里云地址}aliyuncs.com/store_system/product/195129508ad4455c0810db1537ae0329.jpg','柑橘（封面）',1,1,'2023-06-26 17:31:58','2023-06-28 13:03:37',3,9.78),(33,'哈密瓜','title','哈密瓜是一种瓜果类水果，外表呈黄色或绿色，果肉细腻甜美。常用于生食、制作果汁以及制作冰品等。\r',38,97,41,'https://#{阿里云地址}aliyuncs.com/store_system/product/2d029996951832070cb589d28e3dedd3.jpg','哈密瓜（封面）',1,1,'2023-06-26 17:31:58','2023-06-28 13:03:37',3,30.05),(34,'火龙果','title','火龙果是一种热带水果，外表呈粉红色或黄色，果肉清爽多汁。常用于生食、制作果汁以及做凉拌等。\r',30,69,62,'https://#{阿里云地址}aliyuncs.com/store_system/product/9fb5613c14a53815c594a17f35c31a73.jpg','火龙果（封面）',1,1,'2023-06-26 17:31:58','2023-06-28 13:03:37',3,23.01),(35,'金桔','title','金桔是一种柑橘类水果，外表呈橙黄色，果实小而圆。常用于生食、制作果酱以及制作糕点等。\r',27,50,62,'https://#{阿里云地址}aliyuncs.com/store_system/product/4a155f987b37fd4ad58bf8dc4c1a3ee8.jpg','金桔（封面）',1,1,'2023-06-26 17:31:58','2023-06-28 13:03:37',3,20.08),(36,'蓝莓','title','蓝莓是一种浆果类水果，外表呈紫蓝色，味道酸甜可口。常用于生食、制作果酱以及做糕点等。\r',10,85,18,'https://#{阿里云地址}aliyuncs.com/store_system/product/47dff16e23b6aee99a8113140fc54117.jpg','蓝莓（封面）',1,1,'2023-06-26 17:31:58','2023-06-28 13:03:37',3,9.82),(37,'荔枝','title','荔枝是一种热带水果，外表呈红色或粉红色，果肉甜润多汁。常用于生食、制作果汁以及制作糕点等。\r',38,74,66,'https://#{阿里云地址}aliyuncs.com/store_system/product/51f38ab90c84389f0bd2a9258b237e55.jpg','荔枝（封面）',1,1,'2023-06-26 17:31:58','2023-06-28 13:03:37',3,31.79),(38,'榴莲','title','榴莲是一种热带水果，外表呈棕黄色，果肉香甜且具有浓郁的味道。常用于生食、制作果汁以及制作冰品等。\r',27,59,37,'https://#{阿里云地址}aliyuncs.com/store_system/product/75d705eabf26d266c71d72721ed085ba.jpg','榴莲（封面）',1,1,'2023-06-26 17:31:58','2023-06-28 13:03:37',3,22.6),(39,'芒果','title','芒果是一种热带水果，外表呈黄色或橙黄色，果肉香甜多汁。常用于生食、制作果汁以及制作甜点等。\r',15,62,26,'https://#{阿里云地址}aliyuncs.com/store_system/product/962aea8183e734c5774bc0a2cf031c09.jpg','芒果（封面）',1,1,'2023-06-26 17:31:58','2023-06-28 13:03:37',3,11.84),(40,'猕猴桃','title','猕猴桃是一种水果，外表呈褐色或绿色，果肉酸甜爽口。常用于生食、制作果汁以及做沙拉等。\r',34,97,74,'https://#{阿里云地址}aliyuncs.com/store_system/product/55a8f9a28718d592fe5d884478033fa7.jpg','猕猴桃（封面）',1,1,'2023-06-26 17:31:58','2023-06-28 13:03:37',3,32.86),(41,'蜜柚','title','毛豆是大豆的未成熟种子，外壳内有绒毛，颜色鲜绿。它富含优质蛋白质、纤维素和维生素K等，常用于蒸煮、炒菜、烤制等多种烹饪方式。\r',24,99,79,'https://#{阿里云地址}aliyuncs.com/store_system/product/8605a43ccf72788eec5facad2c789ded.jpg','蜜柚（封面）',1,1,'2023-06-26 17:31:58','2023-06-28 13:03:37',3,22.36),(42,'木瓜','title','芹菜是一种蔬菜，具有清香的气味和脆嫩的口感。它富含膳食纤维、维生素K和维生素C等，常用于凉拌、炒菜、炖汤等料理中。\r',15,80,66,'https://#{阿里云地址}aliyuncs.com/store_system/product/b5378c6ddbfdfb97041f8c5a50791f35.jpg','木瓜（封面）',1,1,'2023-06-26 17:31:58','2023-06-28 13:03:37',3,11.84),(43,'柠檬','title','生姜是一种常见的调味品和草药，具有辛辣味和独特的香气。生姜被广泛用于烹饪和料理中，可提鲜提味，也被认为有助于消化和增强免疫力。\r',30,91,95,'https://#{阿里云地址}aliyuncs.com/store_system/product/f5fe3eefa17f5b40db14a0f8acb6905c.jpg','柠檬（封面）',1,1,'2023-06-26 17:31:59','2023-06-28 13:03:37',3,24.14),(44,'苹果','title','四季豆，也称为刀豆或长豆，是一种蔬菜，形状细长，口感爽脆。它富含膳食纤维和多种维生素，常用于炒菜、凉拌和炖汤等料理中。\r',18,59,59,'https://#{阿里云地址}aliyuncs.com/store_system/product/a6cecca34216aa5d406cccb79f7eec5e.jpg','苹果（封面）',1,1,'2023-06-26 17:31:59','2023-06-28 13:03:37',3,17.33),(45,'葡萄','title','蒜是一种常见的调味品和草药，具有辛辣的气味和独特的味道。蒜具有抗菌、降血压、促进新陈代谢等多种功效，被广泛应用于各种烹饪中。\r',35,86,80,'https://#{阿里云地址}aliyuncs.com/store_system/product/29b7eec77aea73e5d42039d66970017e.jpg','葡萄（封面）',1,1,'2023-06-26 17:31:59','2023-06-28 13:03:37',3,27.15),(46,'石榴','title','土豆是一种主食蔬菜，富含淀粉、膳食纤维和多种维生素。土豆具有多样的烹饪方式，如煮、炒、炖、烤等，可制作成多种美食。',23,94,90,'https://#{阿里云地址}aliyuncs.com/store_system/product/b26b57570ee279e77e711922fcce28c8.jpg','石榴（封面）',1,1,'2023-06-26 17:31:59','2023-06-28 13:03:37',3,16.17),(47,'水蜜桃','title','水蜜桃是一种热带水果，外表呈粉红或黄色，果肉酸甜多汁。常用于生食、制作果汁以及制作甜点等。\r',32,86,71,'https://#{阿里云地址}aliyuncs.com/store_system/product/05462712c2559fa05d9c3a0595e2999a.jpg','水蜜桃（封面）',1,1,'2023-06-26 17:31:59','2023-06-28 13:05:02',3,26.72),(48,'西瓜','title','西瓜是一种夏季时节常见的水果，外表呈绿色，果肉甜润多汁。常用于生食、制作果汁以及制作冰品等。\r',37,78,21,'https://#{阿里云地址}aliyuncs.com/store_system/product/cf5df6eba365e0dee45189162048a895.jpg','西瓜（封面）',1,1,'2023-06-26 17:31:59','2023-06-28 13:05:02',3,36.29),(49,'香蕉','title','香蕉是一种常见的水果，果皮呈黄色，果肉细腻香甜。常用于生食、制作果汁以及烹饪等。\r',13,51,65,'https://#{阿里云地址}aliyuncs.com/store_system/product/130d3f91072531b4d78e467f9f8f9ec6.jpg','香蕉（封面）',1,1,'2023-06-26 17:31:59','2023-06-28 13:05:02',3,10.95),(50,'杏子','title','杏子是一种夏季水果，外表呈橙黄色，果肉酸甜多汁。常用于生食、制作果酱以及制作糕点等。\r',16,53,85,'https://#{阿里云地址}aliyuncs.com/store_system/product/c65f85eabee8577755507c52edbf3260.jpg','杏子（封面）',1,1,'2023-06-26 17:31:59','2023-06-28 13:05:02',3,11.39),(51,'杨梅','title','杨梅是一种小型果实的水果，外表呈红色或紫黑色，味道酸甜可口。常用于生食、制作果酱以及制作饮品等。\r',31,54,44,'https://#{阿里云地址}aliyuncs.com/store_system/product/915e5cd7d5ec1e2b7eb38b5b18fdb6a5.jpg','杨梅（封面）',1,1,'2023-06-26 17:31:59','2023-06-28 13:05:02',3,25.83),(52,'杨桃','title','杨桃是一种热带水果，外表呈黄色或绿色，果肉爽脆多汁。常用于生食、制作果汁以及制作沙拉等。\r',28,68,86,'https://#{阿里云地址}aliyuncs.com/store_system/product/312a7c953d3d406aef370ddf5b678e8b.jpg','杨桃（封面）',1,1,'2023-06-26 17:31:59','2023-06-28 13:05:02',3,22.48),(53,'椰子','title','椰子是一种热带水果，外表呈棕色，内含浓郁的椰汁和鲜嫩的果肉。常用于生食、制作果汁以及烹饪等。\r',18,56,63,'https://#{阿里云地址}aliyuncs.com/store_system/product/e86efa05a543836d7e82763f5cfcaa34.jpg','椰子（封面）',1,1,'2023-06-26 17:31:59','2023-06-28 13:05:02',3,14.54),(54,'樱桃','title','樱桃是一种小型果实的水果，外表呈红色或黄色，果肉酸甜多汁。常用于生食、制作果酱以及烹饪等。\r',23,83,17,'https://#{阿里云地址}aliyuncs.com/store_system/product/ae61ac33ad092ac085e9103cc0132b36.jpg','樱桃（封面）',1,1,'2023-06-26 17:31:59','2023-06-28 13:05:02',3,16.69);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_picture`
--

DROP TABLE IF EXISTS `product_picture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_picture` (
  `id` int NOT NULL AUTO_INCREMENT,
  `product_id` int NOT NULL,
  `product_picture` char(200) DEFAULT NULL,
  `intro` text,
  PRIMARY KEY (`id`),
  KEY `FK_product_id` (`product_id`),
  CONSTRAINT `FK_product_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=209 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_picture`
--

LOCK TABLES `product_picture` WRITE;
/*!40000 ALTER TABLE `product_picture` DISABLE KEYS */;
INSERT INTO `product_picture` VALUES (2,1,'https://#{阿里云地址}aliyuncs.com/store_system/product/00cb0403053cf95243676468fffbb128.jpg','白灵菇-1'),(3,1,'https://#{阿里云地址}aliyuncs.com/store_system/product/f8ed4640114f84d07173e75f2d9c0e38.jpg','白灵菇-2'),(4,1,'https://#{阿里云地址}aliyuncs.com/store_system/product/944cd1c1f7680b35af287df27527e667.jpg','白灵菇-3'),(5,1,'https://#{阿里云地址}aliyuncs.com/store_system/product/b825ee8f42e5e478979fcb034f42d332.jpg','白灵菇-4'),(10,2,'https://#{阿里云地址}aliyuncs.com/store_system/product/388c1235f18fab3b5f6c6bceb3c35056.jpg','草菇-1'),(11,2,'https://#{阿里云地址}aliyuncs.com/store_system/product/581047497bda55ca008d77a36a2724a0.jpg','草菇-2'),(12,2,'https://#{阿里云地址}aliyuncs.com/store_system/product/01d7dab909953682c3238e48ca30d435.jpg','草菇-3'),(13,2,'https://#{阿里云地址}aliyuncs.com/store_system/product/4d7d43f3c442b2c03499ea929fc48b9f.jpg','草菇-4'),(14,3,'https://#{阿里云地址}aliyuncs.com/store_system/product/21dde9ee874c3e73a0b16d1ad3c1e478.jpg','虫草-1'),(15,3,'https://#{阿里云地址}aliyuncs.com/store_system/product/994b4799680fed3a386aa603db78f2e2.jpg','虫草-2'),(16,3,'https://#{阿里云地址}aliyuncs.com/store_system/product/8c1879b3215f0d523c0952bf12eb9216.jpg','虫草-3'),(17,4,'https://#{阿里云地址}aliyuncs.com/store_system/product/403b926d69e6f0e5d8ead15c6f06f407.jpg','红菇-1'),(18,4,'https://#{阿里云地址}aliyuncs.com/store_system/product/4878fd71e2e352af32260fa3c44509c6.jpg','红菇-2'),(19,4,'https://#{阿里云地址}aliyuncs.com/store_system/product/828fb384a944f3e7128e14d8d7c4f152.jpg','红菇-3'),(20,5,'https://#{阿里云地址}aliyuncs.com/store_system/product/4afbd821440620db7dad12462bd32147.jpg','蘑菇-1'),(21,5,'https://#{阿里云地址}aliyuncs.com/store_system/product/d8be1065d2818a82bbeb4e140de8b885.jpg','蘑菇-2'),(22,5,'https://#{阿里云地址}aliyuncs.com/store_system/product/f21eb912d4fc98a5d530759211909513.jpg','蘑菇-3'),(23,5,'https://#{阿里云地址}aliyuncs.com/store_system/product/9c000b681ee39727bad74219a2427e09.jpg','蘑菇-4'),(24,6,'https://#{阿里云地址}aliyuncs.com/store_system/product/6f0f90083d285ec7e13832f3cb54bd13.jpg','木耳-1'),(25,6,'https://#{阿里云地址}aliyuncs.com/store_system/product/e4c0d4e87411ee9075b750d5b49dfedc.jpg','木耳-2'),(26,6,'https://#{阿里云地址}aliyuncs.com/store_system/product/4c036f60b894fddc4a26505349fb9867.jpg','木耳-3'),(27,6,'https://#{阿里云地址}aliyuncs.com/store_system/product/7196cdc933dae08d9c078352221ec523.jpg','木耳-4'),(28,7,'https://#{阿里云地址}aliyuncs.com/store_system/product/b51eeee7ee4a2790080c9b105f4b6a8a.jpg','松茸-1'),(29,7,'https://#{阿里云地址}aliyuncs.com/store_system/product/9ef3265d778bd16d90f735575a0d8818.jpg','松茸-2'),(30,7,'https://#{阿里云地址}aliyuncs.com/store_system/product/4a14afa02603c5fcc5f7da2e7a08d153.jpg','松茸-3'),(31,7,'https://#{阿里云地址}aliyuncs.com/store_system/product/2e67a61c2ed31a57ede7119fb9ba4e6e.jpg','松茸-4'),(32,8,'https://#{阿里云地址}aliyuncs.com/store_system/product/75ff9aed043f90e2a59c7cf562e3826f.jpg','银耳-1'),(33,8,'https://#{阿里云地址}aliyuncs.com/store_system/product/c811cfc40402ee661218e544ba146191.jpg','银耳-2'),(34,8,'https://#{阿里云地址}aliyuncs.com/store_system/product/d3f5881ac143595d255c7d68ff2e2f8b.jpg','银耳-3'),(35,8,'https://#{阿里云地址}aliyuncs.com/store_system/product/06e1e3b403feddb6b818ab4ca13db546.jpg','银耳-4'),(36,9,'https://#{阿里云地址}aliyuncs.com/store_system/product/f6607d24096daf84832212c08ba22226.jpg','菠菜-1'),(37,9,'https://#{阿里云地址}aliyuncs.com/store_system/product/f28db35e9a41afe3772642deb5a69199.jpg','菠菜-2'),(38,9,'https://#{阿里云地址}aliyuncs.com/store_system/product/ca2302015b87b68ad7f1262ec90d4f1a.jpg','菠菜-3'),(39,9,'https://#{阿里云地址}aliyuncs.com/store_system/product/d45679832ad4fa6df5ea2a3e305b7af4.jpg','菠菜-4'),(40,9,'https://#{阿里云地址}aliyuncs.com/store_system/product/d30c159c7a43f10871449de8e707f882.jpg','菠菜-5'),(41,10,'https://#{阿里云地址}aliyuncs.com/store_system/product/370d72c7b6b6b50d674ee7e9140d9813.jpg','茶树菇-1'),(42,10,'https://#{阿里云地址}aliyuncs.com/store_system/product/37e75e716f5e5a0788bb9903ffae148a.jpg','茶树菇-2'),(43,10,'https://#{阿里云地址}aliyuncs.com/store_system/product/5f3e5c3860b040655a11b06013bc3f29.jpg','茶树菇-3'),(44,10,'https://#{阿里云地址}aliyuncs.com/store_system/product/8562bfa9a299281ca8340e465c91f744.jpg','茶树菇-4'),(45,10,'https://#{阿里云地址}aliyuncs.com/store_system/product/5338d195d61101683a0472f2661f9a4b.jpg','茶树菇-5'),(46,11,'https://#{阿里云地址}aliyuncs.com/store_system/product/7651d63bf6d300fcb2f951c919e203d8.jpg','大葱-1'),(47,11,'https://#{阿里云地址}aliyuncs.com/store_system/product/6f93bda4293a7e32ddd18ed133bcf14c.jpg','大葱-2'),(48,11,'https://#{阿里云地址}aliyuncs.com/store_system/product/fd1c0af760072b3fa710b663f49b6f84.jpg','大葱-3'),(49,11,'https://#{阿里云地址}aliyuncs.com/store_system/product/215873d2fbb8a2520b7d9dd05e7f0f4d.jpg','大葱-4'),(50,12,'https://#{阿里云地址}aliyuncs.com/store_system/product/19b2b81f65ac62dc958d6f0a167a1872.jpg','红薯-1'),(51,12,'https://#{阿里云地址}aliyuncs.com/store_system/product/51690c59419a24ea2f360c3220fa5fd0.jpg','红薯-2'),(52,12,'https://#{阿里云地址}aliyuncs.com/store_system/product/fa7110c8f07a21d6cef5c16989bafe93.jpg','红薯-3'),(53,12,'https://#{阿里云地址}aliyuncs.com/store_system/product/270ee6bbe326a71d170e8e3a7e77c0de.jpg','红薯-4'),(54,13,'https://#{阿里云地址}aliyuncs.com/store_system/product/a38121c2c7e0a372f772a465125f6d05.jpg','胡萝卜-1'),(55,13,'https://#{阿里云地址}aliyuncs.com/store_system/product/1db3974091bb7f0c4211269873d869ca.jpg','胡萝卜-2'),(56,13,'https://#{阿里云地址}aliyuncs.com/store_system/product/c7dc458d8d3b3091a7c98a6939e2f691.jpg','胡萝卜-3'),(57,13,'https://#{阿里云地址}aliyuncs.com/store_system/product/60905a00e78981a030e29b032862e5d8.jpg','胡萝卜-4'),(58,14,'https://#{阿里云地址}aliyuncs.com/store_system/product/e02dcf58c1dcb784000032da50395ce5.jpg','花菜-1'),(59,14,'https://#{阿里云地址}aliyuncs.com/store_system/product/e76e6dd7a7344108f05837b085728f96.jpg','花菜-2'),(60,14,'https://#{阿里云地址}aliyuncs.com/store_system/product/65c52b76c0c0ca3d90368c393e9d683e.jpg','花菜-3'),(61,14,'https://#{阿里云地址}aliyuncs.com/store_system/product/e81c4b49976dbe9ea7ab68917c258bff.jpg','花菜-4'),(62,15,'https://#{阿里云地址}aliyuncs.com/store_system/product/50a1a2e5772cbbd4bb952ec9089ee750.jpg','空心菜-1'),(63,15,'https://#{阿里云地址}aliyuncs.com/store_system/product/f894c502eec7d5e0805decc0a4c0d16d.jpg','空心菜-2'),(64,15,'https://#{阿里云地址}aliyuncs.com/store_system/product/dbe6944d5e7c31d74ec3a7e1e84b53df.jpg','空心菜-3'),(65,15,'https://#{阿里云地址}aliyuncs.com/store_system/product/de5fa37e126dce79fe1805cf62fa966f.jpg','空心菜-4'),(66,16,'https://#{阿里云地址}aliyuncs.com/store_system/product/53670c686b41f5352c5f23ddf3ce6f01.jpg','莲藕-1'),(67,16,'https://#{阿里云地址}aliyuncs.com/store_system/product/383ffab8806a19fc10aa9dc6bcd78eb1.jpg','莲藕-2'),(68,16,'https://#{阿里云地址}aliyuncs.com/store_system/product/32c4ea672aabdecb7788d5dabdc74a96.jpg','莲藕-3'),(69,16,'https://#{阿里云地址}aliyuncs.com/store_system/product/0da4d9923255658d458f40729bda8a4c.jpg','莲藕-4'),(70,17,'https://#{阿里云地址}aliyuncs.com/store_system/product/0ee5d147fed1660037cfe1dd70e7d8e2.jpg','龙须菜-1'),(71,17,'https://#{阿里云地址}aliyuncs.com/store_system/product/b85a3404dc877fca9f797f4892a64350.jpg','龙须菜-2'),(72,17,'https://#{阿里云地址}aliyuncs.com/store_system/product/a7c156acc07dcfc896ff4b625a7e76b9.jpg','龙须菜-3'),(73,17,'https://#{阿里云地址}aliyuncs.com/store_system/product/43a0de8eb829fdcb3702ef2bb795ed0b.jpg','龙须菜-4'),(74,18,'https://#{阿里云地址}aliyuncs.com/store_system/product/59492ee69698a4e6faec2747e8d2226f.jpg','毛豆-1'),(75,18,'https://#{阿里云地址}aliyuncs.com/store_system/product/c763d4d941bd545e4407aaaa99d84388.jpg','毛豆-2'),(76,18,'https://#{阿里云地址}aliyuncs.com/store_system/product/36aa0590f610888566e7d043db7ad3bd.jpg','毛豆-3'),(77,18,'https://#{阿里云地址}aliyuncs.com/store_system/product/5acf319fe09bf9a02470ac4b189ac4c5.jpg','毛豆-4'),(78,18,'https://#{阿里云地址}aliyuncs.com/store_system/product/621a61acedf505fdc71f80134396fd21.jpg','毛豆-5'),(79,19,'https://#{阿里云地址}aliyuncs.com/store_system/product/44b4765992de719ed7322101c03445e1.jpg','芹菜-1'),(80,19,'https://#{阿里云地址}aliyuncs.com/store_system/product/1957a43ba7bc98edc9d73a6f22036d99.jpg','芹菜-2'),(81,19,'https://#{阿里云地址}aliyuncs.com/store_system/product/15b9b0cba813cd84361dd7bcbf7ff589.jpg','芹菜-3'),(82,19,'https://#{阿里云地址}aliyuncs.com/store_system/product/9faf691a3d2a2f29c9db70d5dcc5924e.jpg','芹菜-4'),(83,20,'https://#{阿里云地址}aliyuncs.com/store_system/product/fcd3087a5bee4c8a62095700ead141ac.jpg','生姜-1'),(84,20,'https://#{阿里云地址}aliyuncs.com/store_system/product/fd508164236ccf086b6ce0d625a26372.jpg','生姜-2'),(85,20,'https://#{阿里云地址}aliyuncs.com/store_system/product/524e296138d50200adc412d2544c7405.jpg','生姜-3'),(86,21,'https://#{阿里云地址}aliyuncs.com/store_system/product/72b50bd04359608aa786b1fdfadc5d4e.jpg','四季豆-1'),(87,21,'https://#{阿里云地址}aliyuncs.com/store_system/product/400c356d9bf790e4cf0a73840f044f15.jpg','四季豆-2'),(88,21,'https://#{阿里云地址}aliyuncs.com/store_system/product/06ba7f45759cb360c50a4025d762ddbb.jpg','四季豆-3'),(89,21,'https://#{阿里云地址}aliyuncs.com/store_system/product/03ce13c4ca881d3d7a100bb8663f1577.jpg','四季豆-4'),(90,22,'https://#{阿里云地址}aliyuncs.com/store_system/product/bd2b8a8264338115f29bec0816af742c.jpg','蒜-1'),(91,22,'https://#{阿里云地址}aliyuncs.com/store_system/product/be64a8bc52d58e6b3df50c3e7d37cfdd.jpg','蒜-2'),(92,22,'https://#{阿里云地址}aliyuncs.com/store_system/product/00147e9e210a2686cc3ada35d2c865d4.jpg','蒜-3'),(93,22,'https://#{阿里云地址}aliyuncs.com/store_system/product/06653305c855c200936dc7e18cce4cc4.jpg','蒜-4'),(94,23,'https://#{阿里云地址}aliyuncs.com/store_system/product/d2edb955d09a579ca85dbb422e9f4635.jpg','土豆-1'),(95,23,'https://#{阿里云地址}aliyuncs.com/store_system/product/8a2d7187929ba7f574d7f8223424b56b.jpg','土豆-2'),(96,23,'https://#{阿里云地址}aliyuncs.com/store_system/product/790ed9a6a55964aec9a6b651f769546c.jpg','土豆-3'),(97,24,'https://#{阿里云地址}aliyuncs.com/store_system/product/5291632cdb8367105f800048acf5df9c.jpg','娃娃菜-1'),(98,24,'https://#{阿里云地址}aliyuncs.com/store_system/product/8f5f297ed6122fdb148a78198d591b11.jpg','娃娃菜-2'),(99,24,'https://#{阿里云地址}aliyuncs.com/store_system/product/dbf902ce51f18c5e5e7c2e2757b70c2c.jpg','娃娃菜-3'),(100,25,'https://#{阿里云地址}aliyuncs.com/store_system/product/8ad53c44f5caa569f23b592a55cdad9c.jpg','西兰花-1'),(101,25,'https://#{阿里云地址}aliyuncs.com/store_system/product/0c067516fd149d7e5f38539dc32c504b.jpg','西兰花-2'),(102,25,'https://#{阿里云地址}aliyuncs.com/store_system/product/9f4021710ec015f610014610cefc996b.jpg','西兰花-3'),(103,25,'https://#{阿里云地址}aliyuncs.com/store_system/product/e6b15ba6143255fce04b8b162a0419bb.jpg','西兰花-4'),(104,25,'https://#{阿里云地址}aliyuncs.com/store_system/product/7d8ac6b4850e1cf73b994bfc6d00bf33.jpg','西兰花-5'),(105,26,'https://#{阿里云地址}aliyuncs.com/store_system/product/b491603addc25b05edff82f1bbf76fec.jpg','香菇-1'),(106,26,'https://#{阿里云地址}aliyuncs.com/store_system/product/6fc6e6e88d1ff841eb8655cbb69e78cb.jpg','香菇-2'),(107,26,'https://#{阿里云地址}aliyuncs.com/store_system/product/b2f8feefa05828491c34711546488212.jpg','香菇-3'),(108,26,'https://#{阿里云地址}aliyuncs.com/store_system/product/cb98cfb99e1227baaf1128fcf19f6c85.jpg','香菇-4'),(109,27,'https://#{阿里云地址}aliyuncs.com/store_system/product/40351dc7844de9e8fdbbe760a266fab3.jpg','洋葱-1'),(110,27,'https://#{阿里云地址}aliyuncs.com/store_system/product/fcd410438d3698f7db13fb5fa3bfc475.jpg','洋葱-2'),(111,27,'https://#{阿里云地址}aliyuncs.com/store_system/product/ffb233bd00e902b691a3b8ca251e0786.jpg','洋葱-3'),(112,28,'https://#{阿里云地址}aliyuncs.com/store_system/product/42cdd8afc2218c9077d0352201bdaa01.jpg','油菜-1'),(113,28,'https://#{阿里云地址}aliyuncs.com/store_system/product/66b8017c9055c070c53127c607a3e147.jpg','油菜-2'),(114,28,'https://#{阿里云地址}aliyuncs.com/store_system/product/65259ad4811f48b9db846c1aa3dab4bd.jpg','油菜-3'),(115,28,'https://#{阿里云地址}aliyuncs.com/store_system/product/71fa71f29e4ecfc6dc16e6fda2b5cce2.jpg','油菜-4'),(116,29,'https://#{阿里云地址}aliyuncs.com/store_system/product/6de028dbfd17db861d42e791352dcdf5.jpg','菠萝-1'),(117,29,'https://#{阿里云地址}aliyuncs.com/store_system/product/97bcb04a3244f4354455c4ef0e44fdce.jpg','菠萝-2'),(118,29,'https://#{阿里云地址}aliyuncs.com/store_system/product/463031866e2cd7d3875dce7e68e13c38.jpg','菠萝-3'),(119,30,'https://#{阿里云地址}aliyuncs.com/store_system/product/723b6e88ebad3f6556292aaa00595dbe.jpg','波罗蜜-1'),(120,30,'https://#{阿里云地址}aliyuncs.com/store_system/product/4ce048f731104f61f6d968a8db6397d7.jpg','波罗蜜-2'),(121,30,'https://#{阿里云地址}aliyuncs.com/store_system/product/109c1ec5e489e13a76addbf5d26336d1.jpg','波罗蜜-3'),(122,30,'https://#{阿里云地址}aliyuncs.com/store_system/product/5523fadd533888a9e7d2bb1a75d69e39.jpg','波罗蜜-4'),(123,31,'https://#{阿里云地址}aliyuncs.com/store_system/product/8d3b5ff18c810d7fa62a9df92ffe7337.jpg','草莓-1'),(124,31,'https://#{阿里云地址}aliyuncs.com/store_system/product/b8d78c8e1dcdeaebb6df385eae6feb6a.jpg','草莓-2'),(125,31,'https://#{阿里云地址}aliyuncs.com/store_system/product/11631f4e08bca0af88b6da0ad1faff1c.jpg','草莓-3'),(126,31,'https://#{阿里云地址}aliyuncs.com/store_system/product/b447ccca8ed20ab78072cb85bfc57adb.jpg','草莓-4'),(127,32,'https://#{阿里云地址}aliyuncs.com/store_system/product/e0809b8024131315dd0a81d37da0c194.jpg','柑橘-1'),(128,32,'https://#{阿里云地址}aliyuncs.com/store_system/product/57a721972af3223b5c454524dff6c6a3.jpg','柑橘-2'),(129,32,'https://#{阿里云地址}aliyuncs.com/store_system/product/b22067cee5f9356cc85ab2e751d20f7e.jpg','柑橘-3'),(130,32,'https://#{阿里云地址}aliyuncs.com/store_system/product/ab8c58568b5d4ed8d16a2f4ad9723962.jpg','柑橘-4'),(131,33,'https://#{阿里云地址}aliyuncs.com/store_system/product/3dfe1cfd9fc375e3145267644118fe6b.jpg','哈密瓜-1'),(132,33,'https://#{阿里云地址}aliyuncs.com/store_system/product/ef454277f108ebdc106f98258b735609.jpg','哈密瓜-2'),(133,33,'https://#{阿里云地址}aliyuncs.com/store_system/product/170c65dcb7d74491e313a0b765ddf486.jpg','哈密瓜-3'),(134,33,'https://#{阿里云地址}aliyuncs.com/store_system/product/009087e3f561d36234cf78d9a8282628.jpg','哈密瓜-4'),(135,34,'https://#{阿里云地址}aliyuncs.com/store_system/product/3fb0aca0d73950550b9768b60f1f5b14.jpg','火龙果-1'),(136,34,'https://#{阿里云地址}aliyuncs.com/store_system/product/e06b47f1aaaa39b2a129ae4e5e328f49.jpg','火龙果-2'),(137,34,'https://#{阿里云地址}aliyuncs.com/store_system/product/9771dd811d755cf954840cfd5c6ea050.jpg','火龙果-3'),(138,34,'https://#{阿里云地址}aliyuncs.com/store_system/product/0fad5e234929e26a162a460d63a84b4c.jpg','火龙果-4'),(139,35,'https://#{阿里云地址}aliyuncs.com/store_system/product/ee606cf51f9226be507cc41ddb57d686.jpg','金桔-1'),(140,35,'https://#{阿里云地址}aliyuncs.com/store_system/product/368e73677ef67e0891b5ed21782f1497.jpg','金桔-2'),(141,35,'https://#{阿里云地址}aliyuncs.com/store_system/product/2005367da3cddf2c1682afc7c4b45ac4.jpg','金桔-3'),(142,36,'https://#{阿里云地址}aliyuncs.com/store_system/product/83b89aaf122d9101a41795d6e819069f.jpg','蓝莓-1'),(143,36,'https://#{阿里云地址}aliyuncs.com/store_system/product/85f5ffd18607ac57af6fb02360925914.jpg','蓝莓-2'),(144,36,'https://#{阿里云地址}aliyuncs.com/store_system/product/bf74c0f0ca03f4333a6c1317b70a13ec.jpg','蓝莓-3'),(145,37,'https://#{阿里云地址}aliyuncs.com/store_system/product/a7f7679745cbf9bc6b4a165c87efc5bc.jpg','荔枝-1'),(146,37,'https://#{阿里云地址}aliyuncs.com/store_system/product/fc24f9794522ea0bae26076d19bdee65.jpg','荔枝-2'),(147,37,'https://#{阿里云地址}aliyuncs.com/store_system/product/cba54ba085948202ae38179533a9527a.jpg','荔枝-3'),(148,38,'https://#{阿里云地址}aliyuncs.com/store_system/product/93a2a16e0d0c9bd66f32c56c440ad796.jpg','榴莲-1'),(149,38,'https://#{阿里云地址}aliyuncs.com/store_system/product/565d55b116f63367d821f254116f191d.jpg','榴莲-2'),(150,38,'https://#{阿里云地址}aliyuncs.com/store_system/product/f375ecb8c97ac328d0a5fb51fea8b773.jpg','榴莲-3'),(151,39,'https://#{阿里云地址}aliyuncs.com/store_system/product/94a620c4509beba104c2b1f9bda08902.jpg','芒果-1'),(152,39,'https://#{阿里云地址}aliyuncs.com/store_system/product/9818c959ea9533eb548c392657543f02.jpg','芒果-2'),(153,39,'https://#{阿里云地址}aliyuncs.com/store_system/product/5105a49ef5b0ee38fa0f7653e8da6834.jpg','芒果-3'),(154,40,'https://#{阿里云地址}aliyuncs.com/store_system/product/1e1f63b21f249183a17fa87d8165c57e.jpg','猕猴桃-1'),(155,40,'https://#{阿里云地址}aliyuncs.com/store_system/product/a5de112e9c30017de1ac73ba77984eab.jpg','猕猴桃-2'),(156,40,'https://#{阿里云地址}aliyuncs.com/store_system/product/5918a64bf095f5025e10413cc34a24a9.jpg','猕猴桃-3'),(157,40,'https://#{阿里云地址}aliyuncs.com/store_system/product/efcaa3b70e54953ca7b5f62c69f4b5fe.jpg','猕猴桃-4'),(158,41,'https://#{阿里云地址}aliyuncs.com/store_system/product/300e957aaca361ceb3ae2504dc06c7fe.jpg','蜜柚-1'),(159,41,'https://#{阿里云地址}aliyuncs.com/store_system/product/163f3145308c0380b54493752dbf634d.jpg','蜜柚-2'),(160,41,'https://#{阿里云地址}aliyuncs.com/store_system/product/f0ba183aa9c3af423c125cd609eda99b.jpg','蜜柚-3'),(161,41,'https://#{阿里云地址}aliyuncs.com/store_system/product/22035ec470238770ca969fce9b2149ee.jpg','蜜柚-4'),(162,42,'https://#{阿里云地址}aliyuncs.com/store_system/product/64413152e494b70443e79c8a51083c37.jpg','木瓜-1'),(163,42,'https://#{阿里云地址}aliyuncs.com/store_system/product/47865ea059f35a4bfb0511344ecdbcb5.jpg','木瓜-2'),(164,42,'https://#{阿里云地址}aliyuncs.com/store_system/product/75d1c1bd0fe51df96166f39859f0ca07.jpg','木瓜-3'),(165,43,'https://#{阿里云地址}aliyuncs.com/store_system/product/6c299d31f0812d1ae5a1ef9a985c763a.jpg','柠檬-1'),(166,43,'https://#{阿里云地址}aliyuncs.com/store_system/product/a85a45b1da28df3584b122d8fbc85d7b.jpg','柠檬-2'),(167,43,'https://#{阿里云地址}aliyuncs.com/store_system/product/37803f8b86d752dcf05efc6caee2d1df.jpg','柠檬-3'),(168,43,'https://#{阿里云地址}aliyuncs.com/store_system/product/1b5c02c2a84f7e093ee3b7a887ff38dd.jpg','柠檬-4'),(169,44,'https://#{阿里云地址}aliyuncs.com/store_system/product/43e7fa3221986cc93093673213a03fea.jpg','苹果-1'),(170,44,'https://#{阿里云地址}aliyuncs.com/store_system/product/25738945b7dc70cc89b8c24ab1b0bb29.jpg','苹果-2'),(171,44,'https://#{阿里云地址}aliyuncs.com/store_system/product/d52327c6440bc456db5b8375eeeb5bbf.jpg','苹果-3'),(172,45,'https://#{阿里云地址}aliyuncs.com/store_system/product/f7e7b4566e552432d2640b421ff7d5ec.jpg','葡萄-1'),(173,45,'https://#{阿里云地址}aliyuncs.com/store_system/product/86ae79cff97cc22aa9f81085fa2346a9.jpg','葡萄-2'),(174,45,'https://#{阿里云地址}aliyuncs.com/store_system/product/64a5f65dfe1a59ae7938dcf4065a7a0d.jpg','葡萄-3'),(175,45,'https://#{阿里云地址}aliyuncs.com/store_system/product/b9c054e4cee2847bc0ef89c0ac5b957f.jpg','葡萄-4'),(176,46,'https://#{阿里云地址}aliyuncs.com/store_system/product/ac6317df8b45bf4e94315f333a6c0a12.jpg','石榴-1'),(177,46,'https://#{阿里云地址}aliyuncs.com/store_system/product/83d5637b8c21d559aa436cf6b789a37c.jpg','石榴-2'),(178,46,'https://#{阿里云地址}aliyuncs.com/store_system/product/a23922d21d926ba9556a429ae929cfe2.jpg','石榴-3'),(179,47,'https://#{阿里云地址}aliyuncs.com/store_system/product/6d2b9714dd4b27f941752a5983d0061c.jpg','水蜜桃-1'),(180,47,'https://#{阿里云地址}aliyuncs.com/store_system/product/f6dd1c8966480bd5d9ca3ff3cd79ba4b.jpg','水蜜桃-2'),(181,47,'https://#{阿里云地址}aliyuncs.com/store_system/product/97e88270564e3da311c5f9f32cce16ee.jpg','水蜜桃-3'),(182,48,'https://#{阿里云地址}aliyuncs.com/store_system/product/ade239d4ecf3558194b091e04a49e95a.jpg','西瓜-1'),(183,48,'https://#{阿里云地址}aliyuncs.com/store_system/product/727dc9d1f3dae8da75a97f553111aa6f.jpg','西瓜-2'),(184,48,'https://#{阿里云地址}aliyuncs.com/store_system/product/f71ccf49c919add61b345117865d0639.jpg','西瓜-3'),(185,48,'https://#{阿里云地址}aliyuncs.com/store_system/product/2d32516394c387d215413cdb96e10cea.jpg','西瓜-4'),(186,49,'https://#{阿里云地址}aliyuncs.com/store_system/product/5188751c9200e0458689696f1e1397cb.jpg','香蕉-1'),(187,49,'https://#{阿里云地址}aliyuncs.com/store_system/product/2da4a4bb1b567813da8cfdac72154336.jpg','香蕉-2'),(188,49,'https://#{阿里云地址}aliyuncs.com/store_system/product/0425dbe79816db506cad05133c5e861c.jpg','香蕉-3'),(189,49,'https://#{阿里云地址}aliyuncs.com/store_system/product/4cca95317fc4864c89621972310075d2.jpg','香蕉-4'),(190,50,'https://#{阿里云地址}aliyuncs.com/store_system/product/419b14230c982b4c4670c87125d99407.jpg','杏子-1'),(191,50,'https://#{阿里云地址}aliyuncs.com/store_system/product/94a31f23914adba32b411264bd9ad3e3.jpg','杏子-2'),(192,50,'https://#{阿里云地址}aliyuncs.com/store_system/product/7318be5c6567e7bd341da32bd417647a.jpg','杏子-3'),(193,50,'https://#{阿里云地址}aliyuncs.com/store_system/product/3d137d8f17a7da52a3547362b75a5902.jpg','杏子-4'),(194,51,'https://#{阿里云地址}aliyuncs.com/store_system/product/d49e7511bb2769e78824f9e91089d3f6.jpg','杨梅-1'),(195,51,'https://#{阿里云地址}aliyuncs.com/store_system/product/fc1c32363ab3e564758fe9cb0ff32fc5.jpg','杨梅-2'),(196,51,'https://#{阿里云地址}aliyuncs.com/store_system/product/24ea5c3d3a42bdb1cd5a060498a8648d.jpg','杨梅-3'),(197,51,'https://#{阿里云地址}aliyuncs.com/store_system/product/29bac54d6301f1c1c1f06b0965c5ab30.jpg','杨梅-4'),(198,52,'https://#{阿里云地址}aliyuncs.com/store_system/product/78a77ca0c59ae7f51cfd48e8aa8676ec.jpg','杨桃-1'),(199,52,'https://#{阿里云地址}aliyuncs.com/store_system/product/4369614bf89b5a60f5f05eb31d471fe0.jpg','杨桃-2'),(200,52,'https://#{阿里云地址}aliyuncs.com/store_system/product/fcb366d2b0a5c0abf401de3fd7c9c41c.jpg','杨桃-3'),(201,53,'https://#{阿里云地址}aliyuncs.com/store_system/product/b9b8957ae6db7fba67866425b66c8df5.jpg','椰子-1'),(202,53,'https://#{阿里云地址}aliyuncs.com/store_system/product/3873b0666a302c9058a690aaf6338f60.jpg','椰子-2'),(203,53,'https://#{阿里云地址}aliyuncs.com/store_system/product/f79c43d81468e9a1d3509a12275ec90a.jpg','椰子-3'),(204,53,'https://#{阿里云地址}aliyuncs.com/store_system/product/62915c80a3e97823652bb6898c645bd5.jpg','椰子-4'),(205,54,'https://#{阿里云地址}aliyuncs.com/store_system/product/752c41a9e2e42dfb81294afc0d194e8b.jpg','樱桃-1'),(206,54,'https://#{阿里云地址}aliyuncs.com/store_system/product/0e24615ebcb752328facb4986799b69c.jpg','樱桃-2'),(207,54,'https://#{阿里云地址}aliyuncs.com/store_system/product/d96da256d03e4d2d1e2f79334d5589b4.jpg','樱桃-3'),(208,54,'https://#{阿里云地址}aliyuncs.com/store_system/product/095d194bdabe098ae26cf0b3ad1835ba.jpg','樱桃-4');
/*!40000 ALTER TABLE `product_picture` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shopping_cart`
--

DROP TABLE IF EXISTS `shopping_cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `shopping_cart` (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '购物车ID',
  `user_id` int NOT NULL COMMENT '用户ID',
  `product_id` int NOT NULL COMMENT '商品ID',
  `num` int NOT NULL COMMENT '商品数量',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除',
  `version` int NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `checked` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否被选中',
  PRIMARY KEY (`id`),
  KEY `FK_shoppingCart_id` (`product_id`),
  KEY `FK_user_id` (`user_id`),
  CONSTRAINT `FK_shoppingCart_id` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  CONSTRAINT `FK_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='购物车表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shopping_cart`
--

LOCK TABLES `shopping_cart` WRITE;
/*!40000 ALTER TABLE `shopping_cart` DISABLE KEYS */;
INSERT INTO `shopping_cart` VALUES (33,1,1,9,0,0,'2023-06-29 17:55:01','2023-06-29 17:55:23',0);
/*!40000 ALTER TABLE `shopping_cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user_name` char(40) NOT NULL COMMENT '用户名',
  `password` char(40) DEFAULT NULL COMMENT '密码',
  `telephone` char(11) DEFAULT NULL COMMENT '电话号码',
  `deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除',
  `version` int NOT NULL DEFAULT '1' COMMENT '乐观锁版本号',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `user_img` varchar(200) DEFAULT 'https://#{阿里云地址}aliyuncs.com/store_system/user/a4d31c15e9d3282a39b4b38db83f3537.jpg',
  `viper` tinyint NOT NULL DEFAULT '0' COMMENT '会员',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`user_name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'zhangsan','asd123','13832922223',0,0,'2023-06-15 22:54:43','2023-06-29 16:38:27','https://#{阿里云地址}aliyuncs.com/store_system/user/7802a07bf3beaf01760bb6e1bc79c29c.jpg',1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voucher`
--

DROP TABLE IF EXISTS `voucher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `voucher` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) COLLATE utf8mb4_general_ci NOT NULL COMMENT '代金券标题',
  `sub_title` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '副标题',
  `rules` varchar(1024) COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '使用规则',
  `pay_value` double NOT NULL COMMENT '支付金额',
  `actual_value` double NOT NULL COMMENT '抵扣金额',
  `status` tinyint unsigned NOT NULL DEFAULT '1' COMMENT '1,上架; 2,下架; 3,过期',
  `stock` int NOT NULL COMMENT '库存',
  `begin_time` timestamp NOT NULL COMMENT '生效时间',
  `end_time` timestamp NOT NULL COMMENT '失效时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voucher`
--

LOCK TABLES `voucher` WRITE;
/*!40000 ALTER TABLE `voucher` DISABLE KEYS */;
INSERT INTO `voucher` VALUES (1,'优惠券1','优惠券','规则',99,10,1,99,'2023-06-25 06:22:39','2023-06-30 06:22:39','2023-06-29 16:40:16','2023-06-29 17:46:20');
/*!40000 ALTER TABLE `voucher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voucher_order`
--

DROP TABLE IF EXISTS `voucher_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `voucher_order` (
  `id` bigint NOT NULL COMMENT '主键',
  `user_id` int NOT NULL COMMENT '下单的用户id',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '下单时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `use_time` timestamp NULL DEFAULT NULL COMMENT '使用时间',
  `order_id` bigint DEFAULT NULL COMMENT '哪个订单使用的',
  `voucher_id` bigint NOT NULL COMMENT '优惠券ID',
  `discounts` mediumtext COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=COMPACT;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voucher_order`
--

LOCK TABLES `voucher_order` WRITE;
/*!40000 ALTER TABLE `voucher_order` DISABLE KEYS */;
INSERT INTO `voucher_order` VALUES (1720843071651850,1,'2023-06-29 09:46:20','2023-06-29 09:46:20',NULL,NULL,1,'10');
/*!40000 ALTER TABLE `voucher_order` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-29 18:16:52
