# COVID-19 Data Analysis

## Overview

This project involves analyzing COVID-19 data to derive insights into the impact of the pandemic on different locations, focusing on metrics such as total cases, new cases, total deaths, population, and vaccinations. The analysis aims to highlight infection and death rates, and vaccination progress.

## Data Sources

The analysis utilizes data from [Our World in Data](https://ourworldindata.org/covid-deaths), focusing on two main datasets:
1. `coviddeath`: Contains information about COVID-19 cases, deaths, and population for various locations.
2. `covidvaccination`: Contains information about COVID-19 vaccinations for various locations.

## Analysis Summary

### Basic Data Retrieval
Basic COVID-19 data including total cases, new cases, total deaths, and population for various locations were retrieved to form the foundation of the analysis.

### Total Cases vs Total Deaths
The death percentage, indicating the chance of dying if contracted COVID-19, was calculated for all locations. This provided insights into the severity of the disease in different regions.

### Specific Country Analysis: India
The death percentage was specifically analyzed for India to understand the impact of COVID-19 within the country.

### Total Cases vs Population
The infection percentage, indicating the chance of getting infected, was calculated for all locations. This helped in understanding how widespread the infection was relative to the population size.

### Highest Infection Rate
Locations with the highest infection rates compared to their population were identified. This highlighted regions with significant outbreaks.

### Highest Death Rate
Locations with the highest death rates were identified, providing insights into areas with severe outcomes due to the disease.

### Death Count by Continent
The death count and death rate were analyzed by continent to understand the impact of COVID-19 on different continents.

### Continent with Highest Death Count
The continent with the highest death count was identified, indicating the region most affected by fatalities.

### Global Numbers
Global COVID-19 cases, deaths, and death percentage were calculated to provide a worldwide perspective on the pandemic's impact.

### Total Population vs Vaccinations
The percentage of the population that received at least one COVID-19 vaccine dose was analyzed using both subqueries and Common Table Expressions (CTEs). This provided insights into vaccination progress across different regions.

## How to Run the Analysis

1. Ensure access to the `sqlportfolio` database, containing `coviddeath` and `covidvaccination` tables.
2. Use SQL queries to retrieve and analyze the data. Modify the queries as needed to focus on specific locations, dates, or other parameters.
3. The analysis covers basic data retrieval, infection and death rates, regional comparisons, and vaccination progress.

## Conclusion

This project demonstrates various SQL techniques for analyzing COVID-19 data, including calculating infection and death rates, identifying regions with significant impact, and evaluating vaccination progress. By following the outlined steps, you can perform detailed analyses of COVID-19 data and gain valuable insights into the pandemic's impact globally and locally.

## Data Source

The data for this analysis is sourced from [Our World in Data](https://ourworldindata.org/covid-deaths).
