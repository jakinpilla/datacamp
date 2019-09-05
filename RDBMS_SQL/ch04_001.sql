-- Rename the university_shortname column
ALTER TABLE professors
RENAME COLUMN university_shortname TO university_id;

-- Add a foreign key on professors referencing universities
alter table professors 
add constraint professors_fkey FOREIGN KEY (university_id) 
REFERENCES universities (id);


-- Try to insert a new professor
INSERT INTO professors (firstname, lastname, university_id)
VALUES ('Albert', 'Einstein', 'UZH');

-- As you can see, inserting a professor with non-existing university 
-- IDs violates the foreign key constraint you've just added. 
-- This also makes sure that all universities are spelled equally 
-- – adding to data consistency.

-- Select all professors working for universities in the city of Zurich
SELECT professors.lastname, universities.id, universities.university_city
from professors
join universities
ON professors.university_id = universities.id
where universities.university_city = 'Zurich';

-- Add a professor_id column
alter table affiliations
add COLUMN professor_id integer REFERENCES professors (id);

-- Rename the organization column to organization_id
alter table affiliations
rename organization TO organization_id;

-- Add a foreign key on organization_id
ALTER TABLE affiliations
ADD CONSTRAINT affiliations_organization_fkey FOREIGN KEY (organization_id)
REFERENCES organizations (id);

--
/*
UPDATE table_a
SET column_to_update = table_b.column_to_update_from FROM table_b
WHERE condition1 AND condition2 AND ...;
*/

-- Have a look at the 10 first rows of affiliations
select * from affiliations limit 10;

-- Update professor_id to professors.id 
-- where firstname, lastname correspond to rows in professors
UPDATE affiliations
SET professor_id = professors.id
FROM professors
WHERE affiliations.firstname = professors.firstname 
AND affiliations.lastname = professors.lastname;

-- Have a look at the 10 first rows of affiliations again
select * from affiliations limit 10;

-- Drop the firstname column
alter table affiliations
DROP column firstname;

-- Drop the lastname column
alter table affiliations
DROP column lastname;

-- Identify the correct constraint name
SELECT constraint_name, table_name, constraint_type
FROM information_schema.table_constraints
WHERE constraint_type = 'FOREIGN KEY';


-- Drop the right foreign key constraint
alter table affiliations
drop constraint affiliations_organization_id_fkey;

-- Add a new foreign key constraint from affiliations to organizations
-- which cascades deletion
ALTER TABLE affiliations
ADD CONSTRAINT affiliations_organization_id_fkey 
FOREIGN KEY (organization_id) REFERENCES organizations (id) 
ON DELETE CASCADE;

-- Delete an organization 
DELETE FROM organizations 
WHERE id = 'CUREM';

-- Check that no more affiliations with this organization exist
SELECT * FROM organizations
WHERE id = 'CUREM';

-- Count the total number of affiliations per university
SELECT count(*), professors.university_id 
FROM affiliations
JOIN professors
ON affiliations.professor_id = professors.id
GROUP BY professors.university_id 
order by count DESC;


-- Join all tables
SELECT *
FROM affiliations
JOIN professors
ON affiliations.professor_id = professors.id
JOIN organizations
ON affiliations.organization_id = organizations.id
JOIN universities
ON professors.university_id = universities.id;


-- Group the table by organization sector, professor and university
-- city
SELECT count(*), organizations.organization_sector, 
professors.id, universities.university_city
FROM affiliations
JOIN professors
ON affiliations.professor_id = professors.id
JOIN organizations
ON affiliations.organization_id = organizations.id
JOIN universities
ON professors.university_id = universities.id
GROUP BY organizations.organization_sector, 
professors.id, universities.university_city;

-- Filter the table and sort it
SELECT COUNT(*), organizations.organization_sector, 
professors.id, universities.university_city
FROM affiliations
JOIN professors
ON affiliations.professor_id = professors.id
JOIN organizations
ON affiliations.organization_id = organizations.id
JOIN universities
ON professors.university_id = universities.id
where organizations.organization_sector = 'Media & communication'
GROUP BY organizations.organization_sector, 
professors.id, universities.university_city
order by count DESC;