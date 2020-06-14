CREATE DATABASE boarding_house;

USE boarding_house;

DROP TABLE IF EXISTS properties;
CREATE TABLE IF NOT EXISTS properties (
  id SERIAL PRIMARY KEY,
  name VARCHAR(200) NOT NULL DEFAULT 'без названия' COMMENT 'название объекта',
  floors_number TINYINT NOT NULL DEFAULT 0 COMMENT 'колечество этажей',
  rooms_number INT NOT NULL DEFAULT 0 COMMENT 'количесвто комнат',
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);

DROP TABLE IF EXISTS rooms;
CREATE TABLE IF NOT EXISTS rooms (
  id SERIAL PRIMARY KEY,
  property_id BIGINT UNSIGNED NOT NULL COMMENT 'объект',
  floor INT UNSIGNED NOT NULL COMMENT 'этаж',
  room VARCHAR(50) COMMENT 'номер комнаты',
  beds_number INT UNSIGNED NOT NULL COMMENT 'количество спальных мест',
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW(),
  PRIMARY KEY (property_id, floor_number, room_number)
);

DROP TABLE IF EXISTS persons;
CREATE TABLE IF NOT EXISTS persons (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(100) COMMENT 'имя',
  last_name VARCHAR(100) COMMENT 'фамилия',
  middle_name VARCHAR(100) COMMENT 'отчество',
  snils BIGINT UNIQUE COMMENT 'СНИЛС',
  gender ENUM('male','female') NOT NULL,
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);

DROP TABLE IF EXISTS document_data;
CREATE TABLE IF NOT EXISTS document_data (
  person_id BIGINT UNSIGNED,
  document_type_id BIGINT UNSIGNED COMMENT 'тип документа',
  number VARCHAR(25) COMMENT 'номер документа',
  active BOOLEAN DEFAULT TRUE,
  issue_place TINYTEXT COMMENT 'место выдачи',
  issue_date DATE COMMENT 'дата выдачи',
  division_code INT COMMENT 'код подразделения',
  birth_date DATE COMMENT 'дата рождения',
  birth_place VARCHAR(250) COMMENT 'место рождения',
  created_at DATETIME DEFAULT NOW(),
  updated_at DATETIME DEFAULT NOW() ON UPDATE NOW()
);

DROP TABLE IF EXISTS document_types;
CREATE TABLE IF NOT EXISTS document_types (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) COMMENT 'название документа'
);

DROP TABLE IF EXISTS boarders;
CREATE TABLE IF NOT EXISTS boarders (
  room_id
)



