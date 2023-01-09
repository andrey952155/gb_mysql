USE vk;

-- Задача 1.
-- Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека,
-- который больше всех общался с нашим пользователем.
-- Найти человека, который больше всего написал нам

SELECT from_user_id
FROM messages
WHERE to_user_id = 1 AND from_user_id IN (
	SELECT initiator_user_id FROM friend_requests WHERE target_user_id = 1 AND status = 'approved'
	UNION 
	SELECT target_user_id FROM friend_requests fr WHERE initiator_user_id = 1 AND status = 'approved' 
)
GROUP BY from_user_id 
ORDER BY count(*) DESC 
LIMIT 1;
  


-- Задача 2.
-- Подсчитать общее количество лайков, которые получили пользователи младше 11 лет.

SELECT count(*) FROM likes
WHERE media_id IN 
	(SELECT id FROM media WHERE user_id IN 
		(SELECT user_id FROM profiles AS p WHERE birthday > DATE_SUB(now() , INTERVAL 11 YEAR) ));
		
-- Задача 3.
-- Определить кто больше поставил лайков (всего): мужчины или женщины.
	
SELECT count(*), (SELECT gender FROM profiles WHERE user_id = likes.user_id) AS gender 
FROM  likes
GROUP BY gender 
ORDER BY count(*) DESC;


	
	