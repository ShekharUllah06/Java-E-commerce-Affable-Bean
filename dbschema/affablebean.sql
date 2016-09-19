-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema affablebean
-- -----------------------------------------------------
-- Schema used with the AffableBean application
DROP SCHEMA IF EXISTS `affablebean` ;

-- -----------------------------------------------------
-- Schema affablebean
--
-- Schema used with the AffableBean application
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `affablebean` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;
USE `affablebean` ;

-- -----------------------------------------------------
-- Table `affablebean`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `affablebean`.`customer` ;

CREATE TABLE IF NOT EXISTS `affablebean`.`customer` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `city_region` VARCHAR(2) NOT NULL,
  `cc_number` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = 'maintains customer details';


-- -----------------------------------------------------
-- Table `affablebean`.`customer_order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `affablebean`.`customer_order` ;

CREATE TABLE IF NOT EXISTS `affablebean`.`customer_order` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `amount` DECIMAL(6,2) NOT NULL,
  `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `confirmation_number` INT UNSIGNED NOT NULL,
  `customer_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_customer_order_customer1_idx` (`customer_id` ASC),
  CONSTRAINT `fk_customer_order_customer1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `affablebean`.`customer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Maintains order details\n';


-- -----------------------------------------------------
-- Table `affablebean`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `affablebean`.`category` ;

CREATE TABLE IF NOT EXISTS `affablebean`.`category` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
COMMENT = 'maintains product category\n';


-- -----------------------------------------------------
-- Table `affablebean`.`product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `affablebean`.`product` ;

CREATE TABLE IF NOT EXISTS `affablebean`.`product` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `price` DECIMAL(5,2) NOT NULL,
  `description` TINYTEXT NULL,
  `last_update` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `category_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_product_category_idx` (`category_id` ASC),
  CONSTRAINT `fk_product_category`
    FOREIGN KEY (`category_id`)
    REFERENCES `affablebean`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'maintains product details';


-- -----------------------------------------------------
-- Table `affablebean`.`ordered_product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `affablebean`.`ordered_product` ;

CREATE TABLE IF NOT EXISTS `affablebean`.`ordered_product` (
  `customer_order_id` INT UNSIGNED NOT NULL,
  `product_id` INT UNSIGNED NOT NULL,
  `quantity` SMALLINT UNSIGNED NOT NULL DEFAULT 1,
  INDEX `fk_ordered_product_customer_order1_idx` (`customer_order_id` ASC),
  INDEX `fk_ordered_product_product1_idx` (`product_id` ASC),
  PRIMARY KEY (`customer_order_id`, `product_id`),
  CONSTRAINT `fk_ordered_product_customer_order1`
    FOREIGN KEY (`customer_order_id`)
    REFERENCES `affablebean`.`customer_order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ordered_product_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `affablebean`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
