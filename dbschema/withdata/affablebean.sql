/*
Navicat MySQL Data Transfer

Source Server         : Local MySQL
Source Server Version : 50711
Source Host           : localhost:3306
Source Database       : affablebean

Target Server Type    : MYSQL
Target Server Version : 50711
File Encoding         : 65001

Date: 2016-09-23 03:10:40
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='maintains product category\n';

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('1', 'dairy');
INSERT INTO `category` VALUES ('2', 'meats');
INSERT INTO `category` VALUES ('3', 'bakery');
INSERT INTO `category` VALUES ('4', 'fruit & veg');

-- ----------------------------
-- Table structure for customer
-- ----------------------------
DROP TABLE IF EXISTS `customer`;
CREATE TABLE `customer` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `address` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `city_region` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `cc_number` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='maintains customer details';

-- ----------------------------
-- Records of customer
-- ----------------------------

-- ----------------------------
-- Table structure for customer_order
-- ----------------------------
DROP TABLE IF EXISTS `customer_order`;
CREATE TABLE `customer_order` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `amount` decimal(6,2) NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `confirmation_number` int(10) unsigned NOT NULL,
  `customer_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_customer_order_customer1_idx` (`customer_id`),
  CONSTRAINT `fk_customer_order_customer1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='Maintains order details\n';

-- ----------------------------
-- Records of customer_order
-- ----------------------------

-- ----------------------------
-- Table structure for ordered_product
-- ----------------------------
DROP TABLE IF EXISTS `ordered_product`;
CREATE TABLE `ordered_product` (
  `customer_order_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `quantity` smallint(5) unsigned NOT NULL DEFAULT '1',
  PRIMARY KEY (`customer_order_id`,`product_id`),
  KEY `fk_ordered_product_customer_order1_idx` (`customer_order_id`),
  KEY `fk_ordered_product_product1_idx` (`product_id`),
  CONSTRAINT `fk_ordered_product_customer_order1` FOREIGN KEY (`customer_order_id`) REFERENCES `customer_order` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ordered_product_product1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of ordered_product
-- ----------------------------

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `price` decimal(5,2) NOT NULL,
  `description` tinytext COLLATE utf8_unicode_ci,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `category_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_product_category_idx` (`category_id`),
  CONSTRAINT `fk_product_category` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='maintains product details';

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES ('1', 'milk', '1.70', 'semi skimmed (1L)', '2016-09-23 03:09:05', '1');
INSERT INTO `product` VALUES ('2', 'cheese', '2.39', 'mild cheddar (330g)', '2016-09-23 03:09:05', '1');
INSERT INTO `product` VALUES ('3', 'butter', '1.09', 'unsalted (250g)', '2016-09-23 03:09:05', '1');
INSERT INTO `product` VALUES ('4', 'free range eggs', '1.76', 'medium-sized (6 eggs)', '2016-09-23 03:09:05', '1');
INSERT INTO `product` VALUES ('5', 'organic meat patties', '2.29', 'rolled in fresh herbs<br>2 patties (250g)', '2016-09-23 03:09:05', '2');
INSERT INTO `product` VALUES ('6', 'parma ham', '3.49', 'matured, organic (70g)', '2016-09-23 03:09:05', '2');
INSERT INTO `product` VALUES ('7', 'chicken leg', '2.59', 'free range (250g)', '2016-09-23 03:09:06', '2');
INSERT INTO `product` VALUES ('8', 'sausages', '3.55', 'reduced fat, pork<br>3 sausages (350g)', '2016-09-23 03:09:06', '2');
INSERT INTO `product` VALUES ('9', 'sunflower seed loaf', '1.89', '600g', '2016-09-23 03:09:06', '3');
INSERT INTO `product` VALUES ('10', 'sesame seed bagel', '1.19', '4 bagels', '2016-09-23 03:09:06', '3');
INSERT INTO `product` VALUES ('11', 'pumpkin seed bun', '1.15', '4 buns', '2016-09-23 03:09:06', '3');
INSERT INTO `product` VALUES ('12', 'chocolate cookies', '2.39', 'contain peanuts<br>(3 cookies)', '2016-09-23 03:09:06', '3');
INSERT INTO `product` VALUES ('13', 'corn on the cob', '1.59', '2 pieces', '2016-09-23 03:09:06', '4');
INSERT INTO `product` VALUES ('14', 'red currants', '2.49', '150g', '2016-09-23 03:09:06', '4');
INSERT INTO `product` VALUES ('15', 'broccoli', '1.29', '500g', '2016-09-23 03:09:06', '4');
INSERT INTO `product` VALUES ('16', 'seedless watermelon', '1.49', '250g', '2016-09-23 03:09:06', '4');
SET FOREIGN_KEY_CHECKS=1;
