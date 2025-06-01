# Data Analysis of the world population dataset using SQL

## Overview

Analyzing global population data using SQL is the focus of the project, covering demographic trends across countries and continents from 1970 to 2022. The dataset includes columns such as total population by years, country, and continent, as well as land area, population density, and growth rates. The main goal is to extract meaningful insights from structured demographic data while demonstrating strong data analysis skills with SQL.

## Objectives

- Analyze Global Population Data
- Measure Population Distribution Across Continents
- Track Historical Population Growth by Country
- Build and Demonstrate SQL Analysis Skills

## Dataset

This project uses data from the Kaggle dataset:

- Dataset Link: [WorldPopulation Dataset](https://www.kaggle.com/datasets/iamsouravbanerjee/world-population-dataset)

## Schema

'''sql
Table: dbo.world_population

Columns:
- Rank: TINYINT
- CCA3: NVARCHAR(50)
- Country_Territory: NVARCHAR(50) [Primary Key]
- Capital: NVARCHAR(50)
- Continent: NVARCHAR(50)
- _2022_Population: INT
- _2020_Population: INT
- _2015_Population: INT
- _2010_Population: INT
- _2000_Population: INT
- _1990_Population: INT
- _1980_Population: INT
- _1970_Population: INT
- Area_km: INT
- Density_per_km: FLOAT
- Growth_Rate: FLOAT
- World_Population_Percentage: FLOAT
'''
