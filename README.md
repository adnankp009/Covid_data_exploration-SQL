# COVID-19 Data Analysis

## Overview

This project involves analyzing COVID-19 data, focusing on various metrics such as total cases, new cases, total deaths, population, and vaccinations. The analysis aims to derive insights into the impact of COVID-19 on different locations, the infection and death rates, and the vaccination progress.

## Data Sources
The dataset can be downloaded from:https://ourworldindata.org/covid-deaths
The analysis utilizes two main datasets:
1. `coviddeath`: Contains information about COVID-19 cases, deaths, and population for various locations.
2. `covidvaccination`: Contains information about COVID-19 vaccinations for various locations.

## Queries and Analysis

### Basic Data Retrieval

```sql
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM sqlportfolio.coviddeath;
```
Retrieve basic COVID-19 data including total cases, new cases, total deaths, and population for various locations.

### Total Cases vs Total Deaths

```sql
SELECT location,
       date,
       total_cases,
       total_deaths,
       ROUND((total_deaths / total_cases) * 100, 3) AS death_percentage
FROM sqlportfolio.coviddeath;
```
Calculate the death percentage (chance of dying if contracted COVID-19) for all locations.

### Specific Country Analysis: India

```sql
SELECT location,
       date,
       total_cases,
       total_deaths,
       ROUND((total_deaths / total_cases) * 100, 3) AS death_percentage
FROM sqlportfolio.coviddeath
WHERE location IN ('India');
```
Analyze the death percentage for India specifically.

### Total Cases vs Population

```sql
SELECT location,
       date,
       total_cases,
       population,
       ROUND((total_cases / population) * 100, 3) AS infection_percentage
FROM sqlportfolio.coviddeath;
```
Calculate the infection percentage (chance of getting infected) for all locations.

### Highest Infection Rate

```sql
SELECT location,
       MAX(CAST(total_cases AS UNSIGNED)) AS total_cases,
       population,
       MAX(ROUND((total_cases / population) * 100, 3)) AS infection_percentage
FROM sqlportfolio.coviddeath
GROUP BY location
ORDER BY infection_percentage DESC;
```
Find the locations with the highest infection rates compared to the population.

### Highest Death Rate

```sql
SELECT location,
       MAX(CAST(total_deaths AS UNSIGNED)) AS total_deaths,
       population,
       MAX(ROUND((total_deaths / population) * 100, 3)) AS death_percentage
FROM sqlportfolio.coviddeath
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY death_percentage DESC;
```
Identify locations with the highest death rates.

### Death Count by Continent

```sql
SELECT continent,
       MAX(CAST(total_deaths AS UNSIGNED)) AS total_deaths,
       population,
       MAX(ROUND((total_deaths / population) * 100, 3)) AS death_percentage
FROM sqlportfolio.coviddeath
GROUP BY continent
ORDER BY death_percentage DESC;
```
Analyze the death count and death rate by continent.

### Continent with Highest Death Count

```sql
SELECT continent,
       MAX(CAST(total_deaths AS UNSIGNED)) AS total_deaths
FROM sqlportfolio.coviddeath
GROUP BY continent
ORDER BY total_deaths DESC;
```
Find the continent with the highest death count.

### Global Numbers

```sql
SELECT date,
       SUM(new_cases) AS total_cases,
       SUM(CAST(new_deaths AS UNSIGNED)) AS total_deaths,
       SUM(CAST(new_deaths AS UNSIGNED)) / SUM(new_cases) * 100 AS DeathPercentage
FROM sqlportfolio.coviddeath
GROUP BY date;
```
Calculate global COVID-19 cases, deaths, and death percentage.

### Total Population vs Vaccinations

#### Using Subquery

```sql
SELECT subquery.continent, 
       subquery.location, 
       subquery.date, 
       subquery.population, 
       subquery.new_vaccinations,
       subquery.RollingPeopleVaccinated,
       (subquery.RollingPeopleVaccinated / subquery.population) * 100 AS VaccinationPercentage
FROM (
    SELECT death.continent, 
           death.location, 
           death.date, 
           death.population, 
           vacc.new_vaccinations,
           SUM(CAST(vacc.new_vaccinations AS UNSIGNED)) OVER (
               PARTITION BY death.location 
               ORDER BY death.date
           ) AS RollingPeopleVaccinated
    FROM sqlportfolio.coviddeath AS death
    JOIN sqlportfolio.covidvaccination AS vacc
    ON death.location = vacc.location
    AND death.date = vacc.date
    WHERE death.continent IS NOT NULL
) AS subquery
ORDER BY subquery.location, subquery.date;
```
Analyze the percentage of the population that has received at least one COVID-19 vaccine dose using a subquery.

#### Using CTE

```sql
WITH PopvsVac AS (
    SELECT death.continent, 
           death.location, 
           death.date, 
           death.population, 
           vacc.new_vaccinations,
           SUM(CAST(vacc.new_vaccinations AS UNSIGNED)) OVER (
               PARTITION BY death.location 
               ORDER BY death.date
           ) AS RollingPeopleVaccinated
    FROM sqlportfolio.coviddeath AS death
    JOIN sqlportfolio.covidvaccination AS vacc
    ON death.location = vacc.location
    AND death.date = vacc.date
)
SELECT *,
       (RollingPeopleVaccinated / population) * 100 AS VaccinationPercentage
FROM PopvsVac
ORDER BY location, date;
```
Perform the same analysis using a Common Table Expression (CTE).

## Conclusion

This project demonstrates various SQL techniques for analyzing COVID-19 data, including calculating infection and death rates, identifying locations with the highest rates, and analyzing vaccination progress. The use of CTEs and window functions helps in breaking down complex queries into more manageable and readable parts.

## How to Run the Queries

1. Ensure you have access to the `sqlportfolio` database with `coviddeath` and `covidvaccination` tables.
2. Execute each query in your SQL environment to derive insights from the data.
3. Modify the queries as needed to focus on specific locations, dates, or other parameters.

By following these steps, you can perform detailed analyses of COVID-19 data and gain valuable insights into the pandemic's impact globally and locally.
