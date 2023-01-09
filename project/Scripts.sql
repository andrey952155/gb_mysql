USE files_db;


-- показать 5 случайных файлов
DROP PROCEDURE IF EXISTS `best_files`;
DELIMITER //
CREATE PROCEDURE best_files()
BEGIN
	SELECT name FROM files
	ORDER BY rand()
	LIMIT 5;
END//
DELIMITER ;
CALL best_files();


-- Добавление нового файла
DROP PROCEDURE IF EXISTS `sp_add_file`;
DELIMITER $$
CREATE PROCEDURE `sp_add_file`(name varchar(100), file_description varchar(100), type_id INT,
								user_id BIGINT, create_date DATETIME, OUT tran_result varchar(200))
BEGIN
    DECLARE `_rollback` BOOL DEFAULT 0;
    DECLARE code varchar(100);
    DECLARE error_string varchar(100);
    DECLARE last_file_id int;
   DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
   begin
    	SET `_rollback` = 1;
	GET stacked DIAGNOSTICS CONDITION 1
          code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT;
    	set tran_result := concat('Error occured. Code: ', code, '. Text: ', error_string);
    end;
START TRANSACTION;
INSERT INTO `files` (name, file_description) VALUES (name, file_description);
INSERT INTO `file_info` (file_id, type_id, user_id, create_date) VALUES (file_id, type_id, user_id, create_date);
IF `_rollback` THEN
	       ROLLBACK;
	    ELSE
		set tran_result := 'ok';
	       COMMIT;
	    END IF;
END$$
DELIMITER ;
call sp_add_file('file_name44', 'new descrition file', 4, 23, '2000-12-12-13', @tran_result);


-- показать сколько файлов у каждого пользователя
SELECT u.username, count(*)  FROM users u
JOIN file_info fi ON u.id = fi.user_id 
GROUP BY u.username 
ORDER BY count(*) DESC ;


-- 5 недавно добавленных файла
SELECT name FROM files
WHERE id IN (SELECT file_id FROM file_info ORDER BY create_date DESC )
LIMIT 5;


-- таблица с полным названием файла (название + расширение) и его владельцем
CREATE OR REPLACE VIEW v_full_filename AS 
SELECT f.id, concat(f.name ,'.', t.extension) AS full_filename, u.username FROM files f
JOIN file_info fi ON fi.file_id  = f.id 
JOIN types t ON t.id = fi.type_id
JOIN users u ON fi.user_id = u.id 
ORDER BY id;


-- таблица с пользователями и с группой в которой они состоят
CREATE OR REPLACE VIEW username_group AS
SELECT vff.username, ga.name AS 'groupname'  FROM v_full_filename vff 
JOIN file_group fg ON vff.id = fg.file_id
JOIN groups_all ga ON fg.group_id = ga.id ;















