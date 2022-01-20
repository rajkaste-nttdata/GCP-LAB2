--Exercise 6
--Find the top 10 StackOverflow users (the id) by accepted responses on 2010 posts
--Public Dataset: bigquery-public-data.stackoverflow
--Table involved: stackoverflow_posts, posts_answers, users

SELECT users.id AS id_user,
COUNT(*) as count
FROM `bigquery-public-data.stackoverflow.users` users
INNER JOIN `bigquery-public-data.stackoverflow.posts_answers` P
ON users.id=P.owner_user_id
INNER JOIN `bigquery-public-data.stackoverflow.stackoverflow_posts` S
ON S.accepted_answer_id=P.id
WHERE S.accepted_answer_id IS NOT NULL and 
EXTRACT (YEAR FROM S.creation_date)=2010
GROUP BY id_user
ORDER BY count DESC 
LIMIT 10
