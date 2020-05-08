-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema CompanyDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema CompanyDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `CompanyDB` DEFAULT CHARACTER SET latin1 ;
USE `CompanyDB` ;

-- -----------------------------------------------------
-- Table `CompanyDB`.`EMPLOYEE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CompanyDB`.`EMPLOYEE` (
  `Fname` VARCHAR(20) NOT NULL,
  `Minit` CHAR NULL,
  `Lname` VARCHAR(20) NOT NULL,
  `Ssn` CHAR(9) NOT NULL,
  `Bdate` DATE NULL DEFAULT NULL,
  `Address` VARCHAR(30) NULL DEFAULT NULL,
  `Gender` CHAR(1) NULL DEFAULT NULL,
  `Salary` FLOAT NULL DEFAULT NULL,
  `SuperSsn` CHAR(9) NOT NULL,
  `Dno` INT(2) NOT NULL,
  INDEX `SuperSsn` (`SuperSsn` ASC),
  INDEX `Dno` (`Dno` ASC),
  PRIMARY KEY (`Ssn`, `Dno`, `SuperSsn`),
  CONSTRAINT `fk_EMPLOYEE_1`
    FOREIGN KEY (`SuperSsn`)
    REFERENCES `CompanyDB`.`EMPLOYEE` (`Ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EMPLOYEE_2`
    FOREIGN KEY (`Dno`)
    REFERENCES `CompanyDB`.`DEPARTMENT` (`Dnumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `CompanyDB`.`DEPARTMENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CompanyDB`.`DEPARTMENT` (
  `Dname` VARCHAR(20) NOT NULL,
  `Dnumber` INT(1) NOT NULL,
  `Mgr_Ssn` CHAR(9) NOT NULL,
  `MgrStartDate` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`Dnumber`, `Mgr_Ssn`),
  INDEX `fk_DEPARTMENT_EMPLOYEE_idx` (`Mgr_Ssn` ASC),
  UNIQUE INDEX `Dname_UNIQUE` (`Dname` ASC),
  CONSTRAINT `fk_DEPARTMENT_EMPLOYEE`
    FOREIGN KEY (`Mgr_Ssn`)
    REFERENCES `CompanyDB`.`EMPLOYEE` (`Ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `CompanyDB`.`DEPENDENT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CompanyDB`.`DEPENDENT` (
  `Essn` CHAR(9) NOT NULL,
  `DependentName` VARCHAR(20) NOT NULL,
  `Sex` CHAR(1) NULL DEFAULT NULL,
  `Bdate` DATE NULL DEFAULT NULL,
  `Relationship` VARCHAR(10) NULL DEFAULT NULL,
  INDEX `fk_DEPENDENT_1_idx` (`Essn` ASC),
  PRIMARY KEY (`Essn`, `DependentName`),
  CONSTRAINT `fk_DEPENDENT_1`
    FOREIGN KEY (`Essn`)
    REFERENCES `CompanyDB`.`EMPLOYEE` (`Ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `CompanyDB`.`PROJECT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CompanyDB`.`PROJECT` (
  `Pname` VARCHAR(20) NOT NULL,
  `Pnumber` INT(3) NOT NULL,
  `Plocation` VARCHAR(20) NULL DEFAULT NULL,
  `Dnum` INT(1) NOT NULL,
  PRIMARY KEY (`Pnumber`, `Dnum`),
  INDEX `fk_PROJECT_1_idx` (`Dnum` ASC),
  UNIQUE INDEX `Pname_UNIQUE` (`Pname` ASC),
  CONSTRAINT `fk_PROJECT_1`
    FOREIGN KEY (`Dnum`)
    REFERENCES `CompanyDB`.`DEPARTMENT` (`Dnumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `CompanyDB`.`WORKSON`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CompanyDB`.`WORKSON` (
  `Essn` CHAR(9) NOT NULL,
  `Pno` INT(3) NOT NULL,
  `Hours` FLOAT(3,1) NOT NULL,
  INDEX `Pno` (`Pno` ASC),
  INDEX `fk_WORKSON_1_idx` (`Essn` ASC),
  PRIMARY KEY (`Essn`, `Pno`),
  CONSTRAINT `fk_WORKSON_1`
    FOREIGN KEY (`Essn`)
    REFERENCES `CompanyDB`.`EMPLOYEE` (`Ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_WORKSON_2`
    FOREIGN KEY (`Pno`)
    REFERENCES `CompanyDB`.`PROJECT` (`Pnumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `CompanyDB`.`DEPT_LOCATIONS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CompanyDB`.`DEPT_LOCATIONS` (
  `Dnumber` INT(1) NOT NULL,
  `Dlocation` VARCHAR(30) NOT NULL,
  INDEX `fk_DEPT_LOCATIONS_1_idx` (`Dnumber` ASC),
  PRIMARY KEY (`Dnumber`, `Dlocation`),
  CONSTRAINT `fk_DEPT_LOCATIONS_1`
    FOREIGN KEY (`Dnumber`)
    REFERENCES `CompanyDB`.`DEPARTMENT` (`Dnumber`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
