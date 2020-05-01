USE vk;
SELECT @@VERSION;
SELECT VERSION();

SELECT * FROM users LIMIT 20;

UPDATE users SET updated_at = CURRENT_TIMESTAMP WHERE created_at > updated_at;

DESC profiles;

SELECT * FROM profiles LIMIT 10;

SELECT * FROM messages LIMIT 20;

DESC messages;

SELECT COUNT(*) FROM users;

SELECT FLOOR(1 + RAND() * 200);

UPDATE messages SET
  from_user_id = FLOOR(1 + RAND() * 200),
  to_user_id = FLOOR(1 + RAND() * 200);

SELECT COUNT(*) FROM messages;
 
SELECT * FROM messages LIMIT 20;

DESC media;

SELECT * FROM media_types;

TRUNCATE media_types;

DELETE FROM media_types;

INSERT INTO media_types (name) VALUES
  ('photo'),
  ('video'),
  ('audio');
  
SELECT * FROM media LIMIT 10;

UPDATE media SET
  media_type_id = FLOOR(1 + RAND() * 3); 

UPDATE media SET
  user_id = FLOOR(1 + RAND() * 200); 

UPDATE media SET filename = CONCAT('https://dropbox.com/vk/',filename); 

SELECT * FROM messages WHERE from_user_id = to_user_id;

UPDATE messages SET
  from_user_id = FLOOR(1 + RAND() * 200),
  to_user_id = FLOOR(1 + RAND() * 200) WHERE from_user_id = to_user_id;

CREATE TEMPORARY TABLE exts(name VARCHAR(10));

INSERT INTO exts VALUES ('gif'), ('avi'), ('jpeg');

SELECT * FROM exts;

SELECT name FROM exts ORDER BY RAND() LIMIT 1;

UPDATE media SET filename =
  CONCAT(
    filename,
    '.',
    (SELECT name FROM exts ORDER BY RAND() LIMIT 1));

UPDATE media SET file_size = FLOOR(10000 + RAND() + 1000000) WHERE file_size < 1000;

UPDATE media SET metadata = CONCAT(
  '{"owner":"',
  (SELECT CONCAT(first_name,' ',last_name) FROM users WHERE id = user_id),
  '"}'
);

DESC media;

ALTER TABLE media MODIFY COLUMN metadata JSON;

SELECT * FROM friendship LIMIT 10;

UPDATE friendship SET
  user_id = FLOOR(1 + RAND() * 200),
  friend_id = FLOOR(1 + RAND() * 200 ); 

SELECT * FROM friendship WHERE user_id = friend_id;

SELECT * FROM friendship_statuses fs ;

TRUNCATE friendship_statuses;

INSERT INTO friendship_statuses (name) VALUES
  ('Requested'),
  ('Confirmed'),
  ('Rejected');

UPDATE friendship SET
  status_id = FLOOR(1 + RAND() * 3); 

UPDATE friendship SET confirmet_at = CURRENT_TIMESTAMP WHERE requested_at > confirmet_at ;

SELECT * FROM communities c ;

DELETE FROM communities WHERE id > 20;

UPDATE communities_users SET
 community_id = FLOOR(1 + RAND() * 20); 

SELECT * FROM communities_users cu ;

ALTER TABLE messages MODIFY COLUMN community_id INT UNSIGNED;

DESC messages;

ALTER TABLE messages MODIFY COLUMN to_user_id INT UNSIGNED;









