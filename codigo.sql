-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema playground_db10
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema playground_db10
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `playground_db10` DEFAULT CHARACTER SET utf8 ;
USE `playground_db10` ;

-- -----------------------------------------------------
-- Table `playground_db10`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground_db10`.`categories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground_db10`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground_db10`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `categoryId` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_users_categories_idx` (`categoryId` ASC) VISIBLE,
  CONSTRAINT `fk_users_categories`
    FOREIGN KEY (`categoryId`)
    REFERENCES `playground_db10`.`categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground_db10`.`courses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground_db10`.`courses` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(500) NOT NULL,
  `date_start` DATE NOT NULL,
  `date_end` DATE NOT NULL,
  `quote` INT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground_db10`.`units`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground_db10`.`units` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(500) NOT NULL,
  `date_start` DATE NOT NULL,
  `courseId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_units_courses_idx` (`courseId` ASC) VISIBLE,
  CONSTRAINT `fk_units_courses`
    FOREIGN KEY (`courseId`)
    REFERENCES `playground_db10`.`courses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground_db10`.`lessons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground_db10`.`lessons` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(500) NOT NULL,
  `date_start` DATE NOT NULL,
  `visible` TINYINT NOT NULL,
  `unitId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_lessons_units_idx` (`unitId` ASC) VISIBLE,
  CONSTRAINT `fk_lessons_units`
    FOREIGN KEY (`unitId`)
    REFERENCES `playground_db10`.`units` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground_db10`.`types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground_db10`.`types` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground_db10`.`blocks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground_db10`.`blocks` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `visible` TINYINT(1) NOT NULL,
  `typeId` INT NOT NULL,
  `content` VARCHAR(255) NOT NULL,
  `lessonId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_blocks_types_idx` (`typeId` ASC) VISIBLE,
  INDEX `fk_block_lessons_idx` (`lessonId` ASC) VISIBLE,
  CONSTRAINT `fk_blocks_types`
    FOREIGN KEY (`typeId`)
    REFERENCES `playground_db10`.`types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_block_lessons`
    FOREIGN KEY (`lessonId`)
    REFERENCES `playground_db10`.`lessons` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground_db10`.`courses_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground_db10`.`courses_users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `userId` INT NOT NULL,
  `courseId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_users_courses_idx` (`userId` ASC) VISIBLE,
  INDEX `fk_courses_users_idx` (`courseId` ASC) VISIBLE,
  CONSTRAINT `fk_users_courses`
    FOREIGN KEY (`userId`)
    REFERENCES `playground_db10`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_courses_users`
    FOREIGN KEY (`courseId`)
    REFERENCES `playground_db10`.`courses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground_db10`.`rol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground_db10`.`rol` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground_db10`.`employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground_db10`.`employees` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `surname` VARCHAR(45) NOT NULL,
  `salary` DECIMAL NOT NULL,
  `rol` VARCHAR(45) NOT NULL,
  `positionId` INT NOT NULL,
  `rol_id` INT NOT NULL,
  PRIMARY KEY (`id`, `positionId`),
  INDEX `fk_employees_rol1_idx` (`rol_id` ASC) VISIBLE,
  CONSTRAINT `fk_employees_rol1`
    FOREIGN KEY (`rol_id`)
    REFERENCES `playground_db10`.`rol` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground_db10`.`sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground_db10`.`sales` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `articles` VARCHAR(45) NOT NULL,
  `payment` VARCHAR(45) NOT NULL,
  `total` DECIMAL NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground_db10`.`categories_bazar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground_db10`.`categories_bazar` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground_db10`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground_db10`.`products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `price` DECIMAL NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `stock` TINYINT(1) NOT NULL,
  `use` TINYINT(1) NOT NULL,
  `categoryId` INT NOT NULL,
  `saleId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_products_sales_idx` (`saleId` ASC) VISIBLE,
  INDEX `fk_products_categories_bazar_idx` (`categoryId` ASC) VISIBLE,
  CONSTRAINT `fk_products_sales`
    FOREIGN KEY (`saleId`)
    REFERENCES `playground_db10`.`sales` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_products_categories_bazar`
    FOREIGN KEY (`categoryId`)
    REFERENCES `playground_db10`.`categories_bazar` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `playground_db10`.`employees_products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `playground_db10`.`employees_products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `employeesId` INT NOT NULL,
  `productsId` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `employees_products_employees_idx` (`employeesId` ASC) VISIBLE,
  INDEX `employees_products_products_idx` (`productsId` ASC) VISIBLE,
  CONSTRAINT `employees_products_employees`
    FOREIGN KEY (`employeesId`)
    REFERENCES `playground_db10`.`employees` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `employees_products_products`
    FOREIGN KEY (`productsId`)
    REFERENCES `playground_db10`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
