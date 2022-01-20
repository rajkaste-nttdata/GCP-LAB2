--Exercise 8
--Find the top 10 committers in 2016 on Github repositories that uses the Java language
--Public Dataset: bigquery-public-data.github_repos
--Tables involved: languages, sample_commits

SELECT 
sc.committer.name as name, count(sc.repo_name) as count
FROM `bigquery-public-data.github_repos.languages`as l
JOIN `bigquery-public-data.github_repos.sample_commits` as sc
on l.repo_name = sc.repo_name,
UNNEST(language) as lg
where lg.name = "Java" and EXTRACT(YEAR FROM sc.committer.date)=2016
group by name
order by count desc 
limit 10
