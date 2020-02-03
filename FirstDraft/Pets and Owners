#!/usr/bin/env python
# coding: utf-8

# In[ ]:


-- Database: animal_owner

-- DROP DATABASE animal_owner;

CREATE DATABASE animal_owner
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_United States.1252'
    LC_CTYPE = 'English_United States.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
	
# Ceating_a_tables
CREATE TABLE pets
(
	id SERIAL PRIMARY KEY,
	species VARCHAR(30),
	full_name VARCHAR(30),
	age INT
);

CREATE TABLE owners
(
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(30),
	last_name VARCHAR(30),
	city VARCHAR(30),
	state CHAR(2)
);

# Modifying_table
ALTER TABLE pets
ADD COLUMN owner_id INT;

# Returning_all_the_information_from_pets_table
SELECT * FROM pets;

# Adding_foreign_key_for_the_tables_created
ALTER TABLE pets
ADD CONSTRAINT fk_owner_pet
FOREIGN KEY (owner_id) REFERENCES owners(id)
MATCH FULL;

# Deleting_tables_if_necessary
DROP TABLE pets;
DROP TABLE owners;

# Inserting_data_into_the_tables
INSERT INTO owners (first_name, last_name, city, state)
VALUES ('Samuel', 'Smith', 'Boston', 'MA'), ('Emma', 'Johnson', 'Seattle', 'WA'),
	   ('John', 'Oliver', 'New York', 'NY'), ('Olivia', 'Brown', 'San Francisco', 'CA'),
	   ('Simon', 'Smith', 'Houston', 'TX');

SELECT * FROM owners;

INSERT INTO pets (species,full_name,age,owner_id)
VALUES ('Dog','Rex',6,1),('Rabbit','Fluffy',3,5),('Cat','Tom',8,2),
	   ('Mouse', 'Jerry',3,2),('Dog','Biggles',4,1),('Tortoise', 'Squirtle',42,3);

SELECT * FROM pets;

# Updating_data_for_Simon_Smith
SELECT * FROM owners;

UPDATE owners
SET city = 'Dallas'
WHERE city = 'Houston';

# Updating_multiple_rows_of_data
SELECT * FROM pets;

UPDATE pets
SET age = 2
WHERE age = 3;

# Deleting_data_from_table
DELETE FROM pets;

#_OR
DELETE FROM pets
WHERE full_name = 'Rex';

#_OR
DELETE FROM pets
WHERE species = 'Dog';

# Retrieving_data_from_data_base
SELECT * FROM owners;

SELECT first_name FROM owners;
SELECT first_name, last_name, state FROM owners;

# Filtering_data
SELECT * FROM pets
WHERE species = 'Dog';

SELECT species, full_name FROM pets
WHERE age = 2;

#_OR
SELECT species, full_name FROM pets
WHERE age = 2
AND species = 'Rabbit';

#_OR
SELECT species, full_name FROM pets
WHERE age = 2
OR species = 'Cat';

#_OR
SELECT species, full_name FROM pets
WHERE owner_id = 2
AND species = 'Cat'
AND full_name = 'Tom';

# Looking_for_two_or_more_values
SELECT * FROM owners
WHERE state IN ('WA', 'NY');

# Looking_for_many_values
SELECT * FROM pets
WHERE age IN (2,6,42);

SELECT * FROM pets
WHERE age NOT IN (2,6,42);

# String_pattern_searching
SELECT * FROM owners
WHERE last_name LIKE 'S%'

#_OR
SELECT * FROM owners
WHERE last_name LIKE 'S_'

#_OR
SELECT * FROM owners
WHERE last_name LIKE 'Smit_'

#_OR
SELECT * FROM owners
WHERE state LIKE '_A';

#_OR
SELECT * FROM pets
WHERE full_name LIKE '_e_';

#_OR
SELECT * FROM pets
WHERE full_name LIKE '%e%'; Looking_for_any_number_of_characters

# Using_Between_statement
SELECT * FROM pets
WHERE age BETWEEN 3 AND 7;

SELECT * FROM owners
WHERE last_name BETWEEN 'M' AND 'T';

# Defining_the_order_of_the_results
SELECT * FROM pets
ORDER BY age;

SELECT * FROM pets
ORDER BY age DESC;

SELECT * FROM pets
ORDER BY age ASC; # Same_as_the_default

# Ordering_by_non_numeric_columns
SELECT full_name, age FROM pets
ORDER BY full_name;

# Using_Where_clause_for_ordering_data
SELECT * FROM owners
WHERE last_name = 'Smith'
ORDER BY first_name;

# Selecting_distinct_values
SELECT DISTINCT species FROM pets;

SELECT DISTINCT age FROM pets;

SELECT DISTINCT * FROM pets;

# Column_name_Aliases
SELECT * FROM pets;
SELECT species, full_name AS name, age FROM pets;

# Joining_Tables_Together_and_Selecting_from_Multiple_Tables
SELECT owners.first_name, owners.last_name, pets.full_name FROM owners
JOIN pets ON owners.id = pets.owner_id;

# Another_way_to_write_previous_query_Inner_Join
SELECT o.first_name, o.last_name, p.full_name FROM owners o
JOIN pets p ON o.id = p.owner_id;

# Full_join_or_outter_join
SELECT o.first_name, o.last_name, p.full_name FROM owners o
FULL JOIN pets p ON o.id = p.owner_id;

# Left_Join
SELECT o.first_name, o.last_name, p.full_name FROM owners o
LEFT JOIN pets p ON o.id = p.owner_id;

SELECT o.first_name, o.last_name, p.full_name FROM pets p
LEFT JOIN owners o ON o.id = p.owner_id;

# Right_Join
SELECT o.first_name, o.last_name, p.full_name FROM pets p
RIGHT JOIN owners o ON o.id = p.owner_id;

SELECT o.first_name, o.last_name, p.full_name FROM owners o
RIGHT JOIN pets p ON o.id = p.owner_id;

