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








