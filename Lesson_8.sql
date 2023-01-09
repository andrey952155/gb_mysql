USE vk;

-- ������ 1.
-- ����� ����� ��������� ������������. �� ���� ������ ����� ������������ ������� ��������,
-- ������� ������ ���� ������� � ��������� ������������� (������� ��� ���������).
-- ������ 3,4,10

SELECT m.from_user_id, fr.initiator_user_id, fr.target_user_id, fr.status, m.body  FROM messages m
JOIN friend_requests fr ON
(m.from_user_id = fr.initiator_user_id AND fr.target_user_id = 1)
OR 
(m.from_user_id = fr.target_user_id AND fr.initiator_user_id = 1)
WHERE fr.status = 'approved'
GROUP BY from_user_id 
ORDER BY count(*) DESC
LIMIT 1;


-- ������ 2.
-- ���������� ����� ���������� ������, ������� �������� ������������ ������ 11 ���.

SELECT count(*) FROM likes l 
JOIN media m ON l.media_id = m.id 
JOIN profiles p ON m.user_id = p.user_id AND birthday > DATE_SUB(now() , INTERVAL 11 YEAR);


-- ������ 3.
-- ���������� ��� ������ �������� ������ (�����): ������� ��� �������.

SELECT count(*) FROM likes l 
JOIN profiles p ON l.user_id = p.user_id 
GROUP BY gender 
ORDER BY count(*) DESC;



