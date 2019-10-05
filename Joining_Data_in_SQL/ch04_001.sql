SELECT name, fert_rate 
from states
where continent = 'Asia';


select name, fert_rate
from states
where continent = 'Asia'
and fert_rate < 
(select avg(fert_rate)
from states);


select distinct continent
from prime_ministers;


select distinct continent,
(select count(*) from states
where prime_ministers.continent = states.continents) as countries_num
from prime_ministers;


 -- Calculating the average life expectancy across all countries for 2015.
 
 -- Select average life_expectancy
select avg(life_expectancy)
  -- From populations
  from populations
-- Where year is 2015
where year = 2015;

-----------------------------------------------------------

-- Select fields
select *
  -- From populations
  from populations
-- Where life_expectancy is greater than
where life_expectancy > 
  -- 1.15 * subquery
  1.15 * (select avg(life_expectancy)
   from populations
   where year = 2015) and
   year = 2015;


-- 2. Select fields
select name, country_code, urbanarea_pop
  -- 3. From cities
  from cities
-- 4. Where city name in the field of capital cities
where name IN
  -- 1. Subquery
  (select capital
   from countries)
ORDER BY urbanarea_pop DESC;


--------------------------------------------------------------
/*
SELECT countries.name AS country, COUNT(*) AS cities_num
  FROM cities
    INNER JOIN countries
    ON countries.code = cities.country_code
GROUP BY country
ORDER BY cities_num DESC, country
LIMIT 9;
*/

 
SELECT countries.name AS country,
  (SELECT count(*) as cities_num
   FROM cities
   WHERE countries.code = cities.country_code) AS cities_num
FROM countries
ORDER BY cities_num DESC, country
LIMIT 9;

-- Subquery inside the from clause...

select continent, max(women_parli_perc) as max_perc
from states
group by continent
order by continent;


-- Focusing on records in monarchs...
select monarchs, continent
from monarchs, states
where monarchs.continents = states.continent
order by continent;


select distinct monarchs.continent, subquery.max_perc
from monarchs,
(select continent, max(women_parli_perc) as max_perc
from states group by countinent) as subquery
where monarchs.continent = subquery.continent
order by continent;


-- Select fields (with aliases)
select code, count(*) as lang_num
  -- From languages
  from languages
-- Group by code
group by code;


-- Select fields
select local_name, subquery.lang_num
  -- From countries
  from countries,
  	-- Subquery (alias as subquery)
  	(select code, count(*) as lang_num
  	 from languages
  	 group by code) AS subquery
  -- Where codes match
  where countries.code = subquery.code
-- Order by descending number of languages
order by lang_num desc;


--------------------------------------------------------------

-- Which country had the maximum inflation rate?

-- Select fields
select name, continent, inflation_rate
  -- From countries
  from countries
  	-- Join to economies
  	inner join economies 
    -- Match on code
    using (code)
-- Where year is 2015
where year = 2015;




-- Select fields
select max(inflation_rate) as max_inf
  -- Subquery using FROM (alias as subquery)
  FROM (
      select name, continent, inflation_rate
      from countries
      inner join economies
      using (code)
      where year = 2015) AS subquery
-- Group by continent
group by continent;



-- Select fields
select name, continent, inflation_rate
  -- From countries
  from countries
	-- Join to economies
	inner join economies
	-- Match on code
	on countries.code = economies.code
  -- Where year is 2015
  where year = 2015
    -- And inflation rate in subquery (alias as subquery)
    and inflation_rate in (
        select max(inflation_rate) as max_inf
        from (
             select name, continent, inflation_rate
             from countries
             inner join economies
             using (code)
             where year = 2015) as subquery
        group by continent);
        
        

--------------------------------------------------------------------

-- Select fields
SELECT code, inflation_rate, unemployment_rate
  -- From economies
  FROM economies
  -- Where year is 2015 and code is not in
  WHERE year = 2015 AND code not in
  	-- Subquery
  	(SELECT code
  	 FROM countries
  	 WHERE (gov_form = 'Constitutional Monarchy' OR gov_form LIKE '%Republic%'))
-- Order by inflation rate
ORDER BY inflation_rate;


--------------------------------------------------------------------

-- Select fields
SELECT DISTINCT name, total_investment, imports
  -- From table (with alias)
  FROM countries AS c
    -- Join with table (with alias)
    LEFT JOIN economies AS e
      -- Match on code
      ON (c.code = e.code
      -- and code in Subquery
        AND c.code IN (
          SELECT l.code
          FROM languages AS l
          WHERE official = 'true'
        ) )
  -- Where region and year are correct
  WHERE region = 'Central America' AND year = 2015
-- Order by field
ORDER BY name;


--------------------------------------------------------------------


-- Select fields
SELECT region, continent, AVG(fertility_rate) AS avg_fert_rate
  -- From left table
  FROM countries AS c
    -- Join to right table
    INNER JOIN populations AS p
      -- Match on join condition
      ON c.code = p.country_code
  -- Where specific records matching some condition
  WHERE year = 2015
-- Group appropriately?
GROUP BY region, continent
-- Order appropriately
ORDER BY avg_fert_rate;




-- Select fields
SELECT name, cities.country_code, city_proper_pop, metroarea_pop,  
      -- Calculate city_perc
      metroarea_pop / city_proper_pop * 100 AS city_perc
  -- From appropriate table
  FROM cities
  -- Where 
  WHERE name IN
    -- Subquery
    (SELECT capital
     FROM countries
     WHERE (continent = 'Europe'
        OR continent LIKE '%America'))
       AND metroarea_pop IS not null
-- Order appropriately
ORDER BY city_perc desc
-- Limit amount
limit 10;