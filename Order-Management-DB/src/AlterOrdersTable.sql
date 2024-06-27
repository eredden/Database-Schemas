/* 
  AlterOrdersTable.sql
  This script alters the existing original tables and creates new tables to normalize the data within them.
    
    - qty field renamed to orderQty and existing values casted to INT data type.
    - customerName field removed as customerID already points to this information.
    - statusID replaces existing status field and points to records in the newly made status table.
*/

-- Prepping status values to be converted into INT foreign keys for the status table, along with standard data normalization.
-- For these first two orders, customer IDs are temporarily made NULL until customer Dave Thomas is created.  
UPDATE `ordermgmt`.`orders`
SET `status` = 3, `customerID` = NULL
WHERE `orderID` = 1;

UPDATE `ordermgmt`.`orders`
SET `status` = 1, `customerID` = NULL
WHERE `orderID` = 2;

UPDATE `ordermgmt`.`orders`
SET `status` = 2, `qty` = 5, `customerID` = 1
WHERE `orderID` = 3;

-- Customer ID 50 does not exist and has no associated name. It is made NULL.
UPDATE `ordermgmt`.`orders`
SET `status` = 1, `customerID` = NULL
WHERE `orderID` = 4;

UPDATE `ordermgmt`.`orders`
SET `status` = 1, `customerID` = 2
WHERE `orderID` = 5;

-- Note that this customerID will eventually point to Edgar Allen Poe instead of the duplicate record for Sherlock Holmes.
UPDATE `ordermgmt`.`orders`
SET `status` = 1, `customerID` = 3
WHERE `orderID` = 6;

-- Creating a status table to hold status records.
CREATE TABLE `ordermgmt`.`status` (
  `statusID` INT NOT NULL AUTO_INCREMENT,
  `statusName` VARCHAR(50) NULL,
  PRIMARY KEY (`statusID`),
  UNIQUE INDEX `statusID_UNIQUE` (`statusID` ASC) VISIBLE
);

INSERT INTO `ordermgmt`.`status`
  (`statusName`)
VALUES
  ('shipped'),
  ('in process'),
  ('cancelled');

-- Modifying the structure of the orders table.
ALTER TABLE `ordermgmt`.`orders` 
DROP COLUMN `customerName`,
CHANGE COLUMN `qty` `orderQty` INT NULL DEFAULT NULL ,
CHANGE COLUMN `status` `statusID` INT NULL DEFAULT NULL ,
ADD INDEX `statusID_idx` (`statusID` ASC) VISIBLE,
ADD INDEX `customerID_idx` (`customerID` ASC) VISIBLE;

ALTER TABLE `ordermgmt`.`orders` 
ADD CONSTRAINT `statusID`
  FOREIGN KEY (`statusID`)
  REFERENCES `ordermgmt`.`status` (`statusID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `customerID`
  FOREIGN KEY (`customerID`)
  REFERENCES `ordermgmt`.`customers` (`customerID`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;