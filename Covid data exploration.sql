select location,date,total_cases,new_cases,total_deaths,population
from sqlportfolio.coviddeath;

-- Total cases vs Total deaths
-- Showing the chance of dying if contracted covid in india
select location,
date,
total_cases,total_deaths,
round((total_deaths/total_cases)*100,3) as death_percentage
from sqlportfolio.coviddeath;

-- Showing the chances of dying in a specific country
select location,
date,
total_cases,total_deaths,
round((total_deaths/total_cases)*100,3) as death_percentage
from sqlportfolio.coviddeath
where location in ('india');

-- Total cases vs Population
-- Showing the chance of getting effected 
select location,
date,
total_cases,population,
round((total_cases/population)*100,3) as infection_percentage
from sqlportfolio.coviddeath;

-- Looking at coutries with highest infection rate compared to population
select location,
max(cast(total_cases as unsigned)) as total_cases,
population,
max(round((total_cases/population)*100,3)) as infection_percentage
from sqlportfolio.coviddeath
group by location
order by infection_percentage desc;

-- show countries with highest death rate
select location,
max(cast(total_deaths as unsigned)) as total_deaths,
population,
max(round((total_deaths/population)*100,3)) as death_percentage
from sqlportfolio.coviddeath
where continent is not null
group by location
order by death_percentage desc;

-- death count by continent
select continent,
max(cast(total_deaths as unsigned)) as total_deaths,
population,
max(round((total_deaths/population)*100,3)) as death_percentage
from sqlportfolio.coviddeath
group by continent
order by death_percentage desc;

-- Showing the continent with highest death count
select continent,
max(cast(total_deaths as unsigned)) as total_deaths
from sqlportfolio.coviddeath
group by continent
order by total_deaths desc;

-- Global Numbers
Select date,SUM(new_cases) as total_cases, SUM(cast(new_deaths as unsigned)) as total_deaths, SUM(cast(new_deaths as unsigned))/SUM(New_Cases)*100 as DeathPercentage
From sqlportfolio.coviddeath
Group By date;

-- Total Population vs Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

select
    subquery.continent, 
    subquery.location, 
    subquery.date, 
    subquery.population, 
    subquery.new_vaccinations,
    subquery.RollingPeopleVaccinated,
    (subquery.RollingPeopleVaccinated / subquery.population) * 100 AS VaccinationPercentage
from (
    select 
        death.continent, 
        death.location, 
        death.date, 
        death.population, 
        vacc.new_vaccinations,
        SUM(CAST(vacc.new_vaccinations as unsigned)) over (partition by  death.Location order by death.date) as RollingPeopleVaccinated
    from 
        sqlportfolio.coviddeath as death
    join 
        sqlportfolio.covidvaccination as vacc
    on 
        death.location = vacc.location
    and 
        death.date = vacc.date
    where 
        death.continent IS NOT NULL
) as subquery
order by 
    subquery.location, 
    subquery.date;

-- Using CTE to perform Calculation on Partition By in previous query

with PopvsVac as (
    select 
        death.continent, 
        death.location, 
        death.date, 
        death.population, 
        vacc.new_vaccinations,
        SUM(CAST(vacc.new_vaccinations as unsigned)) over (
            partition by death.location 
            order by death.date
        ) as RollingPeopleVaccinated
    from 
        sqlportfolio.coviddeath as death
    join 
        sqlportfolio.covidvaccination as vacc
    on 
        death.location = vacc.location
    and 
        death.date = vacc.date
)
select
    *,
    (RollingPeopleVaccinated / population) * 100 as VaccinationPercentage
from 
    PopvsVac
order by 
    location, date;


