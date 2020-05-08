SHOW tables;

SELECT * FROM users;
SELECT * FROM target_types;
SELECT * FROM profiles;
SELECT * FROM media_types;
SELECT * FROM posts;
SELECT * FROM communities;
SELECT * FROM media;
SELECT * FROM messages;
SELECT * FROM likes;
SELECT * FROM friendship;
SELECT * FROM friendship_statuses;
SELECT * FROM communities_users;

-- Переделаем photo_id чтобыссылался только на фото, причем только на те фото, владельцем которых является пользователь, 
-- т.к. сейчас он ссылается на различные типы медиа 
UPDATE 
  profiles
SET
  photo_id = 
  (SELECT id FROM media WHERE media_type_id = 
    (SELECT id FROM media_types WHERE name = "photo") AND media.user_id = profiles.user_id ORDER BY RAND() LIMIT 1);

-- Случайным образом очистим часть community_id, т.к. посты могут быть не только в группе
UPDATE posts SET community_id = NULL 
  WHERE community_id >  FLOOR(1 + RAND() * 20);
 
-- Случайным образом очистим media_id, т.к. посты могут быть без медиафайлов
UPDATE posts SET media_id = NULL 
  WHERE media_id >  FLOOR(1 + RAND() * 200);
 
-- Заменим группы на корректные для отправителя поста    
UPDATE posts SET community_id = 
  (SELECT community_id FROM communities_users
    WHERE communities_users.user_id = posts.user_id ORDER BY RAND() LIMIT 1)
  WHERE community_id IS NOT NULL;    

-- Случайным образом очистим часть community_id
UPDATE messages SET community_id = NULL 
  WHERE community_id >  FLOOR(1 + RAND() * 20);   
  
-- Случайным образом очистим часть to_user_id  
UPDATE messages SET to_user_id = NULL 
  WHERE to_user_id >  FLOOR(1 + RAND() * 200)
    AND community_id IS not NULL;  

-- Заменим группы на корректные для отправителя сообщения    
UPDATE messages SET community_id = 
  (SELECT community_id FROM communities_users
    WHERE communities_users.user_id = messages.from_user_id ORDER BY RAND() LIMIT 1)
  WHERE community_id IS NOT NULL;    
  
-- Заменим получателя на пользователя из той-же группы что и отправитель  
UPDATE messages SET to_user_id = 
  (SELECT user_id FROM communities_users
    WHERE communities_users.community_id = messages.community_id ORDER BY RAND() LIMIT 1)
  WHERE community_id IS NOT NULL; 

-- Случайным образом заполним target_type_id т.к. неверно сгенерировал на сайте
UPDATE likes SET target_type_id = FLOOR(1 + RAND() * 4);

-- Проверим ссылки на несущаствующие записи в таблицах по target_id
SELECT * FROM likes 
WHERE 
  target_type_id = (SELECT id FROM target_types WHERE name = 'messages')
  AND (SELECT id FROM messages WHERE messages.id = likes.target_id) IS NULL;
   
SELECT * FROM likes 
WHERE 
  target_type_id = (SELECT id FROM target_types WHERE name = 'users')
  AND (SELECT id FROM users WHERE users.id = likes.target_id) IS NULL;

SELECT * FROM likes 
WHERE 
  target_type_id = (SELECT id FROM target_types WHERE name = 'posts')
  AND (SELECT id FROM posts WHERE posts.id = likes.target_id) IS NULL;

SELECT * FROM likes 
WHERE 
  target_type_id = (SELECT id FROM target_types WHERE name = 'media')
  AND (SELECT id FROM media WHERE media.id = likes.target_id) IS NULL;

 
 
 
   
   
   
   
   
   
   
   
   
   
   
   
 

