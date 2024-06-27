/* 
  AlterCustomersTable.sql
  This script alters the existing original tables and creates new tables to normalize the data within them.
    
    - customerAddress and customerPhone values placed in new address and phone tables, original fields now replaced by foreign keys.
        - The two separate Sherlock Holmes records can now be combined thanks to this.
    - orderIDs field removed as this information can be accessed through the orders table.
*/

-- Prepping address and phone values to become foreign keys, combining Sherlock Holmes records.
UPDATE `ordermgmt`.`customers`
SET `customerAddress` = '1', `customerPhone` = '1'
WHERE `customerID` = 1;

UPDATE `ordermgmt`.`customers`
SET `customerAddress` = '2', `customerPhone` = '2'
WHERE `customerID` = 2;

-- Overwriting duplicate Sherlock Holmes with Edgar Allen Poe.
UPDATE `ordermgmt`.`customers`
SET `customerName` = 'Edgar Allen Poe', `customerAddress` = '3', `customerPhone` = '3'
WHERE `customerID` = 3;

DELETE FROM `ordermgmt`.`customers`
WHERE `customerID` = 4;

-- Creating a phone table to hold phone records.
CREATE TABLE `ordermgmt`.`phone` (
  `phoneID` INT NOT NULL AUTO_INCREMENT,
  `phonePrimaryNumber` VARCHAR(50) NULL,
  `phoneSecondaryNumber` VARCHAR(50) NULL,
  PRIMARY KEY (`phoneID`),
  UNIQUE INDEX `phoneID_UNIQUE` (`phoneID` ASC) VISIBLE
);

INSERT INTO `ordermgmt`.`phone`
  (`phonePrimaryNumber`, `phoneSecondaryNumber`)
VALUES
  ('715-555-1212', NULL),
  ('800-555-1212', '800-555-1414'),
  ('800-999-1547', NULL);

-- Creating an address table to hold address records.
CREATE TABLE `ordermgmt`.`address` (
  `addressID` INT NOT NULL AUTO_INCREMENT,
  `addressStreet` VARCHAR(50) NULL,
  `addressCity` VARCHAR(50) NULL,
  `addressStateCode` VARCHAR(50) NULL,
  `addressCountryCode` VARCHAR(50) NULL,
  PRIMARY KEY (`addressID`),
  UNIQUE INDEX `addressID_UNIQUE` (`addressID` ASC) VISIBLE
);

INSERT INTO `ordermgmt`.`address`
  (`addressStreet`, `addressCity`, `addressStateCode`, `addressCountryCode`)
VALUES
  ('123 North South St', NULL, NULL, NULL),
  ('221b Baker St', 'London', NULL, 'UK'),
  (NULL, 'Boston', 'MA', 'US');

-- Modifying the structure of the customers table.
ALTER TABLE `ordermgmt`.`customers` 
DROP COLUMN `orderIDs`,
CHANGE COLUMN `customerAddress` `addressID` INT NULL DEFAULT NULL,
CHANGE COLUMN `customerPhone` `phoneID` INT NULL DEFAULT NULL,
ADD INDEX `addressID_idx` (`addressID` ASC) VISIBLE,
ADD INDEX `phoneID_idx` (`phoneID` ASC) VISIBLE;

ALTER TABLE `ordermgmt`.`customers` 
ADD CONSTRAINT `addressID`
  FOREIGN KEY (`addressID`)
  REFERENCES `ordermgmt`.`address` (`addressID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `phoneID`
  FOREIGN KEY (`phoneID`)
  REFERENCES `ordermgmt`.`phone` (`phoneID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

-- The orders table has two orders that reference Dave Thomas, so a record is made for him and assigned to those two orders.
INSERT INTO `ordermgmt`.`customers`
  (`customerName`, `addressID`, `phoneID`)
VALUES
  ('Dave Thomas', NULL, NULL);

UPDATE `ordermgmt`.`orders`
SET `customerID` = 5
WHERE `orderID` IN (1, 2);