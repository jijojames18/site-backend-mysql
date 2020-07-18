CREATE TABLE IF NOT EXISTS `mydb`.`upgrade_history` (
  `last_inserted` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`last_inserted`))
ENGINE = InnoDB