
-- USE example;

-- Создайте представление, которое выводит название name товарной позиции из таблицы products
-- и соответствующее название каталога name из таблицы catalogs.

CREATE OR REPLACE VIEW products_catalogs AS
SELECT p.name AS catalogs, c.name FROM products p 
LEFT  JOIN catalogs c ON p.catalog_id = c.id;


-- Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
-- с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

DROP FUNCTION IF EXISTS hello;
DELIMITER //
CREATE FUNCTION hello()
RETURNS TINYTEXT DETERMINISTIC 
BEGIN 
	DECLARE HOUR int;
	SET hour = HOUR(now());
	CASE 
		WHEN hour BETWEEN 0 AND 5 THEN 
			RETURN 'Доброй ночи';
		WHEN hour BETWEEN 6 AND 11 THEN 
			RETURN 'Доброе утро';
		WHEN hour BETWEEN 12 AND 17 THEN 
			RETURN 'Добрый день';
		WHEN hour BETWEEN 18 AND 23 THEN 
			RETURN 'Добрый вечер';
		END CASE ;
END //		

SELECT hello() //





	




