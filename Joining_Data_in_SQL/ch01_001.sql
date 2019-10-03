SELECT p1.country, p1.continent, prime_minister, president
FROM prime_ministers AS p1
INNER JOIN presidents AS p2
ON p1.country = p2.country

SELECT *
FROM left_table
INNER JOIN right_table
ON left_table.id = right_table.id;

-- Select all columns from cities
select * from cities;


-- 1. Select name fields (with alias) and region 
SELECT cities.name as city, countries.name as country, countries.region
FROM cities
  INNER JOIN countries


-- 3. Select fields with aliases
SELECT c.code AS country_code, name, year, inflation_rate
FROM countries AS c
  -- 1. Join to economies (alias e)
  INNER JOIN economies AS e
    -- 2. Match on code
    ON c.code = e.code;
    
    
-- 4. Select fields
SELECT c.code, c.name, c.region, p.year, p.fertility_rate
  -- 1. From countries (alias as c)
  FROM countries as c
  -- 2. Join with populations (as p)
  INNER JOIN populations as p
    -- 3. Match on country code
    ON c.code = p.country_code
    
    
-- 6. Select fields
SELECT c.code, name, region, e.year, fertility_rate, unemployment_rate
  -- 1. From countries (alias as c)
  FROM countries AS c
  -- 2. Join to populations (as p)
  INNER JOIN populations AS p
    -- 3. Match on country code
    ON c.code = p.country_code
  -- 4. Join to economies (as e)
  INNER JOIN economies AS e
    -- 5. Match on country code and year
    ON c.code = e.code AND e.year = p.year;
    
    
    
    
SELECT p1.country AS country1, p2.country AS country2, p1.continent
FROM prime_ministers AS p1
INNER JOIN prime_ministers AS p2
ON p1.continent  = p2.continent AND p1.country <> p2.country
LIMIT 13;


SELECT name, continent, indep_year, 
CASE  WHEN indep_year < 1900 THEN 'before 1900'
      WHEN indep_year <= 1930 THEN 'between 1900 and 1930'
      ELSE 'after 1930' END
      AS indep_year_group
FROM states
ORDER BY indep_year_group





