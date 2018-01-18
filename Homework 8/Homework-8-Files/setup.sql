-- Created a Customer table with the following attributes: 
-- A User ID
-- The full name
-- A unique login handle
-- A password that allows the user to login.

CREATE TABLE Customer (
	uid INT PRIMARY KEY,
	name varchar(50) NOT NULL,
	handle varchar(50) UNIQUE NOT NULL,
	password varchar(50) NOT NULL
);

-- Inserting dummy values to make it easier for testing. 

INSERT INTO Customer VALUES(1, 'Kush Agarwal', 'agarwk', 'agarwal01');
INSERT INTO Customer VALUES(2, 'James Bond', 'jb007', 'b0nd7');
INSERT INTO Customer VALUES(3, 'Tony Stark', 'tstark', 'iamironman');
INSERT INTO Customer VALUES(4, 'Bruce Banner', 'banner', 'iamhulk');