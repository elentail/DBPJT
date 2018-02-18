-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema testdb
-- -----------------------------------------------------
-- -----------------------------------------------------

-- Schema testdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `testdb` DEFAULT CHARACTER SET utf8 ;
USE `testdb` ;

-- -----------------------------------------------------
-- Table `testdb`.`Building`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testdb`.`Building` (
  `idHall` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `location` VARCHAR(200) NOT NULL,
  `capacity` INT NOT NULL,
  PRIMARY KEY (`idHall`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `testdb`.`Audience`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testdb`.`Audience` (
  `idAudience` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `gender` CHAR(1) NOT NULL,
  `age` INT NOT NULL,
  PRIMARY KEY (`idAudience`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `testdb`.`Performance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testdb`.`Performance` (
  `idShow` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NOT NULL,
  `type` VARCHAR(200) NOT NULL,
  `price` INT NOT NULL,
  PRIMARY KEY (`idShow`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `testdb`.`BookStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testdb`.`BookStatus` (
  `id_hall` INT NOT NULL,
  `id_show` INT NOT NULL,
  `seat_id` INT NOT NULL,
  `id_audience` INT NULL,
  PRIMARY KEY (`id_hall`, `id_show`, `seat_id`),
  INDEX `fk_bookstatus_show_idx` (`id_show` ASC),
  INDEX `fk_bookstatus_audi_idx` (`id_audience` ASC),
  CONSTRAINT `fk_bookstatus_hall`
    FOREIGN KEY (`id_hall`)
    REFERENCES `testdb`.`Building` (`idHall`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bookstatus_show`
    FOREIGN KEY (`id_show`)
    REFERENCES `testdb`.`Performance` (`idShow`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bookstatus_audi`
    FOREIGN KEY (`id_audience`)
    REFERENCES `testdb`.`Audience` (`idAudience`)
    ON DELETE SET NULL
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
