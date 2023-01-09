USE vk;

-- Задача 1.
-- Пусть задан некоторый пользователь. Из всех друзей этого пользователя найдите человека,
-- который больше всех общался с выбранным пользователем (написал ему сообщений).
-- друзья 3,4,10

SELECT m.from_user_id, fr.initiator_user_id, fr.target_user_id, fr.status, m.body  FROM messages m
JOIN friend_requests fr ON
(m.from_user_id = fr.initiator_user_id AND fr.target_user_id = 1)
OR 
(m.from_user_id = fr.target_user_id AND fr.initiator_user_id = 1)
WHERE fr.status = 'approved'
GROUP BY from_user_id 
ORDER BY count(*) DESC
LIMIT 1;


-- Задача 2.
-- Подсчитать общее количество лайков, которые получили пользователи младше 11 лет.

SELECT count(*) FROM likes l 
JOIN media m ON l.media_id = m.id 
JOIN profiles p ON m.user_id = p.user_id AND birthday > DATE_SUB(now() , INTERVAL 11 YEAR);


-- Задача 3.
-- Определить кто больше поставил лайков (всего): мужчины или женщины.

SELECT count(*) FROM likes l 
JOIN profiles p ON l.user_id = p.user_id 
GROUP BY gender 
ORDER BY count(*) DESC;



