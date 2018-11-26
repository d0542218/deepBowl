-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema game_chatbot
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema game_chatbot
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `game_chatbot` DEFAULT CHARACTER SET utf8 ;
USE `game_chatbot` ;

-- -----------------------------------------------------
-- Table `game_chatbot`.`company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `game_chatbot`.`company` (
  `company_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `company_name` VARCHAR(45) NOT NULL,
  `company_country` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`company_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `game_chatbot`.`game`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `game_chatbot`.`game` (
  `game_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `game_price` DECIMAL(5,2) NULL DEFAULT NULL,
  `game_price_currency` ENUM('TWD', 'CNY', 'JPY', 'USD') NOT NULL DEFAULT 'USD',
  `game_guides_URL` VARCHAR(2083) NULL DEFAULT NULL,
  `game_name` VARCHAR(45) NOT NULL,
  `game_score` FLOAT NULL DEFAULT NULL,
  `game_release_date` DATE NULL DEFAULT NULL,
  `game_introduction_URL` VARCHAR(2083) NULL DEFAULT NULL,
  PRIMARY KEY (`game_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `game_chatbot`.`contest`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `game_chatbot`.`contest` (
  `contest_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `contest_name` VARCHAR(45) NOT NULL,
  `contest_date` DATE NULL DEFAULT NULL,
  `contest_URL` VARCHAR(2083) NULL DEFAULT NULL,
  `contest_country` VARCHAR(45) NULL DEFAULT NULL,
  `contest_city` VARCHAR(45) NULL DEFAULT NULL,
  `contest_address` VARCHAR(45) NULL DEFAULT NULL,
  `contest_ticket_price` FLOAT NULL DEFAULT NULL,
  `contest_ticket_price_currency` ENUM('TWD', 'CNY', 'JPY', 'USD') NOT NULL DEFAULT 'USD',
  `contest_game_ID` INT(11) NOT NULL,
  `game_game_ID` INT(11) NOT NULL,
  PRIMARY KEY (`contest_ID`, `game_game_ID`),
  INDEX `fk_contest_game1_idx` (`game_game_ID` ASC) ,
  CONSTRAINT `fk_contest_game1`
    FOREIGN KEY (`game_game_ID`)
    REFERENCES `game_chatbot`.`game` (`game_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `game_chatbot`.`contest_has_company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `game_chatbot`.`contest_has_company` (
  `company_ID` INT(11) NOT NULL,
  `contest_ID` INT(11) NOT NULL,
  PRIMARY KEY (`company_ID`, `contest_ID`),
  INDEX `fk_company_has_contest_contest1_idx` (`contest_ID` ASC) ,
  INDEX `fk_company_has_contest_company1_idx` (`company_ID` ASC) ,
  CONSTRAINT `fk_company_has_contest_company1`
    FOREIGN KEY (`company_ID`)
    REFERENCES `game_chatbot`.`company` (`company_ID`),
  CONSTRAINT `fk_company_has_contest_contest1`
    FOREIGN KEY (`contest_ID`)
    REFERENCES `game_chatbot`.`contest` (`contest_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `game_chatbot`.`news`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `game_chatbot`.`news` (
  `news_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `news_topic` VARCHAR(45) NOT NULL,
  `news_URL` VARCHAR(2048) NOT NULL,
  `news_release_date` DATE NOT NULL,
  PRIMARY KEY (`news_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `game_chatbot`.`news_has_company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `game_chatbot`.`news_has_company` (
  `company_ID` INT(11) NOT NULL,
  `news_ID` INT(11) NOT NULL,
  PRIMARY KEY (`company_ID`, `news_ID`),
  INDEX `fk_company_has_news_news1_idx` (`news_ID` ASC) ,
  INDEX `fk_company_has_news_company1_idx` (`company_ID` ASC) ,
  CONSTRAINT `fk_company_has_news_company1`
    FOREIGN KEY (`company_ID`)
    REFERENCES `game_chatbot`.`company` (`company_ID`),
  CONSTRAINT `fk_company_has_news_news1`
    FOREIGN KEY (`news_ID`)
    REFERENCES `game_chatbot`.`news` (`news_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `game_chatbot`.`team`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `game_chatbot`.`team` (
  `team_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `team_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`team_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `game_chatbot`.`contest_has_team`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `game_chatbot`.`contest_has_team` (
  `contest_ID` INT(11) NOT NULL,
  `team_ID` INT(11) NOT NULL,
  PRIMARY KEY (`contest_ID`, `team_ID`),
  INDEX `fk_contest_has_team_team1_idx` (`team_ID` ASC) ,
  INDEX `fk_contest_has_team_contest1_idx` (`contest_ID` ASC) ,
  CONSTRAINT `fk_contest_has_team_contest1`
    FOREIGN KEY (`contest_ID`)
    REFERENCES `game_chatbot`.`contest` (`contest_ID`),
  CONSTRAINT `fk_contest_has_team_team1`
    FOREIGN KEY (`team_ID`)
    REFERENCES `game_chatbot`.`team` (`team_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `game_chatbot`.`exhibition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `game_chatbot`.`exhibition` (
  `exhibition_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `exhibition_name` VARCHAR(45) NOT NULL,
  `exhibition_date` DATE NULL DEFAULT NULL,
  `exhibition_URL` VARCHAR(2083) NULL DEFAULT NULL,
  `exhibition_country` VARCHAR(45) NULL DEFAULT NULL,
  `exhibition_city` VARCHAR(45) NULL DEFAULT NULL,
  `exhibition_address` VARCHAR(45) NULL DEFAULT NULL,
  `exhibition_ticket_price` FLOAT NULL DEFAULT NULL,
  `exhibition_ticket_price_currency` ENUM('TWD', 'CNY', 'JPY', 'USD') NOT NULL DEFAULT 'USD',
  PRIMARY KEY (`exhibition_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `game_chatbot`.`exhibition_has_game`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `game_chatbot`.`exhibition_has_game` (
  `exhibition_ID` INT(11) NOT NULL,
  `game_ID` INT(11) NOT NULL,
  PRIMARY KEY (`exhibition_ID`, `game_ID`),
  INDEX `fk_exhibition_has_game_game1_idx` (`game_ID` ASC) ,
  INDEX `fk_exhibition_has_game_exhibition1_idx` (`exhibition_ID` ASC) ,
  CONSTRAINT `fk_exhibition_has_game_exhibition1`
    FOREIGN KEY (`exhibition_ID`)
    REFERENCES `game_chatbot`.`exhibition` (`exhibition_ID`),
  CONSTRAINT `fk_exhibition_has_game_game1`
    FOREIGN KEY (`game_ID`)
    REFERENCES `game_chatbot`.`game` (`game_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `game_chatbot`.`game_has_company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `game_chatbot`.`game_has_company` (
  `game_ID` INT(11) NOT NULL,
  `company_ID` INT(11) NOT NULL,
  PRIMARY KEY (`game_ID`, `company_ID`),
  INDEX `fk_game_has_company_company1_idx` (`company_ID` ASC) ,
  INDEX `fk_game_has_company_game1_idx` (`game_ID` ASC) ,
  CONSTRAINT `fk_game_has_company_company1`
    FOREIGN KEY (`company_ID`)
    REFERENCES `game_chatbot`.`company` (`company_ID`),
  CONSTRAINT `fk_game_has_company_game1`
    FOREIGN KEY (`game_ID`)
    REFERENCES `game_chatbot`.`game` (`game_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `game_chatbot`.`type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `game_chatbot`.`type` (
  `type_ID` INT(11) NOT NULL AUTO_INCREMENT,
  `type_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`type_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `game_chatbot`.`game_has_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `game_chatbot`.`game_has_type` (
  `game_ID` INT(11) NOT NULL,
  `type_ID` INT(11) NOT NULL,
  PRIMARY KEY (`game_ID`, `type_ID`),
  INDEX `fk_game_has_type_type1_idx` (`type_ID` ASC) ,
  INDEX `fk_game_has_type_game1_idx` (`game_ID` ASC) ,
  CONSTRAINT `fk_game_has_type_game1`
    FOREIGN KEY (`game_ID`)
    REFERENCES `game_chatbot`.`game` (`game_ID`),
  CONSTRAINT `fk_game_has_type_type1`
    FOREIGN KEY (`type_ID`)
    REFERENCES `game_chatbot`.`type` (`type_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `game_chatbot`.`news_has_contest`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `game_chatbot`.`news_has_contest` (
  `news_ID` INT(11) NOT NULL,
  `contest_ID` INT(11) NOT NULL,
  PRIMARY KEY (`news_ID`, `contest_ID`),
  INDEX `fk_news_has_contest_contest1_idx` (`contest_ID` ASC) ,
  INDEX `fk_news_has_contest_news1_idx` (`news_ID` ASC) ,
  CONSTRAINT `fk_news_has_contest_contest1`
    FOREIGN KEY (`contest_ID`)
    REFERENCES `game_chatbot`.`contest` (`contest_ID`),
  CONSTRAINT `fk_news_has_contest_news1`
    FOREIGN KEY (`news_ID`)
    REFERENCES `game_chatbot`.`news` (`news_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `game_chatbot`.`news_has_exhibition`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `game_chatbot`.`news_has_exhibition` (
  `news_ID` INT(11) NOT NULL,
  `exhibition_ID` INT(11) NOT NULL,
  PRIMARY KEY (`news_ID`, `exhibition_ID`),
  INDEX `fk_news_has_exhibition_exhibition1_idx` (`exhibition_ID` ASC) ,
  INDEX `fk_news_has_exhibition_news1_idx` (`news_ID` ASC) ,
  CONSTRAINT `fk_news_has_exhibition_exhibition1`
    FOREIGN KEY (`exhibition_ID`)
    REFERENCES `game_chatbot`.`exhibition` (`exhibition_ID`),
  CONSTRAINT `fk_news_has_exhibition_news1`
    FOREIGN KEY (`news_ID`)
    REFERENCES `game_chatbot`.`news` (`news_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `game_chatbot`.`news_has_game`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `game_chatbot`.`news_has_game` (
  `news_ID` INT(11) NOT NULL,
  `game_ID` INT(11) NOT NULL,
  PRIMARY KEY (`news_ID`, `game_ID`),
  INDEX `fk_news_has_game_game1_idx` (`game_ID` ASC) ,
  INDEX `fk_news_has_game_news1_idx` (`news_ID` ASC) ,
  CONSTRAINT `fk_news_has_game_game1`
    FOREIGN KEY (`game_ID`)
    REFERENCES `game_chatbot`.`game` (`game_ID`),
  CONSTRAINT `fk_news_has_game_news1`
    FOREIGN KEY (`news_ID`)
    REFERENCES `game_chatbot`.`news` (`news_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
