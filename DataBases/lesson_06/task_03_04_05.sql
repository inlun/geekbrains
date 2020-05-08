-- 3. Подсчитать общее количество лайков десяти самым молодым пользователям (сколько лайков получили 10 самых молодых пользователей).
-- (посчитаем лайки пользователям c учетом лайков их постов, медиафайлов и сообщений) 
SELECT 
  user_id,
  (SELECT CONCAT(first_name,' ',last_name) FROM users WHERE users.id = profiles.user_id) AS name,
  TIMESTAMPDIFF(YEAR,birthday,NOW()) AS age,
  (
    SELECT COUNT(*) FROM likes 
    WHERE 
      (target_type_id = (SELECT id FROM target_types WHERE name = 'users') 
        AND profiles.user_id = likes.target_id)
      OR (target_type_id = (SELECT id FROM target_types WHERE name = 'messages') 
        AND target_id IN (SELECT id FROM messages WHERE messages.from_user_id = profiles.user_id))
      OR (target_type_id = (SELECT id FROM target_types WHERE name = 'posts') 
        AND target_id IN (SELECT id FROM posts WHERE posts.user_id = profiles.user_id))
      OR (target_type_id = (SELECT id FROM target_types WHERE name = 'media') 
        AND target_id IN (SELECT id FROM media WHERE media.user_id = profiles.user_id))
  ) AS likes_count
FROM profiles 
ORDER BY age LIMIT 10;

-- 4.Определить кто больше поставил лайков (всего) - мужчины или женщины
SELECT 
  COUNT(id), 
  (SELECT gender FROM profiles p WHERE p.user_id = l.user_id) AS gender 
FROM likes l
GROUP BY gender;

-- 5. Найти 10 пользователей, которые проявляют наименьшую активность в
-- использовании социальной сети
-- (посчитаем общую сумму количества лайков, которые поставил пользователь, количества постов, сообщений и медиафайлов пользователя и найдем наименьшие)
SELECT 
  user_id,
  (SELECT CONCAT(first_name,' ',last_name) FROM users WHERE users.id = profiles.user_id) AS name,
  (
    SELECT COUNT(*) FROM likes 
    WHERE 
      likes.user_id = profiles.user_id 
      OR (target_type_id = (SELECT id FROM target_types WHERE name = 'messages') 
        AND target_id IN (SELECT id FROM messages WHERE messages.from_user_id = profiles.user_id))
      OR (target_type_id = (SELECT id FROM target_types WHERE name = 'posts') 
        AND target_id IN (SELECT id FROM posts WHERE posts.user_id = profiles.user_id))
      OR (target_type_id = (SELECT id FROM target_types WHERE name = 'media') 
        AND target_id IN (SELECT id FROM media WHERE media.user_id = profiles.user_id))
  ) AS likes_count
FROM profiles
ORDER BY likes_count
LIMIT 10;




