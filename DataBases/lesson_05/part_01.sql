/*
Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
*/

mysql> CREATE TABLE users (   id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,   name VARCHAR(255),   birthday_at DATE,   created_at DATETIME,   updated_at DATETIME );
Query OK, 0 rows affected (0.07 sec)

mysql> INSERT INTO
    ->   users (name, birthday_at, created_at, updated_at)
    -> VALUES
    ->   ('Timmy','1988-03-15',NULL,NULL),
    ->   ('Arty','1990-05-20',NULL,NULL),
    ->   ('Alex','2000-11-11',NULL,NULL),
    ->   ('Ivan','2005-07-29',NULL,NULL),
    ->   ('Georg','1997-01-15',NULL,NULL);
Query OK, 5 rows affected (0.03 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM users;
+----+-------+-------------+------------+------------+
| id | name  | birthday_at | created_at | updated_at |
+----+-------+-------------+------------+------------+
|  1 | Timmy | 1988-03-15  | NULL       | NULL       |
|  2 | Arty  | 1990-05-20  | NULL       | NULL       |
|  3 | Alex  | 2000-11-11  | NULL       | NULL       |
|  4 | Ivan  | 2005-07-29  | NULL       | NULL       |
|  5 | Georg | 1997-01-15  | NULL       | NULL       |
+----+-------+-------------+------------+------------+
5 rows in set (0.00 sec)

mysql> UPDATE users SET created_at = NOW(), updated_at = NOW();
Query OK, 5 rows affected (0.02 sec)
Rows matched: 5  Changed: 5  Warnings: 0

mysql> SELECT * FROM users;
+----+-------+-------------+---------------------+---------------------+
| id | name  | birthday_at | created_at          | updated_at          |
+----+-------+-------------+---------------------+---------------------+
|  1 | Timmy | 1988-03-15  | 2020-05-05 05:51:52 | 2020-05-05 05:51:52 |
|  2 | Arty  | 1990-05-20  | 2020-05-05 05:51:52 | 2020-05-05 05:51:52 |
|  3 | Alex  | 2000-11-11  | 2020-05-05 05:51:52 | 2020-05-05 05:51:52 |
|  4 | Ivan  | 2005-07-29  | 2020-05-05 05:51:52 | 2020-05-05 05:51:52 |
|  5 | Georg | 1997-01-15  | 2020-05-05 05:51:52 | 2020-05-05 05:51:52 |
+----+-------+-------------+---------------------+---------------------+
5 rows in set (0.00 sec)

mysql> DROP TABLE IF EXISTS users;
Query OK, 0 rows affected (0.05 sec)

/*
Таблица users была неудачно спроектирована. 
Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения в формате 
"20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.
*/

mysql> CREATE TABLE users (   id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,   name VARCHAR(255),   birthday_at DATE,   created_at VARCHAR(255),   updated_at VARCHAR(255) );                        Query OK, 0 rows affected (0.14 sec)

mysql> INSERT INTO   users (name, birthday_at, created_at, updated_at) VALUES   ('Timmy','1988-03-15','05.03.2019 12:01','01.05.2019 11:01'),   ('Arty','1990-05-20','12.06.2012 11:11','18.12.2018 12:11'),   ('Alex','2000-11-11','11.04.2014 10:01','11.07.2016 14:23'),   ('Ivan','2005-07-29','02.02.2017 12:35','02.02.2018 11:40'),   ('Georg','1997-01-15','15.03.2020 23:00','15.04.2020 23:00');
Query OK, 5 rows affected (0.02 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM users;                                                 
+----+-------+-------------+------------------+------------------+
| id | name  | birthday_at | created_at       | updated_at       |
+----+-------+-------------+------------------+------------------+
|  1 | Timmy | 1988-03-15  | 05.03.2019 12:01 | 01.05.2019 11:01 |
|  2 | Arty  | 1990-05-20  | 12.06.2012 11:11 | 18.12.2018 12:11 |
|  3 | Alex  | 2000-11-11  | 11.04.2014 10:01 | 11.07.2016 14:23 |
|  4 | Ivan  | 2005-07-29  | 02.02.2017 12:35 | 02.02.2018 11:40 |
|  5 | Georg | 1997-01-15  | 15.03.2020 23:00 | 15.04.2020 23:00 |
+----+-------+-------------+------------------+------------------+
5 rows in set (0.01 sec)

mysql> SELECT STR_TO_DATE(created_at, '%d.%m.%Y %k:%i') FROM users;
+-------------------------------------------+
| STR_TO_DATE(created_at, '%d.%m.%Y %k:%i') |
+-------------------------------------------+
| 2019-03-05 12:01:00                       |
| 2012-06-12 11:11:00                       |
| 2014-04-11 10:01:00                       |
| 2017-02-02 12:35:00                       |
| 2020-03-15 23:00:00                       |
+-------------------------------------------+
5 rows in set (0.00 sec)

mysql> UPDATE
    ->   users
    -> SET
    ->   created_at = STR_TO_DATE(created_at, '%d.%m.%Y %k:%i'),
    ->   updated_at = STR_TO_DATE(updated_at, '%d.%m.%Y %k:%i');
Query OK, 5 rows affected (0.02 sec)
Rows matched: 5  Changed: 5  Warnings: 0

mysql> SELECT * FROM users;
+----+-------+-------------+---------------------+---------------------+
| id | name  | birthday_at | created_at          | updated_at          |
+----+-------+-------------+---------------------+---------------------+
|  1 | Timmy | 1988-03-15  | 2019-03-05 12:01:00 | 2019-05-01 11:01:00 |
|  2 | Arty  | 1990-05-20  | 2012-06-12 11:11:00 | 2018-12-18 12:11:00 |
|  3 | Alex  | 2000-11-11  | 2014-04-11 10:01:00 | 2016-07-11 14:23:00 |
|  4 | Ivan  | 2005-07-29  | 2017-02-02 12:35:00 | 2018-02-02 11:40:00 |
|  5 | Georg | 1997-01-15  | 2020-03-15 23:00:00 | 2020-04-15 23:00:00 |
+----+-------+-------------+---------------------+---------------------+
5 rows in set (0.00 sec)

mysql> DESC users;
+-------------+--------------+------+-----+---------+----------------+
| Field       | Type         | Null | Key | Default | Extra          |
+-------------+--------------+------+-----+---------+----------------+
| id          | int unsigned | NO   | PRI | NULL    | auto_increment |
| name        | varchar(255) | YES  |     | NULL    |                |
| birthday_at | date         | YES  |     | NULL    |                |
| created_at  | varchar(255) | YES  |     | NULL    |                |
| updated_at  | varchar(255) | YES  |     | NULL    |                |
+-------------+--------------+------+-----+---------+----------------+
5 rows in set (0.01 sec)

mysql> ALTER TABLE   users CHANGE   updated_at updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;
Query OK, 5 rows affected (0.15 sec)
Records: 5  Duplicates: 0  Warnings: 0

mysql> DESC users;
+-------------+--------------+------+-----+-------------------+-----------------------------------------------+
| Field       | Type         | Null | Key | Default           | Extra                                         |
+-------------+--------------+------+-----+-------------------+-----------------------------------------------+
| id          | int unsigned | NO   | PRI | NULL              | auto_increment                                |
| name        | varchar(255) | YES  |     | NULL              |                                               |
| birthday_at | date         | YES  |     | NULL              |                                               |
| created_at  | datetime     | YES  |     | CURRENT_TIMESTAMP | DEFAULT_GENERATED                             |
| updated_at  | datetime     | YES  |     | CURRENT_TIMESTAMP | DEFAULT_GENERATED on update CURRENT_TIMESTAMP |
+-------------+--------------+------+-----+-------------------+-----------------------------------------------+
5 rows in set (0.00 sec)

/*
В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 
0, если товар закончился и выше нуля, если на складе имеются запасы. 
Необходимо отсортировать записи таким образом, чтобы они выводились в порядке увеличения значения value. 
Однако, нулевые запасы должны выводиться в конце, после всех записей.
*/

mysql> DROP TABLE IF EXISTS storehouse_products;
Query OK, 0 rows affected, 1 warning (0.01 sec)

mysql> CREATE TABLE storehouse_products (   id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,   storehouse_id INT UNSIGNED, product_id INT UNSIGNED,   value INT UNSIGNED,   created_at DATETIME DEFAULT CURRENT_TIMESTAMP,   updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP );
Query OK, 0 rows affected (0.06 sec)

mysql> INSERT INTO   storehouse_products (storehouse_id,product_id,value) VALUES   (1, 543, 0),   (1, 789, 2500),   (1, 3432, 0),   (1, 826, 30),   (1, 719, 500),   (1, 638, 1);
Query OK, 6 rows affected (0.02 sec)
Records: 6  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM storehouse_products ORDER BY value;
+----+---------------+------------+-------+---------------------+---------------------+
| id | storehouse_id | product_id | value | created_at          | updated_at          |
+----+---------------+------------+-------+---------------------+---------------------+
|  1 |             1 |        543 |     0 | 2020-05-05 06:18:35 | 2020-05-05 06:18:35 |
|  3 |             1 |       3432 |     0 | 2020-05-05 06:18:35 | 2020-05-05 06:18:35 |
|  6 |             1 |        638 |     1 | 2020-05-05 06:18:35 | 2020-05-05 06:18:35 |
|  4 |             1 |        826 |    30 | 2020-05-05 06:18:35 | 2020-05-05 06:18:35 |
|  5 |             1 |        719 |   500 | 2020-05-05 06:18:35 | 2020-05-05 06:18:35 |
|  2 |             1 |        789 |  2500 | 2020-05-05 06:18:35 | 2020-05-05 06:18:35 |
+----+---------------+------------+-------+---------------------+---------------------+
6 rows in set (0.00 sec)

mysql> SELECT * FROM storehouse_products ORDER BY IF(value > 0, 0, 1),value;
+----+---------------+------------+-------+---------------------+---------------------+
| id | storehouse_id | product_id | value | created_at          | updated_at          |
+----+---------------+------------+-------+---------------------+---------------------+
|  6 |             1 |        638 |     1 | 2020-05-05 06:18:35 | 2020-05-05 06:18:35 |
|  4 |             1 |        826 |    30 | 2020-05-05 06:18:35 | 2020-05-05 06:18:35 |
|  5 |             1 |        719 |   500 | 2020-05-05 06:18:35 | 2020-05-05 06:18:35 |
|  2 |             1 |        789 |  2500 | 2020-05-05 06:18:35 | 2020-05-05 06:18:35 |
|  1 |             1 |        543 |     0 | 2020-05-05 06:18:35 | 2020-05-05 06:18:35 |
|  3 |             1 |       3432 |     0 | 2020-05-05 06:18:35 | 2020-05-05 06:18:35 |
+----+---------------+------------+-------+---------------------+---------------------+
6 rows in set (0.01 sec)

/*
Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. 
Месяцы заданы в виде списка английских названий ('may', 'august')
*/

mysql> SELECT name, DATE_FORMAT(birthday_at, '%M') FROM users;
+-------+--------------------------------+
| name  | DATE_FORMAT(birthday_at, '%M') |
+-------+--------------------------------+
| Timmy | March                          |
| Arty  | May                            |
| Alex  | November                       |
| Ivan  | July                           |
| Georg | January                        |
+-------+--------------------------------+
5 rows in set (0.00 sec)

mysql> SELECT name FROM users WHERE DATE_FORMAT(birthday_at, '%M') IN ('may','august');
+------+
| name |
+------+
| Arty |
+------+
1 row in set (0.00 sec)

/*
Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
Отсортируйте записи в порядке, заданном в списке IN.
*/

mysql> CREATE TABLE catalogs (
    ->   id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY key,
    ->   name VARCHAR(255)
    -> );
Query OK, 0 rows affected (0.06 sec)

mysql> INSERT INTO catalogs(name) VALUES ('Процессоры'),('Маеринские платы'),('Оперативная память');
Query OK, 3 rows affected (0.02 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM catalogs WHERE id IN (3,1,2) ORDER BY FIELD(id,3,1,2);
+----+-------------------------------------+
| id | name                                |
+----+-------------------------------------+
|  3 | Оперативная память                  |
|  1 | Процессоры                          |
|  2 | Маеринские платы                    |
+----+-------------------------------------+
3 rows in set (0.00 sec)

mysql> 
