--Exercise 9
--Find for each commit on Github on a .c file of the Linux kernel, the previous and the next commit
--Public Dataset: bigquery-public-data.github_repos
--Table involved: sample_commits
--Tip: Lag and Lead functions can be useful
--(see: https://cloud.google.com/bigquery/docs/reference/standard-sql/navigation_functions)

SELECT repo_name, D.new_path as file,
committer.date as date,
LAG(commit) OVER(
    partition by D.new_path
    order by committer.date
) AS prev_commit,
commit,
LEAD(commit) OVER(
    partition by D.new_path
    order by committer.date
) AS next_commit
 FROM `bigquery-public-data.github_repos.sample_commits`,
 UNNEST(difference) D
 WHERE repo_name like '%linux' and D.new_path like '%kernel/acct.c'
