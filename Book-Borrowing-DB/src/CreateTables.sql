/* 
  Creates the library schema and tables in accordance with rubric parts 1-3 and 19 from
  Computer Science 204 - Assignment 1: Creating & Manipulating a Database.

  Created by Evan Redden, 06/16/2024. 
*/

CREATE SCHEMA `library`;

CREATE TABLE `library`.`client` (
  `ClientID` INT NOT NULL AUTO_INCREMENT,
  `ClientFirstName` VARCHAR(45) NOT NULL,
  `ClientLastName` VARCHAR(45) NOT NULL,
  `ClientDOB` YEAR NOT NULL,
  `Occupation` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ClientID`),
  UNIQUE INDEX `ClientID_UNIQUE` (`ClientID` ASC) VISIBLE
);

CREATE TABLE `library`.`author` (
  `AuthorID` INT NOT NULL AUTO_INCREMENT,
  `AuthorFirstName` VARCHAR(45) NOT NULL,
  `AuthorLastName` VARCHAR(45) NOT NULL,
  `AuthorNationality` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`AuthorID`),
  UNIQUE INDEX `AuthorID_UNIQUE` (`AuthorID` ASC) VISIBLE
);

CREATE TABLE `library`.`book` (
  `BookID` INT NOT NULL AUTO_INCREMENT,
  `BookTitle` VARCHAR(45) NOT NULL,
  `AuthorID` INT NOT NULL,
  `Genre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`BookID`),
  UNIQUE INDEX `BookID_UNIQUE` (`BookID` ASC) VISIBLE,
  INDEX `AuthorID_idx` (`AuthorID` ASC) VISIBLE,
  CONSTRAINT `AuthorID`
    FOREIGN KEY (`AuthorID`)
    REFERENCES `library`.`author` (`AuthorID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);

CREATE TABLE `library`.`borrower` (
  `BorrowID` INT NOT NULL AUTO_INCREMENT,
  `ClientID` INT NOT NULL,
  `BookID` INT NOT NULL,
  `BorrowDate` DATE NOT NULL,
  PRIMARY KEY (`BorrowID`),
  UNIQUE INDEX `BorrowID_UNIQUE` (`BorrowID` ASC) VISIBLE,
  INDEX `ClientID_idx` (`ClientID` ASC) VISIBLE,
  INDEX `BookID_idx` (`BookID` ASC) VISIBLE,
  CONSTRAINT `ClientID`
    FOREIGN KEY (`ClientID`)
    REFERENCES `library`.`client` (`ClientID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `BookID`
    FOREIGN KEY (`BookID`)
    REFERENCES `library`.`book` (`BookID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
);