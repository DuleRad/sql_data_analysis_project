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

```sql
CREATE TABLE dbo.world_population (
    Rank TINYINT NOT NULL,
    CCA3 NVARCHAR(50) NOT NULL,
    Country_Territory NVARCHAR(50) NOT NULL,
    Capital NVARCHAR(50) NOT NULL,
    Continent NVARCHAR(50) NOT NULL,
    _2022_Population INT NOT NULL,
    _2020_Population INT NOT NULL,
    _2015_Population INT NOT NULL,
    _2010_Population INT NOT NULL,
    _2000_Population INT NOT NULL,
    _1990_Population INT NOT NULL,
    _1980_Population INT NOT NULL,
    _1970_Population INT NOT NULL,
    Area_km INT NOT NULL,
    Density_per_km FLOAT NOT NULL,
    Growth_Rate FLOAT NOT NULL,
    World_Population_Percentage FLOAT NOT NULL,

    CONSTRAINT PK_world_population PRIMARY KEY CLUSTERED (Country_Territory ASC)
);
```
