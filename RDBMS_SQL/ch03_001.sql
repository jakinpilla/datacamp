-- Rename the university_shortname column to id
alter table universities 
rename column university_shortname to id;

-- Make id a primary key
alter table universities
add constraint university_pk primary key (id);

-- Add the new column to the table
ALTER TABLE professors 
add column id serial;

-- Make id a primary key
ALTER table professors 
add CONSTRAINT professors_pkey primary key (id);

-- Have a look at the first 10 rows of professors
select * from professors limit 10;

-- Count the number of distinct rows with columns make, model
select count(distinct(make, model))
FROM cars;

-- Add the id column
ALTER TABLE cars
add  column id varchar(128);

-- Update id with make + model
UPDATE cars
set id = concat(make, model);

-- Make id a primary key
alter table cars
add constraint id_pk primary key(id);

-- Have a look at the table
SELECT * FROM cars;

-- Create the table
CREATE TABLE students (
  last_name varchar(128) NOT NULL,
  ssn integer PRIMARY KEY,
  phone_no char(12)
);