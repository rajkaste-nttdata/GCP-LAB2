/*
For Creating a new table for Query result, add 
CREATE or REPLACE TABLE `dataset.tableID` at the beginning of the query

CREATE OR REPLACE TABLE `uc1_18.myTable1`
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
    WHERE device.isMobile = TRUE 
    group by country,operatingSystem,browser
)
WHERE country NOT like '(%)'
GROUP BY country
)
SELECT * FROM country_from
ORDER BY country
