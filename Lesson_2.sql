-- Задача 1
-- СУБД MySQL установил, .my.cnf добавил


-- Задача 2
DROP DATABASE IF EXISTS example;
CREATE DATABASE example;
USE example;

CREATE TABLE users (
	id INT PRIMARY KEY,
	name VARCHAR(255)
);


/*
 * Задача 3
 * mysqldump example > example_dump.sql
 * создаем базу newbase, в которую импортируем example_dump.sql
 * mysql newbase < example_dump.sql
 */
