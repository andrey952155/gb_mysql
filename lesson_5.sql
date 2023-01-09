DROP DATABASE IF EXISTS lesson_5;
CREATE DATABASE lesson_5;
USE lesson_5;

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY, -- SERIAL = BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE
    firstname VARCHAR(30),
    lastname VARCHAR(30) COMMENT 'Фамилия', -- COMMENT на случай, если имя неочевидное
    created_at VARCHAR (30),
    updated_at VARCHAR (30),
    birthday_at DATETIME
);

INSERT INTO `users` (id, firstname, lastname, birthday_at)
	VALUES
		(1, 'Александра', 'Александрова', '1986-10-10'),
		(2, 'Борис', 'Борисов', '1976-10-10'),
		(3, 'Владимир', 'Владимиров', '1996-10-11');
	
	
	
	
-- Задание 1.
	
UPDATE users
SET created_at = now(),updated_at = now();  



-- Задание 2.

UPDATE users 
SET created_at = '20.10.2017 8:10', updated_at = '20.10.2017 8:10';  

UPDATE users 
SET created_at = STR_TO_DATE(created_at, '%d.%m.%Y %h:%i'),
	updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %h:%i') ;

ALTER TABLE users
MODIFY created_at DATETIME;



-- Задание 3.

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
	id SERIAL PRIMARY KEY,
    value INT UNSIGNED
 );

INSERT INTO storehouses_products (value)
	VALUES (9), (3), (5), (0), (12), (26), (0);
 

SELECT id, value FROM storehouses_products ORDER BY value = 0, value;




-- Практическое задание теме «Агрегация данных»
-- Задание 1.

SELECT concat('Средний возраст по таблице: ', round(avg(DATEDIFF(now(), birthday_at))/365), ' лет') FROM users;
-- SELECT birthday_at FROM users;


-- Задание 2.

DROP TABLE IF EXISTS birthday_temp;
CREATE TABLE birthday_temp (
	id SERIAL PRIMARY KEY,
	newday VARCHAR(255) COMMENT 'День рождения'
);

INSERT INTO birthday_temp
SELECT id, dayname(date_format(concat( YEAR(now()),'-',MONTH(birthday_at),'-',DAYOFMONTH(birthday_at)), '%Y-%m-%d'))
FROM users;

SELECT concat(count(newday), ' дня рождения в ', newday) FROM birthday_temp GROUP BY newday ; 

