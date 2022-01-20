--Exercise 5
--Find the top 10 users (the id) who answered the most questions.
--Public Dataset: bigquery-public-data.stackoverflow
--Table involved: posts_answers, users

SELECT users.id AS id_user,
COUNT(pa.owner_user_id) as count
FROM `bigquery-public-data.stackoverflow.users` users
JOIN
`bigquery-public-data.stackoverflow.posts_answers` pa
ON users.id=pa.owner_user_id
where EXTRACT (YEAR from pa.creation_date)=2010
group by id_user
ORDER BY count DESC
LIMIT 10
