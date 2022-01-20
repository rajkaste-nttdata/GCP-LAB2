--Exercise 2
--Show a flat result of the pages visited on 1 st August 2017
--Public Dataset: bigquery-public-data.google_analytics_sample
--Table involved: ga_sessions_20170801

SELECT
visitid,visitStartTime,h.page.pageTitle as pageTitle ,h.page.pagePath as pagePath
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20170801`,
UNNEST(hits) AS h;
