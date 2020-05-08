INSERT INTO orders(user_id) VALUES (6),(5),(3),(3),(4);

-- Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

SELECT 
  users.id, 
  name 
FROM 
  users 
JOIN 
  orders 
ON users.id =orders.user_id 
GROUP BY users.id, name;

-- Выведите список товаров products и разделов catalogs, который соответствует товару

SELECT 
  p.name AS product_name,
  c.name AS catalog_name
FROM 
  products p 
LEFT JOIN
  catalogs c
ON
  p.catalog_id = c.id;

-- Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
-- Поля from, to и label содержат английские названия городов, поле name — русское. 
-- Выведите список рейсов flights с русскими названиями городов.

CREATE TABLE IF NOT EXISTS cities(
  label VARCHAR(255) NOT NULL PRIMARY KEY,
  name VARCHAR(255)
);

INSERT INTO cities (label, name) VALUES
  ('Moscow', 'МОСКВА'),
  ('Yaroslavl', 'ЯРОСЛАВЛЬ'),
  ('Tula', 'ТУЛА'),
  ('Vladivostok', 'ВЛАДИВОСТОК');

CREATE TABLE IF NOT EXISTS flights(
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  from_city VARCHAR(255),
  to_city VARCHAR(255) 
);

INSERT INTO flights (from_city, to_city) VALUES
  ('Moscow','Yaroslavl'),
  ('Yaroslavl','Vladivostok'),
  ('Moscow','Tula'),
  ('Vladivostok','Moscow'),
  ('Vladivostok','Tula'),
  ('Moscow','Vladivostok')

SELECT
  id,
  f.name AS from_city,
  t.name AS to_city
FROM
  flights
LEFT JOIN
  cities f ON from_city = f.label
LEFT JOIN
  cities t ON to_city = t.label;
