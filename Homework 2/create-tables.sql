/*
Kushagra Agarwal
CSE 414
Homework 2
Fall 2017
Professor: Gang Luo
Date: 10/15/2017
*/


/*
PART A: Importing/Creating the Flights Database.
*/
.mode csv
.header ON
PRAGMA foreign_keys=ON;

/*
If the following table names, are
saved in the database, then it will
remove them.
*/

DROP TABLE IF EXISTS Flights;
DROP TABLE IF EXISTS Months;
DROP TABLE IF EXISTS Weekdays;
DROP TABLE IF EXISTS Carriers;


CREATE TABLE Carriers (
	cid varchar(5) PRIMARY KEY,
	name varchar(50)
);

.import carriers.csv Carriers

CREATE TABLE Months (
	mid varchar(5) PRIMARY KEY,
	month varchar(30)
);
.import months.csv Months


CREATE TABLE Weekdays (
	did integer PRIMARY KEY,
	day_of_week varchar(20)
);
.import weekdays.csv Weekdays
.table

CREATE TABLE Flights (
	fid integer PRIMARY KEY,
	year varchar(4),
	month_id integer, 
	day_of_month integer,
	day_of_week_id integer,
	carrier_id varchar(3),
	flight_num integer,
	origin_city varchar(30),
	origin_state varchar(30),
	dest_city varchar(30),
	dest_state varchar(30),
	departure_delay integer,
	taxi_out integer,
	arrival_delay integer,
	cancelled integer,
	actual_time varchar(5),
	distance varchar(6),
	FOREIGN KEY (carrier_id)
		REFERENCES Carriers(cid),
	FOREIGN KEY (month_id)
		REFERENCES Months(mid),
	FOREIGN KEY (day_of_week_id)
		REFERENCES Weekdays(did)
);
.import flights-small.csv Flights



