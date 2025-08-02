--------------------------------------------------------------------------------
-- 1. Top 10 countries by total refugees (all years)
--------------------------------------------------------------------------------
-- SUM of “Refugees (incl. refugee-like situations)” per country.
SELECT
  `Country / territory of asylum/residence` AS country,
  SUM(CAST(`Refugees (incl. refugee-like situations)` AS UNSIGNED)) AS total_refugees
FROM persons_of_concern
GROUP BY country
ORDER BY total_refugees DESC
LIMIT 10;

--------------------------------------------------------------------------------
-- 2. Yearly trend of overall displaced population
--------------------------------------------------------------------------------
-- SUM of “Total Population” per year to see growth/decline over time.
SELECT
  `Year` AS year,
  SUM(`Total Population`) AS displaced_total
FROM persons_of_concern
GROUP BY year
ORDER BY year;

--------------------------------------------------------------------------------
-- 3. Refugees vs. Internally Displaced Persons by country
--------------------------------------------------------------------------------
-- Compare sum of refugees vs. IDPs for each country.
SELECT
  `Country / territory of asylum/residence` AS country,
  SUM(CAST(`Refugees (incl. refugee-like situations)` AS UNSIGNED)) AS refugees,
  SUM(CAST(`Internally displaced persons (IDPs)` AS UNSIGNED)) AS idps
FROM persons_of_concern
GROUP BY country
HAVING (refugees + idps) > 10000   -- only large totals for clarity
ORDER BY (refugees + idps) DESC;

--------------------------------------------------------------------------------
-- 4. Percentage of asylum-seekers out of total population (by year)
--------------------------------------------------------------------------------
-- Calculates asylum-seeker share per year.
SELECT
  `Year` AS year,
  ROUND(
    SUM(CAST(`Asylum-seekers (pending cases)` AS UNSIGNED))
    / SUM(`Total Population`) * 100,
    2
  ) AS pct_asylum_seekers
FROM persons_of_concern
GROUP BY year
ORDER BY year;

--------------------------------------------------------------------------------
-- 5. Top 10 origin regions of displaced persons
--------------------------------------------------------------------------------
-- SUM of “Total Population” grouped by origin.
SELECT
  `Origin` AS origin,
  SUM(`Total Population`) AS total_from_origin
FROM persons_of_concern
GROUP BY origin
ORDER BY total_from_origin DESC
LIMIT 10;
