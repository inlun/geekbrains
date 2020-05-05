/*
 * Подсчитайте средний возраст пользователей в таблице users
 */
SELECT
  AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())) AS age
FROM 
  users;
  
 /*
  * Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
  * Следует учесть, что необходимы дни недели текущего года, а не года рождения.
  */
 
SELECT 
  DATE_FORMAT(DATE(CONCAT_WS('-',YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day,
  COUNT(*) AS total
FROM users
GROUP BY 
  day 
ORDER BY 
  total DESC;
  
 /*
  * Подсчитайте произведение чисел в столбце таблицы
  */
 
 SELECT ROUND(EXP(SUM(LN(id)))) FROM catalogs;
 
 