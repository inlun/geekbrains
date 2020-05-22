-- Задача 1. 
/* 
 * В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
 * Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.
 */

mysql> START TRANSACTION;
Query OK, 0 rows affected (0.00 sec)

mysql> SELECT * FROM shop.users;
+----+--------------------+-------------+---------------------+---------------------+
| id | name               | birthday_at | created_at          | updated_at          |
+----+--------------------+-------------+---------------------+---------------------+
|  1 | Геннадий           | 1990-10-05  | 2020-05-19 13:39:58 | 2020-05-19 13:39:58 |
|  2 | Наталья            | 1984-11-12  | 2020-05-19 13:39:58 | 2020-05-19 13:39:58 |
|  3 | Александр          | 1985-05-20  | 2020-05-19 13:39:58 | 2020-05-19 13:39:58 |
|  4 | Сергей             | 1988-02-14  | 2020-05-19 13:39:58 | 2020-05-19 13:39:58 |
|  5 | Иван               | 1998-01-12  | 2020-05-19 13:39:58 | 2020-05-19 13:39:58 |
|  6 | Мария              | 1992-08-29  | 2020-05-19 13:39:58 | 2020-05-19 13:39:58 |
+----+--------------------+-------------+---------------------+---------------------+
6 rows in set (0.01 sec)

mysql> SELECT * FROM sample.users;
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

mysql> DELETE FROM sample.users WHERE id = 1;
Query OK, 1 row affected (0.00 sec)

mysql> INSERT INTO sample.users SELECT * FROM shop.users WHERE id = 1;
Query OK, 1 row affected (0.00 sec)
Records: 1  Duplicates: 0  Warnings: 0

mysql> DELETE FROM shop.users WHERE id = 1;
Query OK, 1 row affected (0.00 sec)

mysql> COMMIT;
Query OK, 0 rows affected (0.06 sec)

-- Задача 2. 
/*
 * Создайте представление, которое выводит название name товарной позиции из таблицы products 
 * и соответствующее название каталога name из таблицы catalogs.
 */

mysql> CREATE VIEW names AS SELECT products.name AS 'product name', catalogs.name AS 'catalog name' FROM products LEFT JOIN catalogs ON products.catalog_id = catalogs.id;
Query OK, 0 rows affected (0.04 sec)

mysql> SELECT * FROM names;
+-------------------------+-----------------------------------+
| product name            | catalog name                      |
+-------------------------+-----------------------------------+
| Intel Core i3-8100      | Процессоры                        |
| Intel Core i5-7400      | Процессоры                        |
| AMD FX-8320E            | Процессоры                        |
| AMD FX-8320             | Процессоры                        |
| ASUS ROG MAXIMUS X HERO | Материнские платы                 |
| Gigabyte H310M S2H      | Материнские платы                 |
| MSI B250M GAMING PRO    | Материнские платы                 |
+-------------------------+-----------------------------------+
7 rows in set (0.00 sec)

-- Задача 3.
/*
 * Пусть имеется таблица с календарным полем created_at. 
 * В ней размещены разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17. 
 * Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она отсутствует.
 */

inlun@unlun-server:~$ mysql
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 23
Server version: 8.0.19 MySQL Community Server - GPL

Copyright (c) 2000, 2020, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> USE sample
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
mysql> CREATE ALGORITHM = TEMPTABLE VIEW dates AS 
    ->   SELECT time_period.selected_date AS cur_date FROM 
    ->     (SELECT v.* FROM    
    ->       (SELECT ADDDATE('1970-01-01',t4.i*10000 + t3.i*1000 + t2.i*100 + t1.i*10 + t0.i) selected_date FROM    
    ->         (SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t0,    
    ->         (SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t1,    
    ->         (SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t2,    
    ->         (SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t3,    
    ->         (SELECT 0 i UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) t4) v   
    ->       WHERE selected_date BETWEEN '2018-08-01' AND '2018-08-31') AS time_period ORDER BY selected_date;
Query OK, 0 rows affected (0.02 sec)

mysql> SELECT * FROM dates;
+------------+
| cur_date   |
+------------+
| 2018-08-01 |
| 2018-08-02 |
| 2018-08-03 |
| 2018-08-04 |
| 2018-08-05 |
| 2018-08-06 |
| 2018-08-07 |
| 2018-08-08 |
| 2018-08-09 |
| 2018-08-10 |
| 2018-08-11 |
| 2018-08-12 |
| 2018-08-13 |
| 2018-08-14 |
| 2018-08-15 |
| 2018-08-16 |
| 2018-08-17 |
| 2018-08-18 |
| 2018-08-19 |
| 2018-08-20 |
| 2018-08-21 |
| 2018-08-22 |
| 2018-08-23 |
| 2018-08-24 |
| 2018-08-25 |
| 2018-08-26 |
| 2018-08-27 |
| 2018-08-28 |
| 2018-08-29 |
| 2018-08-30 |
| 2018-08-31 |
+------------+
31 rows in set (0.12 sec)

mysql> CREATE ALGORITHM = TEMPTABLE VIEW dates_from_users AS 
    ->   SELECT 
    ->     DATE(created_at) AS created_at_date,
    ->     1 AS flag
    ->   FROM users GROUP BY created_at_date, flag;
Query OK, 0 rows affected (0.03 sec)

mysql> SELECT * FROM dates_from_users;
+-----------------+------+
| created_at_date | flag |
+-----------------+------+
| 2018-08-01      |    1 |
| 2016-08-04      |    1 |
| 2018-08-16      |    1 |
| 2018-08-17      |    1 |
| 2020-03-15      |    1 |
+-----------------+------+
5 rows in set (0.00 sec)

mysql> SELECT * FROM users;
+----+------------------+-------------+---------------------+---------------------+
| id | name             | birthday_at | created_at          | updated_at          |
+----+------------------+-------------+---------------------+---------------------+
|  1 | Геннадий         | 1990-10-05  | 2018-08-01 00:00:00 | 2020-05-19 14:48:02 |
|  2 | Arty             | 1990-05-20  | 2016-08-04 00:00:00 | 2020-05-19 14:49:13 |
|  3 | Alex             | 2000-11-11  | 2018-08-16 00:00:00 | 2020-05-19 14:49:27 |
|  4 | Ivan             | 2005-07-29  | 2018-08-17 00:00:00 | 2020-05-19 14:49:30 |
|  5 | Georg            | 1997-01-15  | 2020-03-15 23:00:00 | 2020-04-15 23:00:00 |
+----+------------------+-------------+---------------------+---------------------+
5 rows in set (0.00 sec)

mysql> SELECT d.cur_date, IFNULL(dfu.flag,0) FROM dates d LEFT JOIN dates_from_users dfu ON d.cur_date = dfu.created_at_date ORDER BY cur_date;
+------------+--------------------+
| cur_date   | IFNULL(dfu.flag,0) |
+------------+--------------------+
| 2018-08-01 |                  1 |
| 2018-08-02 |                  0 |
| 2018-08-03 |                  0 |
| 2018-08-04 |                  0 |
| 2018-08-05 |                  0 |
| 2018-08-06 |                  0 |
| 2018-08-07 |                  0 |
| 2018-08-08 |                  0 |
| 2018-08-09 |                  0 |
| 2018-08-10 |                  0 |
| 2018-08-11 |                  0 |
| 2018-08-12 |                  0 |
| 2018-08-13 |                  0 |
| 2018-08-14 |                  0 |
| 2018-08-15 |                  0 |
| 2018-08-16 |                  1 |
| 2018-08-17 |                  1 |
| 2018-08-18 |                  0 |
| 2018-08-19 |                  0 |
| 2018-08-20 |                  0 |
| 2018-08-21 |                  0 |
| 2018-08-22 |                  0 |
| 2018-08-23 |                  0 |
| 2018-08-24 |                  0 |
| 2018-08-25 |                  0 |
| 2018-08-26 |                  0 |
| 2018-08-27 |                  0 |
| 2018-08-28 |                  0 |
| 2018-08-29 |                  0 |
| 2018-08-30 |                  0 |
| 2018-08-31 |                  0 |
+------------+--------------------+
31 rows in set (0.10 sec)

-- Задача 4.
/*
 * Пусть имеется любая таблица с календарным полем created_at. С
 * оздайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.
 */

mysql> CREATE ALGORITHM = TEMPTABLE VIEW rows_to_save AS SELECT * FROM users ORDER BY created_at DESC LIMIT 5;
Query OK, 0 rows affected (0.02 sec)

mmysql> DELETE FROM users WHERE id NOT IN (SELECT id FROM rows_to_save);
Query OK, 3 rows affected (0.03 sec)
