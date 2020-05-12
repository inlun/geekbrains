-- 3. Подсчитать общее количество лайков десяти самым молодым пользователям (сколько лайков получили 10 самых молодых пользователей).
-- (посчитаем лайки пользователям c учетом лайков их постов, медиафайлов и сообщений) 

-- Совсем без вложенных запросов сделать не получилось.

SELECT 
  pf.user_id AS id,
  pf.birthday,
  CONCAT(usr.first_name ,' ',usr.last_name) AS name, 
  SUM(likes_owners.liked) AS likes
FROM profiles pf
  LEFT JOIN users usr
    ON pf.user_id = usr.id 
  LEFT JOIN 
    (SELECT
	  1 AS liked,
      CASE 
        WHEN l.target_type_id = '1'
	      THEN u_m.id 
	    WHEN l.target_type_id = '2'
	      THEN u.id 
	    WHEN l.target_type_id = '3'
	      THEN u_ma.id 
	    WHEN l.target_type_id = '4'
	      THEN u_p.id 
	  END AS owner
	FROM likes l
	  LEFT JOIN messages m
	    ON l.target_id = m.id AND l.target_type_id = '1'
	    LEFT JOIN users u_m
	      ON m.from_user_id = u_m.id
	  LEFT JOIN media ma
	    ON l.target_id = ma.id AND l.target_type_id = '3'
	    LEFT JOIN users u_ma
	      ON ma.user_id = u_ma.id
	  LEFT JOIN posts p
	    ON l.target_id = p.id AND l.target_type_id = '4'
	    LEFT JOIN users u_p
	      ON p.user_id = u_p.id
	  LEFT JOIN users u
	    ON l.target_id = u.id AND l.target_type_id = '2') AS likes_owners ON pf.user_id = likes_owners.owner
GROUP BY pf.user_id
ORDER BY pf.birthday DESC LIMIT 10;

-- 4.Определить кто больше поставил лайков (всего) - мужчины или женщины
SELECT 
  COUNT(id), 
  p.gender AS gender 
FROM likes l
  JOIN profiles p
    ON l.user_id = p.user_id 
GROUP BY gender;

-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в
-- использовании социальной сети
-- (посчитаем общую сумму количества лайков, которые поставил пользователь, количества постов, сообщений и медиафайлов пользователя и найдем наименьшие)

-- Опять же как и в 3-й задаче, не могу собрать запрос полностью без вложенных запросов
SELECT
  params.u_id,
  params.name,
  COUNT(param) AS param 
FROM 
	(
	SELECT
	  u.id AS u_id,
	  CONCAT(u.first_name,' ',u.last_name) AS name,
	  COUNT(l.id) AS param
	FROM users u
	  LEFT JOIN likes l 
	    ON u.id = l.user_id 
	GROUP BY u_id
	UNION
	SELECT
	  u.id AS u_id,
	  CONCAT(u.first_name,' ',u.last_name) AS name,
	  COUNT(m.id) AS param
	FROM users u
	  LEFT JOIN messages m 
	    ON u.id = m.from_user_id 
	GROUP BY u_id
	UNION
	SELECT
	  u.id AS u_id,
	  CONCAT(u.first_name,' ',u.last_name) AS name,
	  COUNT(p.id) AS param
	FROM users u
	  LEFT JOIN posts p 
	    ON u.id = p.user_id
	GROUP BY u_id
	UNION
	SELECT
	  u.id AS u_id,
	  CONCAT(u.first_name,' ',u.last_name) AS name,
	  COUNT(ma.id) AS param
	FROM users u
	  LEFT JOIN media ma 
	    ON u.id = ma.user_id
	GROUP BY u_id	
	) AS params
GROUP BY params.u_id, params.name
ORDER BY param;
