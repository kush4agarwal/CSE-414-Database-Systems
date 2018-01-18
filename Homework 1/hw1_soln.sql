/*
Kushagra Agarwal
CSE 414
Homework 1
Fall 2017
Professor: Gang Luo
Date: 10/7/2017
*/


.header on
.mode column

/* Question 1a: Create a table Edges(Source,Destination) 
where both Source and Destination are integers.
*/

CREATE TABLE Edges (Source int, Destination int);

.table

/* Question 1b: Insert the tuples 
(10,5), (6,25), (1,3), (4, 4)
*/

INSERT INTO Edges (Source, Destination)
VALUES (10, 5), (6, 25), (1, 3), (4, 4);


.show

/* Question 1c: Write a SQL statement that 
returns all tuples. 

*/

SELECT * FROM Edges;

/*
Question 1d: Write a SQL statement that 
returns only column Source for all tuples

*/
SELECT Source FROM Edges;

/*
Question 1e: Write a SQL statement that 
returns all tuples where Source > Destination
*/

SELECT * FROM Edges
WHERE Source > Destination;

/*
Question 1f:Now insert the tuple ('-1','2000')
*/

INSERT INTO Edges (Source, Destination)
VALUES (-1, 2000);

.show

/* Question 2: Create a table called MyRestaurants 
with the following attribute
'Name of the restaurant': a varchar field
*/

CREATE TABLE MyRestaurants (
	name varchar(30),
	foodType varchar(30),
	distance int,
	date_of_last_visit varchar(30),
	iLike int
);


/*
Question 3: Insert at least five tuples using the 
SQL INSERT command five (or more) times. You should 
insert at least one restaurant you liked, at least 
one restaurant you did not like, and at least one 
restaurant where you leave the iLike field NULL.

*/

INSERT INTO MyRestaurants VALUES ("E.J Burger", "Burgers", "10", "2017-10-03", "1");
INSERT INTO MyRestaurants VALUES ("Joule", "Korean Fusion", "45", "2016-06-14", "1");
INSERT INTO MyRestaurants VALUES ("Udon", "Japanese", "12", "2014-06-10", "0");
INSERT INTO MyRestaurants VALUES ("Chipotle", "Mexican", "12", "2017-9-16", "NULL");
INSERT INTO MyRestaurants VALUES ("Cedars", "Indian", "7", "2017-03-01", "1");

/*
Question 4a: Write a SQL query that returns all restaurants in your table. 
Experiment with a few of SQLite's output formats: print the 
results in comma-separated form
*/

SELECT * FROM MyRestaurants;

.mode csv

SELECT * FROM MyRestaurants;

/*
Question 4b: print the results in list form, delimited by " | "
*/

.mode list
.separator "|"

SELECT * FROM MyRestaurants;


 /*
 Question 4c: print the results in column form, and make each column have width 15
 */

.mode column
.width 15 15 15 15 15 

SELECT * FROM MyRestaurants;

/*
Question 4d: for each of the formats above, try 
printing/not printing the column headers with the results

*/

/* Header ON */

.mode column
.header on
.separator ","
.mode csv
SELECT * FROM MyRestaurants;

.mode list
.separator "|"
SELECT * FROM MyRestaurants;

.mode column
.width 15 15 15 15 15
SELECT * FROM MyRestaurants;

/* Header OFF */

.mode column
.header OFF
.separator ","
.mode csv
SELECT * FROM MyRestaurants;

.mode list
.separator "|"
SELECT * FROM MyRestaurants;

.mode column
.width 15 15 15 15 15
SELECT * FROM MyRestaurants;

/* Question 5: Write a SQL query that returns only the name 
and distance of all restaurants within and including 20 minutes 
of your house. The query should list the restaurants in 
alphabetical order of names

*/

SELECT NAME, DISTANCE FROM MyRestaurants
WHERE DISTANCE < 20
ORDER BY DISTANCE ASC;

/*
Write a SQL query that returns all restaurants 
that you like, but have not visited since 
more than 3 months ago
*/

SELECT * FROM MyRestaurants
WHERE iLike = 1
AND date('now') - date(date_of_last_visit) >= 3;











