-- A specific device for a specific user.
SELECT 
  `c`.`EmployeeID`, 
  `c`.`DeviceID`
FROM 
  `devicemgmt`.`checkout` AS `c`
  JOIN `devicemgmt`.`device` AS `d` ON `d`.`DeviceID` = `c`.`DeviceID`
WHERE
  `c`.`EmployeeID` = 150
  AND `c`.`DeviceID` = 1;

-- A device from a specific location.
SELECT 
  `c`.`EmployeeID`, 
  `c`.`DeviceID`,
  `l`.`LocationName`
FROM 
  `devicemgmt`.`checkout` AS `c`
  JOIN `devicemgmt`.`employee` AS `e` ON `e`.`EmployeeID` = `c`.`EmployeeID`
  JOIN `devicemgmt`.`location` AS `l` ON `l`.`LocationID` = `e`.`LocationID`
WHERE
  `c`.`DeviceID` = 5
  AND `l`.`LocationName` = "Office 3";

-- All users who have tablets.
SELECT DISTINCT 
  `c`.`EmployeeID`, 
  `e`.`Name`,
  `c`.`DeviceID`, 
  `dt`.`DeviceType`
FROM 
  `devicemgmt`.`checkout` AS `c`
  JOIN `devicemgmt`.`device` AS `d` ON `d`.`DeviceID` = `c`.`DeviceID`
  JOIN `devicemgmt`.`devicetype` AS `dt` ON `dt`.`DeviceTypeID` = `d`.`DeviceTypeID`
  JOIN `devicemgmt`.`employee` AS `e` ON `e`.`EmployeeID` = `c`.`EmployeeID`
WHERE
  `dt`.`DeviceType` = "Tablet"

-- All users with multiple devices.
SELECT 
  `c`.`EmployeeID`, 
  `e`.`Name`,
  COUNT(*) AS `DeviceCount`
FROM 
  `devicemgmt`.`checkout` AS `c`
  JOIN `devicemgmt`.`employee` AS `e` ON `e`.`EmployeeID` = `c`.`EmployeeID`
GROUP BY 
  `c`.`EmployeeID`
HAVING 
  `deviceCount` > 1
ORDER BY
  `deviceCount` DESC;

-- Any Support Agent users with multiple devices.
SELECT 
  `c`.`EmployeeID`, 
  `e`.`Name`,
  COUNT(*) AS `DeviceCount`
FROM 
  `devicemgmt`.`checkout` AS `c`
  JOIN `devicemgmt`.`employee` AS `e` ON `e`.`EmployeeID` = `c`.`EmployeeID`
  JOIN `devicemgmt`.`role` AS `r` ON `r`.`RoleID` = `e`.`RoleID`
WHERE
  `r`.`Role` = "Support Agent"
GROUP BY 
  `c`.`EmployeeID`
HAVING 
  `deviceCount` > 1
ORDER BY
  `deviceCount` DESC;