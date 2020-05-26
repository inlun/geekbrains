-- Задача 1.
/*
 * Проанализировать какие запросы могут выполняться наиболее часто в процессе работы приложения и добавить необходимые индексы.
 */
SHOW TABLES;

DESC communities;
DESC communities_users;
DESC friendship;
DESC friendship_statuses;
DESC likes;
DESC media;
DESC media_types;
DESC messages;
DESC posts;
DESC profiles;
DESC target_types;
DESC users;

-- для поиска пользователей по имени или фамилии пригодятся соответствующие индексы

CREATE INDEX users_first_name_idx ON users(first_name);

CREATE INDEX users_last_name_idx ON users(last_name);

-- для просмотра лайков у объекта пригодится индекс по  target_type_id и taret_id таблицы likes

CREATE INDEX likes_target_type_id_target_id_idx ON likes(target_type_id, target_id);


-- Задача 2.
/*
 * Построить запрос, который будет выводить следующие столбцы:
 * имя группы
 * среднее количество пользователей в группах
 * самый молодой пользователь в группе
 * самый старший пользователь в группе
 * общее количество пользователей в группе
 * всего пользователей в системе
 * отношение в процентах (общее количество пользователей в группе / всего пользователей в системе) * 100
 */

SELECT DISTINCT 
  c.name,
  COUNT(cu.user_id) OVER () /(SELECT COUNT(c2.id) FROM communities c2) AS avg_users_in_grops,
  MIN(p.birthday) OVER w AS youngest,
  MAX(p.birthday) OVER w AS oldes,
  COUNT(cu.user_id ) OVER w AS users_count,
  (SELECT COUNT(*) FROM users) AS total_users,
  COUNT(cu.user_id ) OVER w / (SELECT COUNT(*) FROM users) * 100 AS ratio
FROM 
  communities_users cu
    JOIN communities c
      ON cu.community_id = c.id 
    LEFT JOIN profiles p
      ON cu.user_id = p.user_id
      WINDOW w AS (PARTITION BY cu.community_id);
