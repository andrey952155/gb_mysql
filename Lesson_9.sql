
-- USE example;

-- �������� �������������, ������� ������� �������� name �������� ������� �� ������� products
-- � ��������������� �������� �������� name �� ������� catalogs.

CREATE OR REPLACE VIEW products_catalogs AS
SELECT p.name AS catalogs, c.name FROM products p 
LEFT  JOIN catalogs c ON p.catalog_id = c.id;


-- �������� �������� ������� hello(), ������� ����� ���������� �����������, � ����������� �� �������� ������� �����.
-- � 6:00 �� 12:00 ������� ������ ���������� ����� "������ ����", � 12:00 �� 18:00 ������� ������ ���������� ����� "������ ����",
-- � 18:00 �� 00:00 � "������ �����", � 00:00 �� 6:00 � "������ ����".

DROP FUNCTION IF EXISTS hello;
DELIMITER //
CREATE FUNCTION hello()
RETURNS TINYTEXT DETERMINISTIC 
BEGIN 
	DECLARE HOUR int;
	SET hour = HOUR(now());
	CASE 
		WHEN hour BETWEEN 0 AND 5 THEN 
			RETURN '������ ����';
		WHEN hour BETWEEN 6 AND 11 THEN 
			RETURN '������ ����';
		WHEN hour BETWEEN 12 AND 17 THEN 
			RETURN '������ ����';
		WHEN hour BETWEEN 18 AND 23 THEN 
			RETURN '������ �����';
		END CASE ;
END //		

SELECT hello() //





	




