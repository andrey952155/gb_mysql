-- В таблице files содержаться имена файлов без раширений, расширения отдельно в таблице types

DROP DATABASE IF EXISTS files_db;
CREATE DATABASE files_db;
USE files_db;

DROP TABLE IF EXISTS files;
CREATE TABLE files (
	id SERIAL PRIMARY KEY,
    name VARCHAR(100) COMMENT 'название файла',
    file_description VARCHAR(100), 
    uuid_name CHAR(36) DEFAULT(uuid()) COMMENT 'название, с которым файл будет сохранятся в файловой системе,
												 чтобы не было одинаковых файлов в одной папке',
    is_deleted bit DEFAULT(0),
    INDEX name_idx(name)
);

DROP TABLE IF EXISTS types;
CREATE TABLE types (
	id SERIAL PRIMARY KEY,
    extension VARCHAR(10) COMMENT 'расширение файла',
    description VARCHAR(20)
);

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
    username VARCHAR(100) COMMENT 'владелец',
    create_date DATETIME default now()
);

DROP TABLE IF EXISTS file_info ;
CREATE TABLE file_info (
	file_id SERIAL PRIMARY KEY,
	FOREIGN KEY (file_id) REFERENCES files(id) ON UPDATE CASCADE ON DELETE CASCADE,
	type_id BIGINT UNSIGNED NOT NULL,
	FOREIGN KEY (type_id) REFERENCES types(id) ON UPDATE CASCADE ON DELETE CASCADE,
    user_id BIGINT UNSIGNED NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
    create_date DATETIME default now()
);


DROP TABLE IF EXISTS share;
CREATE TABLE share (
	id SERIAL PRIMARY KEY,
	file_id BIGINT UNSIGNED NOT NULL,
	FOREIGN KEY (file_id) REFERENCES files(id) ON UPDATE CASCADE ON DELETE CASCADE,
    access ENUM('write', 'read'),
    from_user_id BIGINT UNSIGNED NOT NULL,
	FOREIGN KEY (from_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE,
	to_user_id BIGINT UNSIGNED NOT NULL,
	FOREIGN KEY (to_user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE CASCADE
);
  

DROP TABLE IF EXISTS groups_all;
CREATE TABLE groups_all (
	id SERIAL PRIMARY KEY,
	name VARCHAR(150),
	INDEX group_name_idx(name)
);


DROP TABLE IF EXISTS file_group;
CREATE TABLE file_group(
	file_id BIGINT UNSIGNED NOT NULL,
	group_id BIGINT UNSIGNED NOT NULL,  
	PRIMARY KEY (file_id, group_id),
    FOREIGN KEY (file_id) REFERENCES files(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (group_id) REFERENCES groups_all(id) ON UPDATE CASCADE ON DELETE CASCADE
);


INSERT INTO `files` (id, name, file_description, is_deleted) VALUES 
(1,'adipisci','Sit magnam quos eum odit sit deserunt. Saepe temporibus unde voluptatum accusamus sint. Veritatis ea',''),
(2,'molestiae','Possimus voluptatibus voluptas pariatur nostrum. Est ipsa eos eaque qui accusamus voluptatem.','\0'),
(3,'aut','Aut recusandae alias quam ut voluptates quasi non. Numquam ut aut dolorem modi. Architecto aut nobis',''),
(4,'neque','Aperiam qui est quos et ad molestiae molestias hic. Omnis est et minus voluptatem qui ipsa quia. Con','\0'),
(5,'necessitatibus','Qui corporis veritatis dolore aspernatur ',''),
(6,'fugit','Iusto voluptatem minus et eos. Beatae atque aut itaque. Ut incidunt rerum quasi omnis. Dolorem place','\0'),
(7,'qui','Officiis officia et provident ipsa quaerat aut temporibus. Ad consequuntur ipsa eos eius. Et sequi q',''),
(8,'aliquid','Ratione accusamus quas qui et. Consequuntur tempore itaque sed omnis. Nemo nihil facilis saepe lauda','\0'),
(9,'repellat','Omnis nulla rerum id est animi sunt. Magnam quas enim facere facere eius ad sequi. Nostrum voluptate','\0'),
(10,'dolorem','Numquam ut voluptas quia non. Voluptates consectetur quaerat quis eos. Est adipisci officia rerum nu','\0'),
(11,'sit','Suscipit vel aut eos soluta ad. Animi repellendus laborum ut error saepe commodi. Laborum odit aliqu',''),
(12,'et','Repudiandae sed exercitationem repudiandae et rem est aspernatur. Alias id vitae soluta reiciendis r','\0'),
(13,'id','Sequi ab sed non ut blanditiis. Qui ad dolores a repudiandae perspiciatis distinctio. Exercitationem',''),
(14,'enim','Ut dignissimos est ad consequatur. Aut qui explicabo qui deserunt ab quisquam. Nulla rerum quisquam ',''),
(15,'sunt','Nam ut cupiditate voluptatibus delectus similique. Numquam dolore tempora voluptatem tempore molesti','\0'),
(16,'suscipit','Incidunt corrupti nobis maxime reprehenderit. Explicabo et cum sequi non rem voluptates illo eveniet','\0'),
(17,'voluptatem','Commodi molestiae quod nesciunt beatae culpa nulla. In maiores rep. Ex','\0'),
(18,'maxime','Commodi assumenda labore magni aut assumenda aspernatur et qui. Tenetur et laborum et consequatur iu','\0'),
(19,'consequatur','Fugit deserunt odio sed occaecati. Culpa dolore quo debitis ipsa Qui repudiandae facer',''),
(20,'dolores','Commodi provident culpa sit ut officia. Nihil cumque velit non ut. Dolores et architecto corporis et',''),
(21,'numquam','Officia mollitia et eaque dolor expedita consequatur id. Autem magnam s excepturi. O','\0'),
(22,'rerum','Quidem iure id odio nam occaecati modi optio. Non nam rerum atque omnis est quis dolorem sint. Quo f','\0'),
(23,'corporis','Architecto repellat est cumque ut quia. Nesciunt et deleniti labore et. Rerum nostrum cum voluptas v',''),
(24,'nihil','Pariatur excepturi accusamus praesentium quaerat. Doloribus ea ullam asperiores a dolore eius. Qui n','\0'),
(25,'aut','Culpa soluta qui voluptate quia aliquam voluptatem sequi. Deleniti itaque velit rem repellat volupta','\0'),
(26,'non','Omnis corrupti cupiditate fuga consectetur. Reiciendis ea amet nisi nostrum.','\0'),
(27,'ratione','Debitis et suscipit quasi velit sapiente recusandae. Minus illum veritatis fugiat impedit.',''),
(28,'nisi','Consequuntur laudantium labore impedit animi ab. Et aut vero voluptatem enim. Nostrum quo eius qui s',''),
(29,'omnis','Nisi minima minima optio deleniti corporis ut. Suscipit qui placeat in repellendus fuga quae. Delect',''),
(30,'sint','Ipsam in doloremque nulla omnis. Repellat inventore nobis dolor tempora quia ipsa voluptates. Odit c',''),
(31,'voluptatibus','Ut autem cumque et. Consequatur possimus nihil temporibus iusto lnatus ','\0'),
(32,'tenetur','Et eum deserunt quo aut excepturi sed. Qui accusamus facilis eos eos aliquam.',''),
(33,'est','Voluptatem distinctio sed doloribus eligendi numquam. Repellendus aut hic nostrum sunt et accusamus ',''),
(34,'saepe','Assumenda minus veritatis officia ut maiores ipsa dicta. Quas aut ut aut corporis tempora nesciunt. ','\0'),
(35,'enim','Expedita porro vel qui nisi voluptatem eligendi. Dolores maxime aut error error. Autem expedita reru','\0'),
(36,'debitis','Omnis vel occaecati iure ut culpa autem. Incidunt eligendi magnam aliquam.','\0'),
(37,'asperiores','Quod illum accusamus sit et doloribus in. Accusantium ab aut et iste molestiae. Quia asperiores quib',''),
(38,'quaerat','Quasi dolores illum facere voluptates doloribus est deleniti. Sed laboriosam alias ab repellendus ex','\0'),
(39,'voluptatibus','Quidem qui neque commodi nam. Aliquam occaecati distinctioassumenda animi. Porro eveniet il','\0'),
(40,'saepe','Ut officiis minus quia quia inventore expedita quas. Inventore velit laborum totam in adipisci ut eo','\0'),
(41,'quam','Molestias id dicta ducimus eos omnis ex. Et eius autem consequatur officiis. Sunt deserunt impedit e',''),
(42,'vel','Reiciendis error voluptatem dolorum enim laudantium mollitia dolor. Est vel esse autem tempore fuga ','\0'),
(43,'facilis','Harum dolorum distinctio enim mollitia iste. Possimus cum sint accusamus. Et doloremque repellendus ',''),
(44,'doloribus','Rerum tempora unde et odit aut. Sint quo voluptatum dolor consectetur ut ielit expedita a','\0'),
(45,'dolores','Quo sint atque omnis et. Exercitationem ut ad id earum a aut. Quod qui quae nam tenetur ipsum. Praes',''),
(46,'ex','Itaque enim voluptatum enim et quibusdam voluptates fugiat ad. Incidunt iste eos reiciendis dolorum ',''),
(47,'nulla','Asperiores est dolorem aliquam sunt sed harum voluptatibus facilis. Magnam magni cum eius ut minus n','\0'),
(48,'qui','Aut incidunt voluptatibus omnis. Officia voluptatibus beatae voluptatibus quis omnis. Iste tempora a','\0'),
(49,'sequi','Qui quia voluptates iste provident commodi eligendi. Nobis facilis laboriosam praesentium eum nesciu','\0'),
(50,'accusamus','Officiis velit praesentium deserunt eligendi et dolores id. Voluptatem velit omnis alias et itaque e',''),
(51,'omnis','Iste ex ipsum ipsum vel dolorem itaque. Est et quidem facilis laborum nesciunt magni assumenda. Offi','\0'),
(52,'error','Pariatur adipisci et quod eum ad odit. Provident est qui corporis molestiae. Magni adipisci quidem e','\0'),
(53,'vel','Ea veritatis rem veniam exercitationem est placeat repudiandae. Provident pariatur tenetur ipsam atq',''),
(54,'dolores','Dolorum repudiandae hic sunt non eveniet suscipit. Dolorem velit molestiae nisi unde. Reprehenderit ','\0'),
(55,'non','Molestiae soluta illum quos. Dolores pariatur a quos animi. Dolorem sed impedit reprehenderit ullam.',''),
(56,'corporis','Et corrupti accusantium autem cum. Non dolore at autem deserunt beatae officiis dicta. Dolorum delen',''),
(57,'dolorem','Minima doloremque magni ab in. Provident in ipsum id in enim consequatur quo. Quis eum ab nostrum et','\0'),
(58,'itaque','Omnis ut sequi deserunt delectus. Placeat nobis et adipisci laudantium rem saepe. Ipsam magnam et iu',''),
(59,'ad','Corrupti qui nobis molestiae inventore explicabo laudantium. Aut est pariatur cumque pariatur non. M',''),
(60,'perferendis','Provident nam sed nam sapiente voluptatem inventore aut atque. s. Aut q','\0'),
(61,'provident','Ea voluptatem itaque soluta alias nihil sed. Veritatis inventore ut nostrum vel dolorem consequuntur','\0'),
(62,'minima','Perferendis et dolorem qui doloribus doloremque qui non. Velit dolorem nostrum maxime est.','\0'),
(63,'ut','Voluptas rerum numquam nobis facilis nostrum. Voluptates velit qui itaque. Sapiente eaque unde ipsum',''),
(64,'qui','Doloremque aut laudantium corrupti rerum. Nihil veritatis consequatur aperiam velit nam debitis natu',''),
(65,'aut','Id eum totam nemo et nobis quo maiores. Eligendi perferendis dolor et voluptate dolore animi quae. M','\0'),
(66,'in','Repudiandae id consequuntur cupiditate ratione officia iste. Doloribus debitis iusto voluptatem porr',''),
(67,'eum','Ea molestiae voluptas ab ex aut dolorum voluptatibus. Commodi quisquam et quae sequi doloribus rerum','\0'),
(68,'blanditiis','Porro nobis modi magni nulla in voluptatum. Eius qui sit quos maxime. Eaque reprehenderit quo est pr',''),
(69,'sapiente','Ducimus harum distinctio quibusdam sit provident beatae. Sit asperiores corporis delectus quam quos ','\0'),
(70,'sit','Sunt esse enim quia vel tenetur quidem. Consequatur officia numquam a qui earum quia. Sequi sunt exp',''),
(71,'culpa','Voluptates beatae harum facilis ratione soluta et dicta qui. Nesciunt numquam fuga dolorem recusanda',''),
(72,'sint','Alias ut incidunt architecto. Quidem at dolorem dolorem eaque et eum amet voluptates. Expedita enim ','\0'),
(73,'dolorem','Quia eligendi sed possimus soluta nostrum iusto. Saepe voluptatem aperiam sunt eum. Omnis reiciendis',''),
(74,'voluptas','Est aliquam numquam reprehenderit quisquam nesciunt vitae. Consectetur ut explicabo dolorem fuga. Au','\0'),
(75,'temporibus','Deleniti ad quibusdam aliquid culpa non nam nostrum. Et voluptatibus omnis ut qui occaecam m','\0'),
(76,'expedita','Dolor quia enim deleniti a nisi totam quo. Illo nisi sit quod dolorem minus. Reprehenderit et nemo e',''),
(77,'quisquam','Illo exercitationem occaecati sapiente omnis placeat sunt ullam recusandae. Nesciunt odio et sed ape',''),
(78,'est','Vel excepturi quisquam dicta. Sit necessitatibus tenetur nesciunt iste exercitationem incidunt. Volu','\0'),
(79,'perspiciatis','Voluptate sit inventore qui sunt aut voluptas dolor. Ut quosaliquid. Ab laudantium non d',''),
(80,'dolore','Perferendis itaque cum quos sit. At dolores odio quis quod. Tempore qui deleniti et quia nulla praes',''),
(81,'ipsam','Reiciendis qui qui doloremque voluptate assumenda. Magnam ad est quia quis. Et totam ut soluta volup','\0'),
(82,'est','Ab harum in vitae vitae. Porro quas quaerat quisquam voluptas et sit voluptatem. Delectus quia ex cu','\0'),
(83,'iste','Animi consequatur minus velit ea. Doloremque blanditiis et voluptates est debitis omnis. Nulla aut i',''),
(84,'beatae','Nemo voluptas incidunt ut quia quia sunt ut. Sapiente sit laboriosam placeat aut qui velit magnam si',''),
(85,'delectus','Ut necessitatibus et officiis iure nobis maxime incidunt. Magni aut est suscipit quod quas et. Qui e','\0'),
(86,'vel','Dolorem commodi iusto libero ut aliquid. Laboriosam et nulla cumque. Odio consequatur ut sed perspic',''),
(87,'dolorem','Excepturi ullam aut eos nihil rerum a. Maiores aut enim ut autem. Est et et officia et voluptatum qu',''),
(88,'quia','Ut consequatur velit odit qui maiores. Quasi voluptas exercitationem illo autem dignissimos. Quae al',''),
(89,'mollitia','Rerum facere totam molestiae at non voluptatem. Saepe veritatis illum voluptatibus ea doloribus. Sed',''),
(90,'ut','Nesciunt numquam sint architecto et eaque. Repellendus quidem temporibus modi quasi. Ut vero commodi','\0'),
(91,'illum','Voluptas et qui qui dolores velit officia modi. Atque incidunt velit sunt iste. Sunt eligendi doloru','\0'),
(92,'qui','Aliquid fuga et incidunt labore. Ad doloribus cum nam facilis molestias laboriosam. Ut facere dolore','\0'),
(93,'vel','Provident eos molestiae asperiores quas illum occaecati. Nihil necessitatibus omnis vero recusandae ',''),
(94,'earum','Voluptatem error nam quia molestiae debitis ab. Repellendus dolores similique pariatur molestiae qui',''),
(95,'ut','Placeat provident et harum. Magnam quae esse quis ducimus harum sint porro unde. Omnis voluptatibus ','\0'),
(96,'ratione','In quis consequuntur ducimus rerum expedita velit similique. Repudiandae iure reprehenderit voluptat',''),
(97,'sequi','Suscipit sit impedit quidem voluptatem incidunt. Ut enim blanditiis aspernatur aut. Nulla occaecati ',''),
(98,'repudiandae','Perspiciatis quos dignissimos quis. Quos laborum odit doloribus similiqt. In ',''),
(99,'excepturi','Labore mollitia magni cupiditate occaecati nisi eveniet rerum. Sit aut unor','\0'),
(100,'ad','Eaque inventore ea earum quaerat delectus. Quia expedita ut et et quibusdam amet delectus. Voluptate','');

INSERT INTO `users` VALUES
(1,'ritchie.lea','1974-06-09 03:06:50'),(2,'kautzer.luigi','1976-02-07 23:08:58'),
(3,'will.flavio','1985-11-06 17:29:55'),(4,'jaylin.dibbert','2018-10-04 05:29:07'),
(5,'stephanie.white','2020-02-02 06:34:22'),(6,'mkovacek','2002-03-08 10:05:50'),
(7,'hannah49','1988-11-08 03:18:38'),(8,'kreiger.laisha','1990-01-03 06:58:33'),
(9,'wendy.cole','2006-08-20 21:45:38'),(10,'bert62','2022-02-04 05:15:02'),
(11,'cstroman','1970-08-23 07:51:35'),(12,'gdooley','1994-10-19 21:59:13'),
(13,'graham.elizabeth','1997-07-16 13:44:00'),(14,'bryon81','1985-08-30 09:53:22'),
(15,'beer.leda','1993-10-15 07:06:20'),(16,'sheila77','2011-12-15 11:12:47'),
(17,'earline52','1998-04-26 16:47:41'),(18,'wpurdy','1996-10-05 10:53:12'),
(19,'andrew.keeling','1990-12-17 15:49:47'),(20,'roslyn.lemke','2018-05-03 11:50:13'),
(21,'ypouros','1988-03-24 15:47:07'),(22,'vlowe','1977-09-05 08:42:31'),
(23,'genesis22','1989-07-30 15:51:08'),(24,'schowalter.sharon','1998-11-22 10:06:52'),
(25,'lynch.jordi','1980-05-04 08:42:31'),(26,'lynch.darion','2011-08-08 15:54:56'),
(27,'kane.mosciski','2008-08-12 15:20:19'),(28,'marquardt.lonzo','1977-04-11 16:53:49'),
(29,'ghyatt','2014-03-31 16:03:04'),(30,'lakin.antonina','1986-05-23 07:09:17'),
(31,'diana.spencer','1975-03-12 23:14:00'),(32,'ryleigh.rodriguez','1977-09-25 17:21:39'),
(33,'karina.volkman','2011-05-15 08:37:08'),(34,'sally.hayes','1979-07-27 16:47:38'),
(35,'vtillman','1998-02-20 21:07:52'),(36,'tyshawn.toy','2020-09-05 11:29:23'),
(37,'zyundt','2015-07-12 10:04:48'),(38,'anderson.aracely','1992-01-31 04:59:18'),
(39,'eryn42','2007-03-20 03:19:19'),(40,'bryana67','1976-02-14 22:12:08'),
(41,'avis70','1978-11-01 20:50:29'),(42,'nitzsche.novella','2018-06-05 21:48:58'),
(43,'tfritsch','1978-03-10 10:41:38'),(44,'baylee43','1986-04-24 20:26:14'),
(45,'asauer','2004-07-04 13:06:13'),(46,'lowe.jovani','1998-09-01 18:28:24'),
(47,'medhurst.autumn','1980-01-07 12:01:16'),(48,'dach.grayson','1981-06-10 08:19:30'),
(49,'keeling.jordi','1972-01-11 23:43:17'),(50,'stanford88','1972-07-13 15:38:59');

INSERT INTO `groups_all` VALUES
(20,'a'),(4,'amet'),(16,'architecto'),(30,'aut'),(22,'consequatur'),(29,'culpa'),(21,'debitis'),
(8,'ea'),(28,'ea'),(19,'eaque'),(25,'eum'),(11,'facilis'),(2,'illum'),(3,'iste'),(7,'magnam'),
(1,'nam'),(23,'natus'),(24,'non'),(26,'non'),(9,'nostrum'),(12,'odio'),(17,'officiis'),(13,'quidem'),
(6,'sapiente'),(18,'sapiente'),(10,'tempore'),(5,'temporibus'),(15,'ullam'),(27,'ut'),(14,'voluptatem');

INSERT INTO `types` VALUES
(1,'pki','Doloremque similique'),(2,'wma','Omnis rem adipisci a'),(3,'stc','Id nam dolorum non a'),
(4,'xlf','Voluptatem consequat'),(5,'mp2a','Totam molestias quos'),(6,'vcf','Quos officiis sit mo'),
(7,'swf','Et et fugit incidunt'),(8,'hdf','Nisi non est qui. Do'),(9,'svc','Est rem aut ratione '),
(10,'ppsm','Eum aut aliquid at a'),(11,'s','Non dolores aspernat'),(12,'thmx','Facere explicabo sed'),
(13,'jpgv','Facere culpa quod er'),(14,'fig','Qui sapiente veniam '),(15,'mdb','Nihil quibusdam expl'),
(16,'wmd','Maiores sed ipsa ad '),(17,'mathml','Ducimus est voluptat'),(18,'icc','Quidem quod ipsum re'),
(19,'stf','Vitae omnis quia eaq'),(20,'torrent','Corrupti tempore et ');


INSERT INTO `share` VALUES
(1,1,'read',1,7),(2,54,'write',1,2),(3,23,'write',3,4),(4,54,'read',3,4),(5,12,'write',8,5),
(6,98,'write',6,3),(7,87,'read',7,6),(8,54,'read',4,4),(9,9,'write',8,6),(10,10,'read',1,1),
(11,11,'read',8,6),(12,12,'write',8,9),(13,76,'write',8,8),(14,14,'read',4,4),(15,34,'read',2,9),
(16,8,'read',3,3),(17,98,'write',4,8),(18,26,'write',6,3),(19,67,'write',6,2),(20,87,'write',3,5);


INSERT INTO `file_group` VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10),
(11,11),(12,12),(13,13),(14,14),(15,15),(16,16),(17,17),(18,18),
(19,19),(20,20),(21,21),(22,22),(23,23),(24,24),(25,25),(26,26),
(27,27),(28,28),(29,29),(30,30),(31,1),(32,2),(33,3),(34,4),(35,5),
(36,6),(37,7),(38,8),(39,9),(40,10),(41,11),(42,12),(43,13),(44,14),
(45,15),(46,16),(47,17),(48,18),(49,19),(50,20);



INSERT INTO `file_info` VALUES
(1,2,9,'2004-02-12 16:23:29'),(2,12,46,'2002-05-23 10:25:17'),(3,20,8,'2012-02-18 19:19:05'),
(4,20,50,'1971-06-16 06:09:08'),(5,20,15,'1978-12-03 14:04:33'),(6,9,13,'1996-02-22 22:33:41'),
(7,9,7,'1977-10-26 07:54:47'),(8,18,26,'2018-03-26 05:19:01'),(9,6,19,'2002-12-10 03:35:22'),
(10,16,46,'1999-06-27 03:41:08'),(11,18,5,'1995-10-10 00:50:08'),(12,5,32,'2014-12-17 17:13:31'),
(13,2,1,'2000-10-26 01:26:34'),(14,10,19,'2010-08-24 10:34:55'),(15,4,29,'2016-04-06 21:44:17'),
(16,8,41,'2005-12-21 00:57:06'),(17,10,32,'2020-12-03 02:39:15'),(18,14,7,'1983-03-28 03:13:13'),
(19,16,20,'2012-03-31 15:21:35'),(20,6,2,'2021-01-05 00:00:01'),(21,4,8,'1971-05-01 02:13:32'),
(22,17,31,'1994-03-26 04:52:28'),(23,15,26,'2001-04-10 20:03:37'),(24,20,39,'1973-06-10 12:50:16'),
(25,3,41,'2001-09-26 03:12:06'),(26,13,45,'2021-09-15 06:14:45'),(27,15,49,'1977-04-24 04:37:36'),
(28,17,15,'2019-12-21 02:59:11'),(29,12,4,'1973-06-11 04:16:22'),(30,1,46,'1977-06-10 15:44:14'),
(31,17,34,'2006-06-03 03:38:04'),(32,17,39,'1990-06-27 03:49:43'),(33,1,13,'2021-03-15 13:56:14'),
(34,2,17,'2010-09-11 13:20:36'),(35,6,17,'2003-11-26 16:47:26'),(36,1,48,'1996-10-03 19:08:07'),
(37,19,48,'1974-10-31 12:20:18'),(38,6,17,'1978-12-10 02:05:14'),(39,6,28,'1987-06-17 20:56:48'),
(40,16,48,'1990-12-06 03:57:42'),(41,7,49,'1972-06-16 19:46:58'),(42,20,21,'2020-08-03 18:57:40'),
(43,5,37,'1973-11-15 23:34:12'),(44,5,12,'1996-11-29 13:36:56'),(45,4,36,'2005-03-03 18:35:56'),
(46,19,46,'1988-07-21 08:10:47'),(47,12,23,'2019-07-08 12:47:25'),(48,17,12,'1996-06-24 16:38:05'),
(49,5,47,'1977-12-03 19:14:25'),(50,20,45,'1999-05-06 02:30:30'),(51,16,18,'1995-06-20 22:47:02'),
(52,8,6,'1981-06-03 02:31:33'),(53,16,20,'2007-06-27 19:00:20'),(54,7,11,'2017-04-03 08:04:46'),
(55,20,50,'2008-10-13 08:55:53'),(56,10,35,'1988-09-10 11:11:43'),(57,13,9,'2021-08-12 07:40:13'),
(58,6,22,'2010-03-24 01:24:05'),(59,6,36,'2008-03-29 22:26:30'),(60,4,46,'2016-06-18 14:05:50'),
(61,2,50,'1986-07-17 14:51:25'),(62,5,37,'2019-01-23 17:31:12'),(63,2,19,'1999-10-28 17:26:41'),
(64,7,18,'2012-07-25 00:18:44'),(65,15,38,'2007-11-03 07:02:38'),(66,11,50,'2001-12-23 16:08:22'),
(67,17,39,'1975-07-17 03:54:29'),(68,8,21,'1997-01-25 16:24:01'),(69,7,24,'2008-06-22 17:14:46'),
(70,17,28,'2000-11-13 23:47:49'),(71,20,45,'1994-01-22 00:57:18'),(72,11,45,'1984-10-02 22:06:49'),
(73,7,39,'1974-10-11 09:58:36'),(74,5,49,'1999-06-07 09:50:14'),(75,19,13,'2006-10-22 13:02:37'),
(76,14,34,'1973-10-26 09:13:44'),(77,8,14,'1994-04-11 21:15:22'),(78,13,13,'1973-07-09 13:50:43'),
(79,5,14,'1993-08-28 05:56:08'),(80,9,14,'2010-07-05 10:40:27'),(81,5,3,'1981-09-20 07:10:25'),
(82,4,12,'1977-07-26 22:51:50'),(83,12,42,'1987-07-24 12:09:30'),(84,8,48,'1995-04-21 10:44:22'),
(85,8,45,'2000-11-28 12:55:16'),(86,18,16,'2019-04-08 00:41:03'),(87,19,35,'2013-09-24 20:30:17'),
(88,5,32,'2014-05-18 10:38:50'),(89,17,2,'2012-12-29 10:03:06'),(90,19,31,'2019-12-17 10:06:44'),
(91,6,14,'1989-03-10 20:07:39'),(92,18,39,'1985-08-17 09:40:52'),(93,4,40,'2018-02-20 13:04:49'),
(94,4,26,'2015-10-14 15:00:00'),(95,18,5,'1999-03-01 22:46:26'),(96,20,12,'1981-06-16 04:45:53'),
(97,19,10,'1983-10-18 04:20:00'),(98,2,36,'2007-09-26 15:56:05'),(99,3,17,'2013-07-08 12:50:05'),
(100,14,43,'1985-06-28 23:18:53');







