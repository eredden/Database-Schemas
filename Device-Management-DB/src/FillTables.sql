INSERT INTO `devicemgmt`.`devicetype`
  (`DeviceType`)
VALUES
  ('Laptop'),
  ('Tablet'),
  ('Smartphone');

INSERT INTO `devicemgmt`.`version`
  (`Version`)
VALUES
  ('macOS 10.14'),
  ('macOS 10.15'),
  ('IOS 10'),
  ('IOS 11'),
  ('Android 10');

INSERT INTO `devicemgmt`.`device`
  (`DeviceTypeID`, `VersionID`)
VALUES
  (1, 1),
  (1, 2),
  (2, 3),
  (2, 4),
  (3, 4),
  (3, 5);

INSERT INTO `devicemgmt`.`location`
  (`LocationName`, `Capacity`, `NetworkID`)
VALUES
  ('Office 1', 15, 1561),
  ('Office 2', 15, 1660),
  ('Office 3', 10, 2158),
  ('Office 4', 10, 2483);

INSERT INTO `devicemgmt`.`role`
  (`Role`)
VALUES
  ('Support Agent'),
  ('Senior Support Agent'),
  ('Support Agent Manager');

INSERT INTO `devicemgmt`.`employee`
  (`EmployeeID`, `Name`, `RoleID`, `LocationID`)
VALUES
  (52, 'Ashley Tucker', 1, 1),
  (756, 'Jaime Black', 1, 1),
  (672, 'Erica Peterson', 1, 1),
  (392, 'Bessie Bell', 1, 1),
  (51, 'Glen Mckenzie', 1, 1),
  (299, 'Simon Patrick', 1, 1),
  (720, 'Courtney Torres', 1, 1),
  (57, 'Neil Ray', 1, 1),
  (473, 'Rachael Neal', 1, 1),
  (190, 'Warren Pearson', 1, 3),
  (784, 'Tiffany Ward', 1, 3),
  (983, 'Sam Castro', 2, 2),
  (328, 'Lamar Willis', 2, 2),
  (246, 'Maxine Wilkerson', 2, 2),
  (446, 'Dewey Watkins', 2, 2),
  (326, 'Blanca Lynch', 1, 2),
  (498, 'Elizabeth Terry', 1, 2),
  (58, 'Ismael Schneider', 1, 2),
  (150, 'Florence Malone', 3, 3),
  (233, 'Lynn Morgan', 3, 3),
  (91, 'James Burke', 3, 3),
  (29, 'Shelia Myers', 2, 3),
  (602, 'Elvira Rowe', 2, 2),
  (70, 'Kellie Reynolds', 1, 1),
  (566, 'Jody Blair', 1, 1);

INSERT INTO `devicemgmt`.`checkout`
  (`CheckOutID`, `DeviceID`, `EmployeeID`)
VALUES
  (98, 1, 52),
  (83, 1, 756),
  (96, 1, 672),
  (97, 1, 392),
  (69, 1, 51),
  (65, 1, 299),
  (13, 1, 720),
  (24, 1, 57),
  (28, 1, 473),
  (37, 1, 190),
  (36, 1, 784),
  (60, 1, 983),
  (22, 1, 328),
  (72, 1, 246),
  (55, 1, 446),
  (40, 1, 326),
  (30, 1, 498),
  (16, 1, 58),
  (8, 1, 150),
  (52, 1, 233),
  (94, 1, 91),
  (4, 2, 29),
  (63, 2, 602),
  (70, 2, 70),
  (57, 2, 566),
  (53, 3, 150),
  (3, 3, 233),
  (48, 3, 246),
  (73, 4, 446),
  (81, 4, 566),
  (6, 4, 566),
  (71, 5, 150),
  (67, 5, NULL),
  (74, 4, 299),
  (58, 4, 720);