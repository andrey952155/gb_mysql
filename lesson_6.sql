USE vk;

-- ������ 1.
-- ����� ����� ��������� ������������. �� ���� ������ ����� ������������ ������� ��������,
-- ������� ������ ���� ������� � ����� �������������.
-- ����� ��������, ������� ������ ����� ������� ���

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
  


-- ������ 2.
-- ���������� ����� ���������� ������, ������� �������� ������������ ������ 11 ���.

SELECT count(*) FROM likes
WHERE media_id IN 
	(SELECT id FROM media WHERE user_id IN 
		(SELECT user_id FROM profiles AS p WHERE birthday > DATE_SUB(now() , INTERVAL 11 YEAR) ));
		
-- ������ 3.
-- ���������� ��� ������ �������� ������ (�����): ������� ��� �������.
	
SELECT count(*), (SELECT gender FROM profiles WHERE user_id = likes.user_id) AS gender 
FROM  likes
GROUP BY gender 
ORDER BY count(*) DESC;


	
	