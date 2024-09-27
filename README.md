# Data-Cleaning-SQL

## Project Overview

This repository includes documentation and SQL queries that describe how I cleaned a dataset of layoffs that occurred between 2020 and 2023 in a variety of industries. 

## Data Overview 

### The dataset includes the following columns:
- **Company**: The name of the company where layoffs occurred.
- **Location**: The geographical location of the company.
- **Industry**: The industry in which the company operates.
- **Total Laid Off**: The total number of employees laid off.
- **Percentage Laid Off**: The percentage of the workforce that was laid off.
- **Date**: The date when the layoffs were announced or took place.
- **Stage**: The stage of the company (e.g., startup, growth, etc.).
- **Country**: The country where the company is based.
- **Funds Raised (Millions):** The amount of funds raised by the company, measured in millions.

## Date Source 

The primary source of this analysis is the [layoffs.csv](https://github.com/StephenTheAnalyst/Data-Cleaning-SQL/blob/main/layoffs.csv). A file i got from a YouTuber's Github account.

## Tools
- MySQL Workbench

## Data Cleaning/Preparation
- Cloned the table (I didn't want to mess up the original table)
- Remove Duplicates using Windows Function & CTE
- Standardized the data using functions like trim, like, str_to_date and so on
- Filled and Deleted Null values
- Removing Unwanted rows and columns
  
## Exploratory Data Analysis

**I tried exploring the cleaned dataset to answer some questions, such as:**
 1. How does the percentage of layoffs vary across different industries? Are there particular industries experiencing higher or lower rates of layoffs?
 2. Which locations or countries have the highest total number of layoffs, and how does this correlate with the funds raised by companies in those regions?
 3. Is there a noticeable relationship between the amount of funds raised (in millions) and the total number of layoffs reported? Do companies with more funding tend to lay off more or 
    fewer employees?
 4. How does the stage of a company influence the percentage of layoffs and the total number of employees laid off?

## Data Analysis
click 👉[here](https://github.com/StephenTheAnalyst/Data-Cleaning-SQL/blob/main/Data%20Cleaning%20in%20Sql.sql)👈 to go through the data analysis codes.

## Results/Finding
In this project, i wasn't aiming at analizing the dataset, i was more concerned about practicing my data cleaning skills. 


### THANKS FOR FOLLOWING THROUGH ☺
