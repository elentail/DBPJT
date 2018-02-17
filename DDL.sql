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
  `name` VARCHAR(200) NULL,
  `position` VARCHAR(200) NULL,
  `capacity` INT NOT NULL,
  PRIMARY KEY (`idHall`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `testdb`.`Audience`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testdb`.`Audience` (
  `idAudience` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NULL,
  `gender` CHAR(1) NULL,
  `age` INT NOT NULL,
  PRIMARY KEY (`idAudience`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `testdb`.`Performance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testdb`.`Performance` (
  `idShow` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(200) NULL,
  `category` VARCHAR(200) NOT NULL,
  `price` INT NOT NULL,
  PRIMARY KEY (`idShow`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `testdb`.`Book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testdb`.`Book` (
  `idAudience` INT NOT NULL,
  `idShow` INT NOT NULL,
  INDEX `FK_rsv_audience_idx` (`idAudience` ASC),
  INDEX `FK_rsv_show_idx` (`idShow` ASC),
  PRIMARY KEY (`idAudience`, `idShow`),
  CONSTRAINT `FK_rsv_audience`
    FOREIGN KEY (`idAudience`)
    REFERENCES `testdb`.`Audience` (`idAudience`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_rsv_show`
    FOREIGN KEY (`idShow`)
    REFERENCES `testdb`.`Performance` (`idShow`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `testdb`.`Assign`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `testdb`.`Assign` (
  `idHall` INT NOT NULL,
  `idShow` INT NOT NULL,
  INDEX `FK_HALL_idHall_idx` (`idHall` ASC),
  INDEX `FK_SHOW_idShow_idx` (`idShow` ASC),
  PRIMARY KEY (`idHall`, `idShow`),
  CONSTRAINT `FK_HALL_idHall`
    FOREIGN KEY (`idHall`)
    REFERENCES `testdb`.`Building` (`idHall`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_SHOW_idShow`
    FOREIGN KEY (`idShow`)
    REFERENCES `testdb`.`Performance` (`idShow`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
