-- ������ 1
-- ���� MySQL ���������, .my.cnf �������


-- ������ 2
DROP DATABASE IF EXISTS example;
CREATE DATABASE example;
USE example;

CREATE TABLE users (
	id INT PRIMARY KEY,
	name VARCHAR(255)
);


/*
 * ������ 3
 * mysqldump example > example_dump.sql
 * ������� ���� newbase, � ������� ����������� example_dump.sql
 * mysql newbase < example_dump.sql
 */
