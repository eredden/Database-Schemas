/* 
  Queries for data retrieval in accordance with rubric parts 5-18 from
  Computer Science 204 - Assignment 1: Creating & Manipulating a Database.

  Created by Evan Redden, 06/17/2024. 
*/

/* 
  Query 1. Displays all content from the Clients table.

  1. Uses the SELECT command to retrieve all fields (*) FROM the client table.

  Output:
  ClientID  ClientFirstName  ClientLastName  ClientDOB  Occupation
  1         Kaiden           Hill            2006       Student
  2         Alina            Morton          2010       Student
  ... 77 more records ...
  80        Maia             Grant           1984       School Teacher
*/
SELECT * 
FROM client;

/*
  Query 2. Displays only the first name, last name, and occupation of clients in the client table.

  1. Uses the SELECT command to retrieve first name, last name, and occupation fields FROM the client table.

  Output:
  ClientFirstName  ClientLastName  Occupation
  Kaiden           Hill            Student
  Alina            Morton          Student
  ... 77 more records ...
  Maia             Grant           School Teacher
*/
SELECT `ClientFirstName`, `ClientLastName`, `Occupation` 
FROM client;

/* 
  Query 3. Displays names of clients that borrowed books during March 2018.

  1. Uses the SELECT command to get ClientIDs from the borrower table.
  2. Uses the WHERE command to check the borrower table for records with a BorrowDate field in March 2018.
  3. These collected ClientIDs are passed to the main SELECT/WHERE statement where their first and last names are selected and displayed.

  Output:
  ClientFirstName  ClientLastName
  Gerard           Jackson
  Tyler            Baker
  Angelina         Rowe
  Marcia           Rowe
  Carson           Byrne
  Katy             Lloyd
  Alysha           Lambert
  Maia             Grant
*/
SELECT `ClientFirstName`, `ClientLastName` 
FROM client
WHERE `ClientID` IN (
  SELECT `ClientID` 
  FROM borrower
  WHERE `BorrowDate` LIKE "2018-03-%"
);

/*
  Query 4. Retrieves the first and last names of the top 5 authors that clients borrowed from in 2017.

  1. SELECTS AuthorFirstName, AuthorLastName from author table. Also creates a COUNT() column for the TotalBorrows of each author.
  2. The FROM statement JOINs the borrower, book, and author tables together after ensuring all IDs match up across records.
  3. The records are checked via the WHERE statement to make sure they are all from 2017.
  4. Records are grouped by author fields and ordered by TotalBorrows, descending order.
  5. LIMIT 5 is used to only show five records, our top 5 authors.

  Output:
  AuthorFirstName  AuthorLastName  TotalBorrows
  Sofia            Smith           7
  Elena            Martin          7
  Logan            Moore           7
  Maria            Brown	         6
  Zoe              Roy             5
*/
SELECT
  `a`.`AuthorFirstName`,
  `a`.`AuthorLastName`,
  COUNT(*) AS `TotalBorrows`
FROM
  `library`.`borrower` `b`
  JOIN `library`.`book` `bk` ON `b`.`BookID` = `bk`.`BookID`
  JOIN `library`.`author` `a` ON `bk`.`AuthorID` = `a`.`AuthorID`
WHERE
  YEAR(`b`.`BorrowDate`) = 2017
GROUP BY
  `a`.`AuthorID`
ORDER BY
  `TotalBorrows` DESC
LIMIT 5;

/*
  Query 5. Nationalities of the least 5 authors that clients borrowed during the years 2015-2017 

  1. SELECTS AuthorNationality from author table. Additionally creates a COUNT() column for the TotalBorrows of each author.
  2. The FROM statement JOINs the borrower, book, and author tables together after ensuring all IDs match up across records.
  3. The records are checked via the WHERE statement to make sure they are all from 2015-2017.
  4. Records are grouped by AuthorFirstName, AuthorLastName, AuthorID fields and ordered by TotalBorrows, ascending order.
  5. LIMIT 5 is used to only show five records, our lowest 5 authors.

  Output:
  AuthorNationality  TotalBorrows
  Spain              3
  USA                5
  Canada             5
  USA                6
  Great Britain      6
*/
SELECT
  `a`.`AuthorNationality`,
  COUNT(*) AS `TotalBorrows`
FROM
  `library`.`borrower` `b`
  JOIN `library`.`book` `bk` ON `b`.`BookID` = `bk`.`BookID`
  JOIN `library`.`author` `a` ON `bk`.`AuthorID` = `a`.`AuthorID`
WHERE
  YEAR(`b`.`BorrowDate`) BETWEEN 2015 AND 2017
GROUP BY
  `a`.`AuthorID`
ORDER BY
  `TotalBorrows` ASC
LIMIT 5;

/*
  Query 6. Retrieves the book that was most borrowed during the years 2015-2017.

  1. SELECTS BookTitle from book table. Additionally creates a COUNT() column for the TotalBorrows of each book.
  2. The FROM statement JOINs the borrower and book tables together after ensuring all IDs match up across records.
  3. The records are checked via the WHERE statement to make sure they are all from 2015-2017.
  4. Records are grouped by BookID field and ordered by TotalBorrows, descending order.
  5. LIMIT 1 is used to only show one record.

  Output:
  BookTitle          TotalBorrows
  The perfect match  13
*/
SELECT
  `bk`.`BookTitle`,
  COUNT(*) AS `TotalBorrows`
FROM
  `library`.`borrower` `b`
  JOIN `library`.`book` `bk` ON `b`.`BookID` = `bk`.`BookID`
WHERE
  YEAR(`b`.`BorrowDate`) BETWEEN 2015 AND 2017
GROUP BY
  `b`.`BookID`
ORDER BY
  `TotalBorrows` DESC
LIMIT 1;

/*
  Query 7. Gets top borrowed genres for clients born in years 1970-1980.

  1. SELECTS Genre from book table. Additionally creates a COUNT() column for the TotalBorrows of each book.
  2. The FROM statement JOINs the borrower, book, and client tables together after ensuring all IDs match up across records.
  3. The records are checked via the WHERE statement to make sure clients are all born between 1970-1980.
  4. Records are grouped by BookID field and ordered by TotalBorrows, descending order.
  5. LIMIT 5 is used to only show top five records.

  Output:
  Genre       TotalBorrows
  Science     24
  Fiction     16
  Well being  15
  Humor       5
  Society     4
*/
SELECT
  `bk`.`Genre`,
  COUNT(*) AS `TotalBorrows`
FROM
  `library`.`borrower` `b`
  JOIN `library`.`book` `bk` ON `b`.`BookID` = `bk`.`BookID`
  JOIN `library`.`client` `c` ON `b`.`ClientID` = `c`.`ClientID`
WHERE
  `c`.`ClientDOB` BETWEEN 1970 AND 1980
GROUP BY
  `bk`.`Genre`
ORDER BY
  `TotalBorrows` DESC
LIMIT 5;

/*
  Query 8. Get top 5 occupations that borrowed the most in 2016.

  1. SELECTS Occupation from client table. Additionally creates a COUNT() column for the TotalBorrows of each occupation.
  2. The FROM statement JOINs the borrower and client tables together after ensuring all IDs match up across records.
  3. The records are checked via the WHERE statement to make sure the borrow records are from 2016.
  4. Records are grouped by Occupation field and ordered by TotalBorrows, descending order.
  5. LIMIT 5 is used to only show top five records.

  Output:
  Occupation           TotalBorrows
  Student              32
  Bus Driver           8
  Computer Programmer	 6
  Dentist              6
  Firefighter          5
*/
SELECT
  `c`.`Occupation`,
  COUNT(*) AS `TotalBorrows`
FROM
  `library`.`borrower` `b`
  JOIN `library`.`client` `c` ON `b`.`ClientID` = `c`.`ClientID`
WHERE
  YEAR(`b`.`BorrowDate`) = 2016
GROUP BY
  `c`.`Occupation`
ORDER BY
  `TotalBorrows` DESC
LIMIT 5;

-- Skipped queries 9-10.

/*
  Query 11. Get the top month of borrows in 2017.

  1. SELECT the month of BorrowDate from the borrower table and create the TotalBorrows count column.
  2. Filter out records not from 2017 with the WHERE statement.
  3. GROUP results by BorrowmOnth and ORDER BY TotalBorrows in descending order.
  4. LIMIT 1 to only show the highest result first.

  Output:
  BorrowMonth  TotalBorrows
  8            10
*/
SELECT
  MONTH(`BorrowDate`) AS `BorrowMonth`,
  COUNT(*) AS `TotalBorrows`
FROM
  `library`.`borrower`
WHERE
  YEAR(`BorrowDate`) = 2017
GROUP BY 
  `BorrowMonth`
ORDER BY
  `TotalBorrows` DESC
LIMIT 1;

-- Skipped query 12.

/*
  Query 13 (technically two queries). Gets the oldest and the youngest clients of the library.

  1. The two internal SELECT statements each grab the minimum and maximum ClientDOB values and their associated client records.
  2. The main SELECT statement takes these values and displays them. 
  3. The FROM statement specifies that we are using the client table.

  Output:
  YoungestClientID  OldestClientID
  12                2
*/
SELECT
  (SELECT ClientID 
    FROM client 
    WHERE ClientDOB = MIN(c.ClientDOB) 
    LIMIT 1) AS YoungestClientID,
  (SELECT ClientID 
    FROM client 
    WHERE ClientDOB = MAX(c.ClientDOB) 
    LIMIT 1) AS OldestClientID
FROM 
  library.client c;

-- Skipped query 14.