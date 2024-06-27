CREATE SCHEMA `devicemgmt`;

CREATE TABLE `devicemgmt`.`devicetype` (
  `DeviceTypeID` INT NOT NULL AUTO_INCREMENT,
  `DeviceType` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`DeviceTypeID`),
  UNIQUE INDEX `DeviceTypeID_UNIQUE` (`DeviceTypeID` ASC) VISIBLE);

CREATE TABLE `devicemgmt`.`version` (
  `VersionID` INT NOT NULL AUTO_INCREMENT,
  `Version` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`VersionID`),
  UNIQUE INDEX `VersionID_UNIQUE` (`VersionID` ASC) VISIBLE);

CREATE TABLE `devicemgmt`.`device` (
  `DeviceID` INT NOT NULL AUTO_INCREMENT,
  `DeviceTypeID` INT NOT NULL,
  `VersionID` INT NOT NULL,
  PRIMARY KEY (`DeviceID`),
  UNIQUE INDEX `DeviceID_UNIQUE` (`DeviceID` ASC) VISIBLE,
  INDEX `DeviceTypeID_idx` (`DeviceTypeID` ASC) VISIBLE,
  INDEX `VersionID_idx` (`VersionID` ASC) VISIBLE,
  CONSTRAINT `DeviceTypeID`
    FOREIGN KEY (`DeviceTypeID`)
    REFERENCES `devicemgmt`.`devicetype` (`DeviceTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `VersionID`
    FOREIGN KEY (`VersionID`)
    REFERENCES `devicemgmt`.`version` (`VersionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `devicemgmt`.`location` (
  `LocationID` INT NOT NULL AUTO_INCREMENT,
  `LocationName` VARCHAR(45) NOT NULL,
  `Capacity` INT NOT NULL,
  `NetworkID` INT NOT NULL,
  PRIMARY KEY (`LocationID`),
  UNIQUE INDEX `LocationID_UNIQUE` (`LocationID` ASC) VISIBLE);

CREATE TABLE `devicemgmt`.`role` (
  `RoleID` INT NOT NULL AUTO_INCREMENT,
  `Role` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`RoleID`),
  UNIQUE INDEX `RoleID_UNIQUE` (`RoleID` ASC) VISIBLE);

CREATE TABLE `devicemgmt`.`employee` (
  `EmployeeID` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `RoleID` INT NOT NULL,
  `LocationID` INT NOT NULL,
  PRIMARY KEY (`EmployeeID`),
  UNIQUE INDEX `EmployeeID_UNIQUE` (`EmployeeID` ASC) VISIBLE,
  INDEX `LocationID_idx` (`LocationID` ASC) VISIBLE,
  INDEX `RoleID_idx` (`RoleID` ASC) VISIBLE,
  CONSTRAINT `LocationID`
    FOREIGN KEY (`LocationID`)
    REFERENCES `devicemgmt`.`location` (`LocationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `RoleID`
    FOREIGN KEY (`RoleID`)
    REFERENCES `devicemgmt`.`role` (`RoleID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `devicemgmt`.`checkout` (
  `CheckOutID` INT NOT NULL,
  `DeviceID` INT NOT NULL,
  `EmployeeID` INT NULL,
  PRIMARY KEY (`CheckOutID`),
  UNIQUE INDEX `CheckOutID_UNIQUE` (`CheckOutID` ASC) VISIBLE,
  INDEX `DeviceID_idx` (`DeviceID` ASC) VISIBLE,
  INDEX `EmployeeID_idx` (`EmployeeID` ASC) VISIBLE,
  CONSTRAINT `DeviceID`
    FOREIGN KEY (`DeviceID`)
    REFERENCES `devicemgmt`.`device` (`DeviceID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `EmployeeID`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `devicemgmt`.`employee` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
