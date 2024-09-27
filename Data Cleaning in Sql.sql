SELECT * FROM world_layoffs.layoffs_staging;

# REMOVING DUPLICATES

SELECT *,
ROW_NUMBER() OVER (PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,date,stage,country,funds_raised_millions) row_num
FROM world_layoffs.layoffs_staging;

WITH CTE as (
SELECT *,
ROW_NUMBER() OVER (PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,date,stage,country,funds_raised_millions) row_num
FROM world_layoffs.layoffs_staging
)

SELECT *
FROM CTE
WHERE row_num>1;

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER (PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,date,stage,country,funds_raised_millions) row_num
FROM world_layoffs.layoffs_staging;

SELECT *
FROM world_layoffs.layoffs_staging2;

SELECT *
FROM world_layoffs.layoffs_staging2
WHERE row_num >1;

DELETE
FROM layoffs_staging2
WHERE row_num >1;

SELECT *
FROM layoffs_staging2
WHERE row_num >1;

# STANDARDIZE THE DATA

UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT *
FROM layoffs_staging2;

SELECT DISTINCT industry
FROM layoffs_staging2
order by industry DESC;

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT country
FROM layoffs_staging2
order by country;

UPDATE layoffs_staging2
SET country = 'United State'
WHERE country LIKE 'United State%';

SELECT *
FROM layoffs_staging2;

SELECT 'date',
str_to_date(date,'%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET DATE = str_to_date(date,'%m/%d/%Y');

SELECT *
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
MODIFY COLUMN date  DATE;

SELECT *
FROM layoffs_staging2;

#NULL or BLANK VALUES

SELECT industry
FROM layoffs_staging2
ORDER BY industry ASC;

UPDATE layoffs_staging2
SET industry = null
WHERE industry = '';

SELECT industry
FROM layoffs_staging2
order by industry;

SELECT t1.industry, t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
 ON t1.company = t2.company 
WHERE t1.industry is NULL
AND t2.industry IS NOT NULL;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
 ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry is NULL 
 AND t2.industry IS NOT NULL;
 
  # REMOVING UNWANTED ROWS AND COLUMN 

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;

DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;

SELECT *
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

SELECT *
FROM layoffs_staging2;

/* SOME QUESTIONS TO ANSWER FROM THIS CLEANED DATA 

 QUESTION 1: How does the percentage of layoffs vary across different industries?
 Are there particular industries experiencing higher or lower rates of layoffs?
*/

SELECT industry, ROUND(AVG(percentage_laid_off)*100, 1) average_percentage_laid_off
FROM layoffs_staging2
WHERE industry IS NOT NULL
GROUP BY industry
ORDER BY 2;

/* Question 2: Which locations or countries have the highest total number of layoffs, and how does this correlate with the funds raised
 by companies in those regions? */

SELECT country, location, SUM(total_laid_off) total_laid_off, AVG(funds_raised_millions) avg_funds_raised
FROM layoffs_staging2
GROUP BY country,location
ORDER BY total_laid_off DESC
LIMIT 10;

/* Question 3: Is there a noticeable relationship between the amount of funds raised (in millions) and the total number of layoffs reported? 
Do companies with more funding tend to lay off more or fewer employees? */

SELECT company, SUM(total_laid_off) total_laid_off, SUM(funds_raised_millions) funds_in_millions
FROM layoffs_staging2
WHERE company IS NOT NULL
GROUP BY company
ORDER BY 2,3;

WITH t1 as (
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
 AND funds_raised_millions IS NULL
ORDER BY company),
 t2 as (
  SELECT *
  FROM layoffs_staging2)
  
  SELECT *
  FROM t1
  JOIN t2
   ON t1.company = t2.company
   AND t1.location = t2.location
 WHERE (t1.total_laid_off IS NULL AND t1.funds_raised_millions IS NULL) AND (t2.total_laid_off IS NOT NULL OR t2.funds_raised_millions IS NOT NULL);

DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
 AND funds_raised_millions IS NULL;
 
 SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
 AND funds_raised_millions IS NULL
ORDER BY company;

SELECT company, total_laid_off, funds_raised_millions
FROM layoffs_staging2
WHERE company IS NOT NULL 
 AND total_laid_off IS NOT NULL AND   funds_raised_millions
ORDER BY 3 DESC;

-- Question 4: How does the stage of a company influence the percentage of layoffs and the total number of employees laid off?

SELECT DISTINCT stage
FROM layoffs_staging2
WHERE stage is not NULL
ORDER BY stage;

SELECT stage, sum(total_laid_off) total_laid_off, avg(percentage_laid_off) avg_percentage
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

























