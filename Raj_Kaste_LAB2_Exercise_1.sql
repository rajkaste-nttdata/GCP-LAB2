--Exercise 1
--Given the shared file top_4000_movies_data.csv in resources folder
--1. Create a BigQuery table “Movie” (created via BigQuery UI)
--2. Find the top 10 highest budget films, year by year, from 2016 to 2020

with row_count as(
select year,Movie_Title,Production_Budget,RANK() OVER(PARTITION BY year order by Production_Budget DESC) AS rank
from
(SELECT
EXTRACT(YEAR FROM Release_Date) AS year,Movie_Title,Production_Budget
FROM `nttdata-c4e-bde.uc1_13.Movie`
where Release_Date BETWEEN '2016-01-01' and '2020-12-31'
)
)
SELECT
  year,Movie_Title,Production_Budget,rank
FROM row_count
WHERE rank < 11
ORDER BY year DESC,Production_Budget DESC
