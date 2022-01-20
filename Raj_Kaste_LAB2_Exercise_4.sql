--Exercise 4
--1. Find the first 3 most used pairs of OS and Browser from mobile devices for each
--available country on 1 st August 2017
--2. Produce a new table with the query result
--Public Dataset: bigquery-public-data.google_analytics_sample
--Table involved: ga_sessions_20170801
--Tip: ARRAY_AGG functions can be useful
--(see: https://cloud.google.com/bigquery/docs/reference/standard-sql/aggregate_functions)

/*Point 2:
For Creating a new table for Query result, add 
CREATE or REPLACE TABLE `dataset.tableID` at the beginning of the query

CREATE OR REPLACE TABLE `uc1_13.resultTable`
(remaining query)
*/

with country_from as(
    SELECT country,ARRAY_AGG(STRUCT(
        operatingSystem ,browser,rank
        )LIMIT 3
    ) as country_rank
   FROM( SELECT geoNetwork.country as country,device.operatingSystem as operatingSystem,
    device.browser as browser,
    ROW_NUMBER()  OVER (
        PARTITION By geoNetwork.country
        ORDER BY (count(device.browser)*count(device.operatingSystem)) DESC
    ) AS rank
    FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20170801`
    WHERE device.isMobile = true 
    group by country,operatingSystem,browser
)
WHERE country NOT like '(%)'
GROUP BY country
)
SELECT * FROM country_from
ORDER BY country
