/* 
  CreateTables.sql
  This script creates the initial, unnormalized tables and data that are modified for this project.
*/

CREATE SCHEMA `ordermgmt`;

-- Products table and data.
CREATE TABLE `ordermgmt`.`products` (
  `productID` INT NOT NULL AUTO_INCREMENT,
  `productName` VARCHAR(50) NULL,
  `productPrice` VARCHAR(50) NULL,
  `orderQty` INT NULL,
  `qoh` INT NULL,
  `manufacturer` VARCHAR(50) NULL,
  PRIMARY KEY (`productID`),
  UNIQUE INDEX `productID_UNIQUE` (`productID` ASC) VISIBLE
);

INSERT INTO `ordermgmt`.`products`
  (`productName`, `productPrice`, `orderQty`, `qoh`, `manufacturer`)
VALUES
  ('Lionel Freight Car', 'Ten', 10, 19, NULL),
  ('Tomcat F-14', '39.99', NULL, 2, 'Revell'),
  ('1957 Corvette Convertible', '56.75"', 5, 1, 'Revell'),
  ('The USS Constitution Ship', '$99.99', NULL, 2, 'Red Start Diecast');

-- Orders table and data.
CREATE TABLE `ordermgmt`.`orders` (
  `orderID` INT NOT NULL AUTO_INCREMENT,
  `qty` VARCHAR(50) NULL,
  `customerName` VARCHAR(50) NULL,
  `orderDate` DATE NULL,
  `status` VARCHAR(50) NULL,
  `customerID` INT NULL,
  PRIMARY KEY (`orderID`),
  UNIQUE INDEX `orderID_UNIQUE` (`orderID` ASC) VISIBLE
);

INSERT INTO `ordermgmt`.`orders`
  (`qty`, `customerName`, `orderDate`, `status`, `customerID`)
VALUES
  (NULL, 'Dave Thomas', STR_TO_DATE('12/15/2019', '%m/%d/%Y'), 'cancelled', 5),
  ('3', 'Dave Thomas', STR_TO_DATE('10/13/1919', '%m/%d/%Y'), 'shipped', 5),
  ('Five', 'Jane Eyre', NULL, 'in process', 7),
  (NULL, NULL, STR_TO_DATE('1/15/2020', '%m/%d/%Y'), 'shipped', 50),
  ('12', 'Sherlock Holmes', STR_TO_DATE('1/31/2020', '%m/%d/%Y'), 'shipped', 4),
  ('1', 'Edgar Allen Poe', STR_TO_DATE('2/15/2020', '%m/%d/%Y'), 'shipped', 4);

-- Customers table and data.
CREATE TABLE `ordermgmt`.`customers` (
  `customerID` INT NOT NULL AUTO_INCREMENT,
  `customerName` VARCHAR(50) NULL,
  `customerAddress` VARCHAR(50) NULL,
  `customerPhone` VARCHAR(50) NULL,
  `orderIDs` VARCHAR(50) NULL,
  PRIMARY KEY (`customerID`),
  UNIQUE INDEX `customerID_UNIQUE` (`customerID` ASC) VISIBLE
);

INSERT INTO `ordermgmt`.`customers`
  (`customerName`, `customerAddress`, `customerPhone`, `orderIDS`)
VALUES
  ('Jane Eyre', '123 North South St', '715-555-1212', '1, 2, 7, 3'),
  ('Sherlock Holmes', '221b Baker St', '800-555-1212', '15 45 100 235'),
  ('Sherlock Holmes', '221b', '800-555-1414', NULL),
  ('Edgar Allen Poe', 'Boston, MA', '800-999-1547', '0');