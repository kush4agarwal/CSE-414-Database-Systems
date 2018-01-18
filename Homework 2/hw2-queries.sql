/*
Kushagra Agarwal
CSE 414
Homework 2
Fall 2017
Professor: Gang Luo
Date: 10/15/2017
*/


-- Part B: SQL Queries;

/*
Question 1: Find the distinct flight numbers 
of all flights from Seattle to Boston by 
Alaska Airlines Inc. on Mondays. 
Also notice that, in the database, the 
city names include the state. So Seattle 
appears as Seattle WA. [3 rows]
RESULT: 
12
24
734
*/

SELECT DISTINCT f.flight_num from Flights f 
JOIN Carriers c ON c.cid = f.carrier_id
JOIN Weekdays w ON w.did = f.day_of_week_id
WHERE c.name = 'Alaska Airlines Inc.'
AND origin_city = 'Seattle WA'
AND dest_city = 'Boston MA'
AND w.day_of_week = 'Monday';



/*
Question 2: Find all flights from Seattle to 
Boston on July 15th 2015. Search only for 
itineraries that have one stop. 
Both legs of the flight must have occurred 
on the same day and must be with the same carrier. 
The total flight time (actual_time) of the entire 
itinerary should be less than 7 hours (but notice 
that actual_time is in minutes). For each itinerary, 
the query should return the name of the carrier, 
the first flight number, the origin and destination 
of that first flight, the flight time, the second 
flight number, the origin and destination of the 
second flight, the second flight time, and 
finally the total flight time. [488 rows]

Also, put the first 20 rows of your result 
right after your query as a comment.


RESULT: 

"American Airlines Inc.","Seattle WA",628083,"Chicago IL",228.0,"Chicago IL",664326,"Boston MA",122.0,350.0
"American Airlines Inc.","Seattle WA",628083,"Chicago IL",228.0,"Chicago IL",739569,"Boston MA",127.0,355.0
"American Airlines Inc.","Seattle WA",628083,"Chicago IL",228.0,"Chicago IL",646435,"Boston MA",128.0,356.0
"American Airlines Inc.","Seattle WA",628083,"Chicago IL",228.0,"Chicago IL",647630,"Boston MA",130.0,358.0
"American Airlines Inc.","Seattle WA",628083,"Chicago IL",228.0,"Chicago IL",649520,"Boston MA",133.0,361.0
"American Airlines Inc.","Seattle WA",628083,"Chicago IL",228.0,"Chicago IL",656448,"Boston MA",133.0,361.0
"American Airlines Inc.","Seattle WA",628083,"Chicago IL",228.0,"Chicago IL",631855,"Boston MA",137.0,365.0
"American Airlines Inc.","Seattle WA",628083,"Chicago IL",228.0,"Chicago IL",634038,"Boston MA",137.0,365.0
"American Airlines Inc.","Seattle WA",628083,"Chicago IL",228.0,"Chicago IL",638231,"Boston MA",150.0,378.0
"American Airlines Inc.","Seattle WA",628083,"Chicago IL",228.0,"Chicago IL",676155,"Boston MA",150.0,378.0
"American Airlines Inc.","Seattle WA",628176,"New York NY",322.0,"New York NY",687812,"Boston MA","",322.0
"American Airlines Inc.","Seattle WA",628176,"New York NY",322.0,"New York NY",687884,"Boston MA","",322.0
"American Airlines Inc.","Seattle WA",628176,"New York NY",322.0,"New York NY",687892,"Boston MA",54.0,376.0
"American Airlines Inc.","Seattle WA",628176,"New York NY",322.0,"New York NY",687849,"Boston MA",57.0,379.0
"American Airlines Inc.","Seattle WA",628176,"New York NY",322.0,"New York NY",687825,"Boston MA",60.0,382.0
"American Airlines Inc.","Seattle WA",628176,"New York NY",322.0,"New York NY",687859,"Boston MA",60.0,382.0
"American Airlines Inc.","Seattle WA",628176,"New York NY",322.0,"New York NY",687841,"Boston MA",63.0,385.0
"American Airlines Inc.","Seattle WA",628176,"New York NY",322.0,"New York NY",687819,"Boston MA",65.0,387.0
"American Airlines Inc.","Seattle WA",628176,"New York NY",322.0,"New York NY",687879,"Boston MA",67.0,389.0
"American Airlines Inc.","Seattle WA",628176,"New York NY",322.0,"New York NY",687868,"Boston MA",69.0,391.0
"American Airlines Inc.","Seattle WA",628176,"New York NY",322.0,"New York NY",687833,"Boston MA",70.0,392.0

*/
SELECT 
c.name, 
f1.origin_city, 
f1.fid,
f1.dest_city,
f1.actual_time,
f2.origin_city,
f2.fid,
f2.dest_city,
f2.actual_time,
f1.actual_time + F2.actual_time as total_flight_time
FROM Flights f1
JOIN Flights f2
ON f1.dest_city = f2.origin_city
AND f1.day_of_month = f2.day_of_month
AND f1.month_id = f2.month_id
AND f1.year = f2.year
AND f1.carrier_id = f2.carrier_id
JOIN Weekdays w
ON f1.day_of_week_id = w.did
JOIN Carriers c
ON f1.carrier_id = c.cid
JOIN Months m
ON f1.month_id = m.mid

WHERE F1.origin_city = "Seattle WA"
AND F2.dest_city = "Boston MA"
AND F1.day_of_month = 15
AND M.month = "July"
AND F1.year = 2015
AND total_flight_time < 420;


/*
Question 3: Find the day of the week with 
the longest average arrival delay. 
Return the name of the day and the average delay. [1 row]
*/

SELECT day_of_week, AVG(F.arrival_delay) arrival_delay
FROM Flights f
JOIN Weekdays w 
ON w.did = f.day_of_week_id
GROUP BY w.did
ORDER BY arrival_delay DESC
LIMIT 1;


/*
Question 4: Find the names of all airlines that 
ever flew more than 1000 flights in one day. 
Return only the names. Do not return any duplicates. [11 rows]

*/

SELECT DISTINCT c.name
FROM Flights f
JOIN Months m 
ON m.mid = f.month_id
JOIN Carriers c 
ON c.cid = f.carrier_id
GROUP BY f.day_of_month, f.year, m.month, c.name
HAVING COUNT(*) > 1000;


/*
Question 5: Find all airlines that had more 
than 0.5 percent of their flights out of Seattle 
be canceled. Return the name of the airline and 
the percentage of canceled flight out of Seattle. 
Order the results by the percentage of canceled 
flights in ascending order. [6 rows]
*/

SELECT c.name, AVG(f.cancelled) cancelled_percentage
FROM Flights f
JOIN Carriers c 
ON c.cid = f.carrier_id
WHERE f.origin_city = 'Seattle WA'
GROUP BY c.cid
HAVING cancelled_percentage > 0.005
ORDER BY cancelled_percentage ASC;


