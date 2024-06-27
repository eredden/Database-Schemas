/* 
  AlterProductsTable.sql
  This script alters the existing original tables and creates new tables to normalize the data within them.
    
    - productPrice turned into a DECIMAL variable and existing data is casted into that data type.
    - Manufacturer field replaced by manufacturerID which is a foreign key pointing to records in the manufacturer table.
    - qoh field renamed to productQOH.
    - orderQty field completely removed.
*/

-- Converting productPrice values to decimal prior to field data type change, setting future manufacturerID.
UPDATE `ordermgmt`.`products`
SET `productprice` = 10.00, `manufacturer` = NULL
WHERE `productID` = 1;

UPDATE `ordermgmt`.`products`
SET `productprice` = 39.99, `manufacturer` = 1
WHERE `productID` = 2;

UPDATE `ordermgmt`.`products`
SET `productprice` = 56.75, `manufacturer` = 1
WHERE `productID` = 3;

UPDATE `ordermgmt`.`products`
SET `productprice` = 99.99, `manufacturer` = 2
WHERE `productID` = 4;

-- Creating a manufacturer table to hold manufacturer records.
CREATE TABLE `ordermgmt`.`manufacturer` (
  `manufacturerID` INT NOT NULL AUTO_INCREMENT,
  `manufacturerName` VARCHAR(50) NULL,
  PRIMARY KEY (`manufacturerID`),
  UNIQUE INDEX `manufacturerID_UNIQUE` (`manufacturerID` ASC) VISIBLE
);

INSERT INTO `ordermgmt`.`manufacturer`
  (`manufacturerName`)
VALUES
  ('Revell'),
  ('Red Start Diecast');

-- Modifying the structure of the products table.
ALTER TABLE `ordermgmt`.`products` 
DROP COLUMN `orderQty`,
CHANGE COLUMN `productPrice` `productPrice` DECIMAL(6,2) NULL DEFAULT NULL,
CHANGE COLUMN `qoh` `productQOH` INT NULL DEFAULT NULL,
CHANGE COLUMN `manufacturer` `manufacturerID` INT NULL DEFAULT NULL,
ADD INDEX `manufacturerID_idx` (`manufacturerID` ASC) VISIBLE;

ALTER TABLE `ordermgmt`.`products` 
ADD CONSTRAINT `manufacturerID`
  FOREIGN KEY (`manufacturerID`)
  REFERENCES `ordermgmt`.`manufacturer` (`manufacturerID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;