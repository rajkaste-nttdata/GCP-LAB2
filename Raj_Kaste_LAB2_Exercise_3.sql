--Exercise 3
--Find how many times a page it was visited in July 2017. Group by date the result
--Public Dataset: bigquery-public-data.google_analytics_sample
--Table involved: ga_sessions_201707* (wildcard)

SELECT CAST(date as DATE FORMAT 'YYYYMMDD') as date,
H.page.pagePath as pagePath,
count(H.page.pagePath) as counter
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`,
UNNEST(hits) AS H
group by date,pagePath
having pagePath like '/%'
order by date,counter DESC
