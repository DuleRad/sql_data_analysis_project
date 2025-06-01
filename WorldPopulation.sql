--1. List the top 10 most populated countries in 2022.
SELECT TOP 10 Country_Territory, _2022_Population FROM world_population
ORDER BY _2022_Population DESC;

--2. Show all countries in Asia with a population over 100 million in 2022.
SELECT * FROM world_population
WHERE Continent = 'Asia' AND _2022_Population > 100000000;

--3. What is the average population density by continent?
SELECT Continent, AVG(Density_per_km) AS Density_By_Continent FROM world_population
GROUP BY Continent;

--4. Which country has the highest population growth rate?
SELECT TOP 1 Country_Territory, Growth_Rate FROM world_population
ORDER BY Growth_Rate DESC;

--5. Find countries where the capital starts with the letter "B".
SELECT Country_Territory FROM world_population
WHERE Capital LIKE 'B%';

--6. What is the total 2022 population by continent?
SELECT Continent, SUM(CAST(_2022_Population AS BIGINT)) AS Total_2022_Population FROM world_population
GROUP BY Continent;

--7. Calculate the average population growth rate per continent.
SELECT Continent, AVG(Growth_Rate) AS Avg_Growth_Rate FROM world_population
GROUP BY Continent;

--8. Count the number of countries per continent.
SELECT Continent, COUNT(Country_Territory) AS Country_Number_Per_Continent FROM world_population
GROUP BY Continent;

--9. Find the average area per country for each continent.
SELECT Continent, AVG(Area_km) AS Average_Area_Per_Country_Km FROM world_population
GROUP BY Continent;

--10. Which continents have the most land area in total?
SELECT Continent, SUM(Area_km) AS Sum_Area_Per_Continent FROM world_population
GROUP BY Continent
ORDER BY Sum_Area_Per_Continent DESC;

--11. Which countries have more than doubled their population since 1970?
SELECT Country_Territory FROM world_population
WHERE _2022_Population > _1970_Population * 2;

--12. Show the population trend (growth) from 2000 to 2022 for each country.
SELECT Country_Territory, (_2022_Population - _2000_Population) AS Population_Growth_2000_To_2022  FROM world_population;

--13. Find the top 5 countries with the highest population increase from 2010 to 2022.
SELECT TOP 5 Country_Territory, (_2022_Population - _2010_Population) AS Population_Increase  FROM world_population
ORDER BY (_2022_Population - _2010_Population) DESC;

--14. Calculate the population change (absolute and percentage) from 2020 to 2022.
SELECT Country_Territory, _2020_Population, _2022_Population, (_2022_Population - _2020_Population) AS Absolute_Change,
    ROUND(((CAST(_2022_Population AS FLOAT) * 100) / _2020_Population) - 100, 2) AS Percentage_Change
FROM
    world_population;

--15. Identify countries where the population decreased from 2010 to 2022.
SELECT Country_Territory FROM world_population
WHERE _2010_Population > _2022_Population;

--16. What are the top 5 most densely populated countries?
SELECT TOP 5 Country_Territory, Density_per_km FROM world_population
ORDER BY Density_per_km DESC;

--17. What are the bottom 5 least densely populated countries?
WITH Bottom AS (
	SELECT TOP 5 Country_Territory, Density_per_km FROM world_population
	ORDER BY Density_per_km ASC
)
SELECT * FROM Bottom;

--18. Which country has the highest population per square km in each continent?
WITH Ranked_Density AS (
    SELECT
        Continent,
        Country_Territory,
        (_2022_Population / Area_km) AS Population_Per_Square_Km,
        ROW_NUMBER() OVER (PARTITION BY Continent ORDER BY (_2022_Population * 1.0 / Area_km) DESC) AS rn
    FROM world_population
)
SELECT
    Continent,
    Country_Territory,
    Population_Per_Square_Km
FROM Ranked_Density
WHERE rn = 1;

--19. Find the smallest country (by area) in the world.
SELECT Country_Territory, Area_km AS Country_Area_Km FROM world_population
WHERE Area_km = (SELECT MIN(Area_km) FROM world_population);

--20. Show the largest 10 countries by land area and their 2022 populations.
SELECT TOP 10 Country_Territory, Area_km, _2022_Population FROM world_population
ORDER BY Area_km DESC;

--21. Identify countries whose 2022 population is less than their 2000 population.
SELECT Country_Territory FROM world_population
WHERE _2022_Population < _2000_Population;

--22.  Show countries where the growth rate is above 1% and population is above 50 million.
SELECT Country_Territory FROM world_population
WHERE Growth_Rate > 1.0 AND _2022_Population > 50000000;

--23. Compare the 1970 and 2022 populations for countries in Africa.
SELECT Country_Territory, _1970_Population, _2022_Population, (_2022_Population - _1970_Population) AS Population_Change FROM world_population
WHERE Continent = 'Africa';

--24. Calculate each country’s share of its continent’s total population in 2022.
SELECT
    Country_Territory,
    Continent,
    _2022_Population,
    SUM(CAST(_2022_Population AS BIGINT)) OVER (PARTITION BY Continent) AS Continent_Total_Population,
    ROUND((CAST(_2022_Population AS FLOAT) / SUM(CAST(_2022_Population AS BIGINT)) OVER (PARTITION BY Continent)) * 100, 2) AS Share_of_Continent_Percentage
FROM
    world_population;

--25. Find countries that have had a population growth every decade since 1970.
SELECT Country_Territory FROM world_population
WHERE _1970_Population < _1980_Population AND
      _1980_Population < _1990_Population AND
	  _1990_Population < _2000_Population AND
	  _2000_Population < _2010_Population AND
	  _2010_Population < _2020_Population AND
	  _2020_Population < _2022_Population;

--26. Rank countries by population within each continent.
SELECT Country_Territory, _2022_Population AS Africa_Population_2022 FROM world_population
WHERE Continent = 'Africa'
ORDER BY _2022_Population DESC;
SELECT Country_Territory, _2022_Population AS Asia_Population_2022 FROM world_population
WHERE Continent = 'Asia'
ORDER BY _2022_Population DESC;
SELECT Country_Territory, _2022_Population AS Europe_Population_2022 FROM world_population
WHERE Continent = 'Europe'
ORDER BY _2022_Population DESC;
SELECT Country_Territory, _2022_Population AS North_America_Population_2022 FROM world_population
WHERE Continent = 'North America'
ORDER BY _2022_Population DESC;
SELECT Country_Territory, _2022_Population AS Oceania_Population_2022 FROM world_population
WHERE Continent = 'Oceania'
ORDER BY _2022_Population DESC;
SELECT Country_Territory, _2022_Population AS South_America_Population_2022 FROM world_population
WHERE Continent = 'South America'
ORDER BY _2022_Population DESC;

--27. For each continent, find the country with the fastest and slowest growth rate.
SELECT Country_Territory, Growth_Rate AS Min_Max_Growth_Rate_Africa FROM world_population
WHERE Growth_Rate = (SELECT MAX(Growth_Rate) FROM world_population WHERE Continent = 'Africa')
UNION
SELECT Country_Territory, Growth_Rate FROM world_population
WHERE Growth_Rate = (SELECT MIN(Growth_Rate) FROM world_population WHERE Continent = 'Africa');

SELECT Country_Territory, Growth_Rate AS Min_Max_Growth_Rate_Asia FROM world_population
WHERE Growth_Rate = (SELECT MAX(Growth_Rate) FROM world_population WHERE Continent = 'Asia')
UNION
SELECT Country_Territory, Growth_Rate FROM world_population
WHERE Growth_Rate = (SELECT MIN(Growth_Rate) FROM world_population WHERE Continent = 'Asia');

SELECT Country_Territory, Growth_Rate AS Min_Max_Growth_Rate_Europe FROM world_population
WHERE Growth_Rate = (SELECT MAX(Growth_Rate) FROM world_population WHERE Continent = 'Europe')
UNION
SELECT Country_Territory, Growth_Rate FROM world_population
WHERE Growth_Rate = (SELECT MIN(Growth_Rate) FROM world_population WHERE Continent = 'Europe');

SELECT Country_Territory, Growth_Rate AS Min_Max_Growth_Rate_North_America FROM world_population
WHERE Growth_Rate = (SELECT MAX(Growth_Rate) FROM world_population WHERE Continent = 'North America')
UNION
SELECT Country_Territory, Growth_Rate FROM world_population
WHERE Growth_Rate = (SELECT MIN(Growth_Rate) FROM world_population WHERE Continent = 'North America');

SELECT Country_Territory, Growth_Rate AS Min_Max_Growth_Rate_Oceania FROM world_population
WHERE Growth_Rate = (SELECT MAX(Growth_Rate) FROM world_population WHERE Continent = 'Oceania')
UNION
SELECT Country_Territory, Growth_Rate FROM world_population
WHERE Growth_Rate = (SELECT MIN(Growth_Rate) FROM world_population WHERE Continent = 'Oceania');

SELECT Country_Territory, Growth_Rate AS Min_Max_Growth_Rate_South_America FROM world_population
WHERE Growth_Rate = (SELECT MAX(Growth_Rate) FROM world_population WHERE Continent = 'South America')
UNION
SELECT Country_Territory, Growth_Rate FROM world_population
WHERE Growth_Rate = (SELECT MIN(Growth_Rate) FROM world_population WHERE Continent = 'South America');

--28. Show the cumulative population by continent sorted by 2022 population descending.
SELECT Continent, SUM(CAST(_2022_Population AS BIGINT)) AS Total_Population_2022 FROM world_population
GROUP BY Continent
ORDER BY Total_Population_2022 DESC;

--29. Create a decade-wise rank for each country’s population change from 1970 to 2022.
WITH DecadeData AS (
    SELECT Country_Territory, Continent, 1970 AS Year, _1970_Population AS Population FROM world_population
    UNION ALL
    SELECT Country_Territory, Continent, 1980, _1980_Population FROM world_population
    UNION ALL
    SELECT Country_Territory, Continent, 1990, _1990_Population FROM world_population
    UNION ALL
    SELECT Country_Territory, Continent, 2000, _2000_Population FROM world_population
    UNION ALL
    SELECT Country_Territory, Continent, 2010, _2010_Population FROM world_population
    UNION ALL
    SELECT Country_Territory, Continent, 2015, _2015_Population FROM world_population
    UNION ALL
    SELECT Country_Territory, Continent, 2020, _2020_Population FROM world_population
    UNION ALL
    SELECT Country_Territory, Continent, 2022, _2022_Population FROM world_population
)
SELECT
	RANK() OVER (PARTITION BY Year ORDER BY Population DESC) AS Population_Rank,
	Country_Territory,
	Population,
    Year
FROM DecadeData
ORDER BY Year, Population_Rank;

--30. Compute the population growth ratio from 1970 to 2022 for each country.
SELECT 
    Country_Territory,
    _1970_Population AS Population_1970,
    _2022_Population AS Population_2022,
    ROUND(CAST(_2022_Population AS FLOAT) / NULLIF(_1970_Population, 0), 2) AS Growth_Ratio_1970_2022
FROM world_population
ORDER BY Growth_Ratio_1970_2022 DESC;

--31. Which countries have world population percantage above 2?
SELECT * FROM world_population
WHERE World_Population_Percentage > 2
ORDER BY Rank ASC;