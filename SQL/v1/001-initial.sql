SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`website`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`website` ;

CREATE TABLE IF NOT EXISTS `mydb`.`website` (
  `wname` VARCHAR(45) NULL,
  `create_time` DATETIME NULL,
  `contact_mail` VARCHAR(45) NULL,
  `contact_number` VARCHAR(20) NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`page`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`page` ;

CREATE TABLE IF NOT EXISTS `mydb`.`page` (
  `page_id` INT NOT NULL AUTO_INCREMENT,
  `page_name` VARCHAR(45) NULL,
  `page_url` VARCHAR(45) NOT NULL,
  `create_time` DATETIME NULL,
  PRIMARY KEY (`page_id`),
  UNIQUE INDEX `UNIQUE_PAGE` (`page_url` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`user` ;

CREATE TABLE IF NOT EXISTS `mydb`.`user` (
  `username` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `password` CHAR(70) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `INDEX_LOGIN` (`username` ASC, `password` ASC),
  PRIMARY KEY (`username`),
  UNIQUE INDEX `UNIQUE_EMAIL` (`email` ASC));


-- -----------------------------------------------------
-- Table `mydb`.`page_element_types`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`page_element_types` ;

CREATE TABLE IF NOT EXISTS `mydb`.`page_element_types` (
  `element_id` INT NOT NULL AUTO_INCREMENT,
  `element_name` VARCHAR(45) NULL,
  PRIMARY KEY (`element_id`),
  UNIQUE INDEX `UNIQUE_ELEMENT` (`element_name` ASC))
ENGINE = InnoDB;



-- -----------------------------------------------------
-- Table `mydb`.`page_text_values`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`page_text_values` ;

CREATE TABLE IF NOT EXISTS `mydb`.`page_text_values` (
  `element_id` INT NOT NULL,
  `element_value` LONGTEXT NULL,
  PRIMARY KEY (`element_id`),
  CONSTRAINT `FK_ELEMENT_VALUE`
    FOREIGN KEY (`element_id`)
    REFERENCES `mydb`.`page_element` (`element_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user_record`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`user_record` ;

CREATE TABLE IF NOT EXISTS `mydb`.`user_record` (
  `record_id` INT NOT NULL AUTO_INCREMENT,
  `create_time` DATETIME NULL,
  `record_element` INT NOT NULL,
  PRIMARY KEY (`record_id`, `record_element`),
  INDEX `FK_RECORD_ELEMENT_idx` (`record_element` ASC),
  CONSTRAINT `FK_RECORD_ELEMENT`
    FOREIGN KEY (`record_element`)
    REFERENCES `mydb`.`page_element` (`element_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`user_record_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`user_record_item` ;

CREATE TABLE IF NOT EXISTS `mydb`.`user_record_item` (
  `record_id` INT NOT NULL,
  `record_element` INT NOT NULL,
  `record_value` VARCHAR(5000) NULL,
  PRIMARY KEY (`record_id`, `record_element`),
  INDEX `FK_RECORD_ITEM_RECORD_idx` (`record_id` ASC),
  INDEX `FK_RECORD_ITEM_ELEMENT_idx` (`record_element` ASC),
  CONSTRAINT `FK_RECORD_ITEM_RECORD`
    FOREIGN KEY (`record_id`)
    REFERENCES `mydb`.`user_record` (`record_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_RECORD_ITEM_ELEMENT`
    FOREIGN KEY (`record_element`)
    REFERENCES `mydb`.`page_element` (`element_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`page_element`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`page_element` ;

CREATE TABLE IF NOT EXISTS `mydb`.`page_element` (
  `element_id` INT NOT NULL AUTO_INCREMENT,
  `page_id` INT NOT NULL,
  `element_type` INT NOT NULL,
  `element_html_id` VARCHAR(45) NULL,
  `element_html_attrs` VARCHAR(1024) NULL,
  `element_parent` INT NULL,
  `element_position` INT NULL,
  PRIMARY KEY (`element_id`, `page_id`),
  INDEX `FK_PAGE_SECTION_ELEMENT_TYPES_idx` (`element_type` ASC),
  INDEX `INDEX_PARENT` (`element_parent` ASC),
  INDEX `INDEX_PAGE` (`page_id` ASC),
  CONSTRAINT `FK_PAGE_ELEMENT_ELEMENT_TYPES`
    FOREIGN KEY (`element_type`)
    REFERENCES `mydb`.`page_element_types` (`element_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `FK_PAGE_ELEMENT_PARENT`
    FOREIGN KEY (`element_parent`)
    REFERENCES `mydb`.`page_element` (`element_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `FK_PAGE_ELEMENT_PAGE`
    FOREIGN KEY (`page_id`)
    REFERENCES `mydb`.`page` (`page_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
