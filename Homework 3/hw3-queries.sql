/*
Kushagra Agarwal
CSE 414
Homework 3
Fall 2017
Professor: Gang Luo
Date: 11/7/2017
*/

-- ************ PART C ***************** PART C ******** --

/*
Question 1: For each origin city, find 
the destination city (or cities) with 
the longest direct flight. By direct flight,
we mean a flight with no intermediate stops. 
Judge the longest flight in time, not distance. 
Show the name of the origin city, destination 
city, and the flight time between them. 
Do not include duplicates of the same 
origin/destination city pair. Order the 
result by origin_city name then destination 
city name. [333 rows]
*/

select distinct f.origin_city, f.dest_city, f.actual_time
from Flights f JOIN 
(select origin_city, max(actual_time) max from Flights
Group by origin_city) c
ON c.origin_city = f.origin_city AND
f.actual_time = c.max





/*
Question 2: Find all origin cities 
that only serve flights shorter than 
3 hours. You can assume that flights 
with NULL actual_time are not 3 hours 
or more. Return only the names of the 
cities sorted by name. List each city 
only once in the result. [147 rows]
*/

select distinct f.origin_city
from Flights f JOIN 
(select origin_city, max(actual_time) max from Flights
Group by origin_city) c
ON c.origin_city = f.origin_city AND
f.actual_time = c.max
where f.actual_time < 180.0



/*
Question 3: For each origin city, find 
the percentage of departing flights shorter 
than 3 hours. For this question, treat 
flights with null actual_time values as 
longer than 3 hours. Return the name of 
the city and the percentage value. 
Order by percentage value.
 Be careful to handle cities without 
 any flights shorter than 3 hours. 
 We will accept both 0 and NULL as the 
 result for those cities. [327 rows]
*/


select f.origin_city, 
(CAST(ct AS NUMERIC(10, 2)) * 100/ CAST(count(f.fid) 
	AS NUMERIC(10, 2))) percent
from Flights f
LEFT JOIN (select origin_city, count(fid) ct
from Flights 
where actual_time < 180.0 OR (actual_time IS NULL)
group by origin_city) c
ON f.origin_city = c.origin_city
group by f.origin_city, ct
order by percent ASC;


/*
Question 4: List all cities that cannot 
be reached from Seattle though a direct 
flight but can be reached with one stop 
(i.e., with two flights).
 Do not include Seattle as one of 
 these destinations (even though you could 
 get back with two flights). 
 Order results alphabetically. [256 rows]
*/

select c.dest_city
from Flights f
JOIN (select origin_city, dest_city from Flights
where dest_city != 'Seattle WA' 
AND dest_city NOT IN 

(SELECT dest_city from Flights 
where origin_city = 'Seattle WA')
group by origin_city, dest_city) c

ON f.dest_city = c.origin_city
where f.origin_city = 'Seattle WA' 
group by c.dest_city
order by c.dest_city;


/*
Question 5: List all cities that cannot 
be reached from Seattle though a direct 
flight nor with one stop (i.e., with two flights). 
Do not forget to consider all cities that 
appear in a flight as an origin_city. 
Order results alphabetically. [3 or 4 rows]
*/

select c.dest_city from 
(select dest_city 
from Flights 
where dest_city != 'Seattle WA' 
AND origin_city != 'Seattle WA') c

where c.dest_city NOT IN 
(select g.dest_city 
from Flights f
JOIN Flights g 
ON f.dest_city = g.origin_city 
AND f.dest_city = c.dest_city
where f.origin_city = 'Seattle WA')
group by c.dest_city
order by c.dest_city;


-- ************ PART D ***************** PART D ******** --


/* 
Question 1: 

Consider the following three queries:


SELECT DISTINCT carrier_id
FROM Flights
WHERE origin_city = 'Seattle WA' AND actual_time <= 180;


SELECT DISTINCT carrier_id
FROM Flights
WHERE origin_city = 'Gunnison CO' AND actual_time <= 180;


SELECT DISTINCT carrier_id
FROM Flights
WHERE origin_city = 'Seattle WA' AND actual_time <= 30;

*/

/*
Question 1(a): Choose one single simple 
index (index on one attribute) that is 
most likely to speed up all three queries. 
Write down the CREATE INDEX statements in 
your .sql file and explain why you chose that 
index in a SQL comment.
*/

create index indexOrigin_city on Flights (origin_city); 

/*
Question 1(b): Add this index to your database. 
For each of the three queries, indicate if 
SQL Server used the index; if not, give a 
short explanation why not. As a SQL comment, 
list the query numbers, if the index was used, 
and, if applicable, an explanation why the 
index was not used. Note that SQL Server creates 
and uses a clustered index, usually on the primary 
key of the table, by default. We only care about 
the index you create.
*/



/*
Question 2: Consider this query:

SELECT DISTINCT F2.origin_city
FROM Flights F1, Flights F2
WHERE F1.dest_city = F2.dest_city
  AND F1.origin_city='Gunnison CO'
  AND F1.actual_time <= 30;

Choose one simple index (index on one attribute), 
different from the index for the question above, 
that is likely to speed up this query. Write down 
the CREATE INDEX statement in hw3-queries.sql and 
explain why you chose that index as a SQL comment.
*/

create index indexActual_time on Flights(actual_time);

/*
Question 3: Add this second index to your database 
(you should already have the first one added),
and check that SQL Server indeed uses the index. 
If not, give a brief explanation why not.
*/



/*
Question 4: See how the queries from part 
C perform now that you have two indexes. 
Record the runtimes of the queries with 
and without indexes as a comment in 
hw3-queries.sql. Note that different 
instances of SQL Server can have a very 
different performance and that creating 
an index takes time.
*/


-- ************ PART E ***************** PART E ******** --


/*
Question: The DBMS that we use in this 
assignment is running somewhere in one 
of Microsoft's data centers. Comment on 
your experience using this DBMS cloud service. 
What do you think about the idea of offering 
a DBMS as a service in the cloud?

Answer: I believe that it is great that the DBMS is
running on the cloud, since it allows us to work with
massive files using the computational power that is present
on the cloud, without using our machines. Since the files that
are usually used for a DBMS are massive, our computers would be slow
and unable to cope with them. This would slow down the result of the
queries and taint the timings if they are necessary. It is not without
it's disadvantages though. Since it is on the cloud there is a need
for a constant connection to the cloud. An interruption in the network
can cause the querying to fail partway, and since the databases that
are used are massive, re-querying them can take a really long time.



*/






