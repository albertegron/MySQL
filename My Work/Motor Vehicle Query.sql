## Lab - Module4, DML and DDL

# 1. CREATE and USE Database Statements
create database lab4 ;
use lab4 ;

# 2. CREATE TABLE and ALTER TABLE commands
CREATE TABLE Drivers (did integer , dname char (20) , age integer , dyear integer );
ALTER TABLE Drivers ADD PRIMARY KEY( did );
DESCRIBE Drivers ;

CREATE TABLE Cars ( cid integer primary key , brand varchar (20) , color char (20) );
ALTER TABLE Cars CHANGE COLUMN color colour varchar(20) AFTER cid ;
DESCRIBE Cars ;

CREATE TABLE Reserves (did integer , cid integer , day date );
ALTER TABLE Reserves ADD PRIMARY KEY (did , cid , day);
ALTER TABLE Reserves ADD CONSTRAINT fk_did FOREIGN KEY ( did ) REFERENCES Drivers ( did);
ALTER TABLE Reserves ADD CONSTRAINT fk_cid FOREIGN KEY ( cid ) REFERENCES Cars ( cid );
ALTER TABLE Reserves ADD UNIQUE unique_day ( day );
DESCRIBE Reserves ;

ALTER TABLE Cars MODIFY brand varchar (20) NOT NULL ;
DESCRIBE Cars ;

# 3. RENAME TABLE and DROP TABLE
CREATE TABLE test (id integer );
RENAME TABLE test TO another_test ;
SHOW TABLES ;
DROP TABLE another_test ;

INSERT INTO Drivers VALUES (101 , 'Alan ' , 41, 25) ;
INSERT INTO Drivers VALUES (103 , 'Bob ', 50, 30) ;
INSERT INTO Drivers VALUES (104 , 'Carol ', 63, 45) ;
INSERT INTO Drivers VALUES (106 , 'David ', 72, 55) ;
SELECT * FROM Drivers ;

# 4. SELECT statement aliases and WHERE clause
SELECT dname , age FROM Drivers ;
SELECT d. dname AS driver_name , d.age AS driver_age FROM Drivers AS d;
SELECT did , dname FROM Drivers WHERE age > 50;

# 5. SELECT statement ORDER BY
SELECT * FROM Drivers ORDER BY age;
INSERT INTO Cars VALUES (18 , 'red ', 'BMW ');
INSERT INTO Cars VALUES (20 , 'blue ', 'Porsche ');
INSERT INTO Cars VALUES (21 , 'yellow ', 'Ferrari ');
INSERT INTO Reserves VALUES (106 , 18, '2016 -09 -08 ');
INSERT INTO Reserves VALUES (103 , 20, '2016 -09 -02 ');

# 6. SQL Join, Group By, and Sub-query Statements
SELECT d. dname FROM Drivers AS d, Reserves AS r WHERE r. cid = 18 AND r. did = d.did;

# 7. SELECT statement aggregation functions
SELECT min( age ) FROM Drivers ;
SELECT avg( age ) FROM Drivers ;
INSERT INTO Drivers VALUES (107 , 'Edward ', 51, 25) ;
INSERT INTO Drivers VALUES (108 , 'Frank ', 73, 45) ;
SELECT * FROM Drivers ;

# 8. SELECT statement GROUP BY and HAVING clauses
SELECT dyear , min (age) FROM Drivers GROUP BY dyear ;
SELECT dyear , min (age) FROM Drivers GROUP BY dyear HAVING min( age ) > 55;
SELECT * FROM Drivers WHERE age IS NOT NULL ;

# 9. SELECT statement sub-queries
SELECT * FROM Drivers WHERE did IN ( SELECT did FROM Reserves );
SELECT * FROM Drivers AS d WHERE EXISTS ( SELECT * FROM Reserves AS r WHERE r.did = d.did);

# 10. LEFT OUTER JOIN operation
SELECT * FROM Drivers AS d LEFT OUTER JOIN Reserves AS r ON d. did = r.did;

# 11. Views and Triggers
CREATE VIEW CarsForDrivers AS 
	SELECT c.brand , d.dname FROM Cars AS c, Reserves AS r, Drivers AS d 
    WHERE r.cid = c. cid AND r. did = d.did;
SELECT * FROM CarsForDrivers ;

# 12. CREATE TRIGGER and DROP TRIGGER
CREATE TRIGGER ageCheck BEFORE INSERT ON Drivers
FOR EACH ROW SET NEW. did = IF ( NEW .age < 16, NULL , NEW . did);
INSERT INTO Drivers VALUES (102 , 'Billy ', 15, 1);
DROP TRIGGER ageCheck ;

CREATE TRIGGER dyearAdjust BEFORE INSERT ON Drivers
FOR EACH ROW SET NEW. dyear = IF (( NEW . age - NEW . dyear ) < 16, ( NEW .age - 16) , NEW . dyear );
INSERT INTO Drivers VALUES (102 , 'Fred ', 25, 20) ;
SELECT * FROM Drivers WHERE did = 102;
