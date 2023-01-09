-- DROP DATABASE IF EXISTS lesson_11;
-- CREATE DATABASE lesson_11;
USE lesson_11;

DROP TABLE IF EXISTS catalogs;
CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название раздела',
  UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина';

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя покупателя',
  birthday_at DATE COMMENT 'Дата рождения',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели';

DROP TABLE IF EXISTS products;
CREATE TABLE products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Название',
  description TEXT COMMENT 'Описание',
  price DECIMAL (11,2) COMMENT 'Цена',
  catalog_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_catalog_id (catalog_id)
) COMMENT = 'Товарные позиции';


-- Задание 1.
-- Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products
-- в таблицу logs помещается время и дата создания записи, название таблицы,
-- идентификатор первичного ключа и содержимое поля name.

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	times DATETIME,
	name_table VARCHAR(100),
	create_id INT
);

DROP TRIGGER IF EXISTS lesson_11.users_log;
DELIMITER $$
$$
CREATE DEFINER=`root`@`localhost` TRIGGER `users_log` AFTER INSERT ON `users` FOR EACH ROW BEGIN 
	INSERT INTO logs (times, name_table, create_id) VALUES  (now(), 'users', NEW.id) ;
END $$
DELIMITER ;


DROP TRIGGER IF EXISTS lesson_11.catalogs_log;
DELIMITER $$
$$
CREATE DEFINER=`root`@`localhost` TRIGGER `catalogs_log` AFTER INSERT ON `users` FOR EACH ROW BEGIN 
	INSERT INTO logs (name_table, create_id) VALUES  ('catalogs', NEW.id) ;
END $$
DELIMITER ;

DROP TRIGGER IF EXISTS lesson_11.product_log;
DELIMITER $$
$$
CREATE DEFINER=`root`@`localhost` TRIGGER `product_log` AFTER INSERT ON `products` FOR EACH ROW BEGIN 
	INSERT INTO logs (name_table, create_id) VALUES  ('products', NEW.id) ;
END$$
DELIMITER ;


INSERT INTO users (name, birthday_at) VALUES ('usernam21322s', '1980-12-12');
INSERT INTO catalogs (name) VALUES ('Процессоры');
INSERT INTO products (name, description, price, catalog_id) VALUES ('Процессор', 'Intel', 1000, 1);



-- Задание 2.
-- Создайте SQL-запрос, который помещает в таблицу users миллион записей.

DELIMITER // 
CREATE PROCEDURE add_users()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i<100000 /*Как в обычном цикле*/ 
    DO 
        INSERT INTO users(name, birthday_at) VALUES(CONCAT('name',i), '1980-12-12');
        SET i = i + 1;
    END WHILE;
END; //
DELIMITER ; 

-- CALL add_users();
-- долго выполняется, но все работает, проверено )


  
  
 