-- Задача 1.
/*
* Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
* С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
* с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
*/
mysql> CREATE FUNCTION hello()
    ->   RETURNS TEXT NO SQL
    ->   BEGIN
    ->     DECLARE diff TIME;
    ->     SET diff = TIMEDIFF(TIME(NOW()),TIME(DATE(NOW())));
    ->     IF TIME('00:00:00') <= diff < TIME('06:00:00') THEN
    ->       RETURN 'Доброй ночи';
    ->     ELSEIF TIME('06:00:00') <= diff < TIME('12:00:00') THEN
    ->       RETURN 'Доброе утро';
    ->     ELSEIF TIME('12:00:00') <= diff < TIME('18:00:00') THEN
    ->       RETURN 'Добрый день';
    ->     ELSE
    ->       RETURN 'Добрый вечер';
    ->     END IF;
    -> END//
Query OK, 0 rows affected (0.01 sec)

mysql> SELECT hello()//
+-----------------------+
| hello()               |
+-----------------------+
| Доброй ночи           |
+-----------------------+
1 row in set (0.00 sec)


-- Задача 2.
/*
 * В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
 * Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
 * Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
 * При попытке присвоить полям NULL-значение необходимо отменить операцию.
 */

mysql> CREATE TRIGGER chek_name_description_insert BEFORE INSERT ON products
    ->   FOR EACH ROW
    ->   BEGIN
    ->     IF NEW.name IS NULL AND NEW.description IS NULL THEN
    ->       SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT canceled name = NULL and description = NULL';
    ->     END IF;
    ->   END
    -> //
Query OK, 0 rows affected (0.03 sec)

mysql> CREATE TRIGGER chek_name_description_update BEFORE UPDATE ON products
    ->   FOR EACH ROW
    ->   BEGIN
    ->     IF NEW.name IS NULL AND NEW.description IS NULL THEN
    ->       SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT canceled name = NULL and description = NULL';
    ->     END IF;
    ->   END
    -> //
Query OK, 0 rows affected (0.02 sec)

mysql> INSERT INTO products                                                                                                                                                                                       ->   (name, description, price)
    -> VALUES
    ->   ('test','test',3500)//
Query OK, 1 row affected (0.01 sec)

mysql> INSERT INTO products
    ->   (price)
    -> VALUES
    ->   (2000)//
ERROR 1644 (45000): INSERT canceled name = NULL and description = NULL
mysql> UPDATE products
    -> SET
    ->   name = NULL
    ->   description = NULL
    -> WHERE
    ->   id = 1//
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'description = NULL
WHERE
  id = 1' at line 4
mysql> UPDATE products
    -> SET
    ->   name = null,
    ->   description = null
    -> WHERE
    ->   id = 1//
ERROR 1644 (45000): INSERT canceled name = NULL and description = NULL


-- Задача 3.
/*
 * Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. 
 * Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел. 
 * Вызов функции FIBONACCI(10) должен возвращать число 55.
 */

mysql> CREATE FUNCTION fibonacci(num INT)
    -> RETURNS INT DETERMINISTIC
    -> BEGIN
    ->   DECLARE fib INT DEFAULT 0;
    ->   DECLARE counter INT DEFAULT 2;
    ->   DECLARE fib_1, fib_2 INT DEFAULT 1;
    ->   IF num = 1 OR num = 2 THEN
    ->     RETURN 1;
    ->   END IF;
    ->   WHILE counter < num DO
    ->     SET fib = fib_1 + fib_2;
    ->     SET fib_2 = fib_1;
    ->     SET fib_1 = fib;
    ->     SET counter = counter + 1;
    ->   END WHILE;
    -> RETURN fib;
    -> END
    -> 
    -> //
Query OK, 0 rows affected (0.03 sec)

mysql> SELECT fibonacci(0)//
+--------------+
| fibonacci(0) |
+--------------+
|            0 |
+--------------+
1 row in set (0.00 sec)

mysql> SELECT fibonacci(1)//
+--------------+
| fibonacci(1) |
+--------------+
|            1 |
+--------------+
1 row in set (0.00 sec)

mysql> SELECT fibonacci(2)//
+--------------+
| fibonacci(2) |
+--------------+
|            1 |
+--------------+
1 row in set (0.00 sec)

mysql> SELECT fibonacci(3)//
+--------------+
| fibonacci(3) |
+--------------+
|            2 |
+--------------+
1 row in set (0.00 sec)

mysql> SELECT fibonacci(4)//
+--------------+
| fibonacci(4) |
+--------------+
|            3 |
+--------------+
1 row in set (0.00 sec)

mysql> SELECT fibonacci(5)//
+--------------+
| fibonacci(5) |
+--------------+
|            5 |
+--------------+
1 row in set (0.00 sec)

mysql> SELECT fibonacci(6)//
+--------------+
| fibonacci(6) |
+--------------+
|            8 |
+--------------+
1 row in set (0.00 sec)

mysql> SELECT fibonacci(7)//
+--------------+
| fibonacci(7) |
+--------------+
|           13 |
+--------------+
1 row in set (0.00 sec)

mysql> SELECT fibonacci(9)//
+--------------+
| fibonacci(9) |
+--------------+
|           34 |
+--------------+
1 row in set (0.00 sec)

mysql> SELECT fibonacci(10)//
+---------------+
| fibonacci(10) |
+---------------+
|            55 |
+---------------+
1 row in set (0.00 sec)

mysql> 
